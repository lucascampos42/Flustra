use std::sync::Arc;

use anyhow::Result;
use clap::Parser;
use tracing::info;

use flustra_server::cli::{Cli, Commands, DbCommands};
use flustra_server::cluster::Cluster;
use flustra_server::config::FlustraConfig;
use flustra_server::core::{EventBus, Runtime, Scheduler};
use flustra_server::logging;
use flustra_server::network::HttpServer;
use flustra_server::plugins::PluginManager;
use flustra_server::storage;
use flustra_server::APP_CONFIG;

fn main() -> Result<()> {
    dotenvy::dotenv().ok();
    let cli = Cli::parse();

    match cli.command {
        Some(Commands::Db(db)) => match db.command {
            DbCommands::Migrate { from, to } => {
                let rt = tokio::runtime::Runtime::new()?;
                rt.block_on(flustra_server::cli::migrate::run(&from, &to))?;
            }
        },
        Some(Commands::ClusterHealth) => {
            let rt = tokio::runtime::Runtime::new()?;
            rt.block_on(print_cluster_health())?;
        }
        _ => {
            let mut config = FlustraConfig::load(None)?;
            config.override_from_env();

            {
                let mut app_config = APP_CONFIG.write().unwrap();
                *app_config = config.clone();
            }

            logging::init(&config.logging)?;

            let rt = Runtime::new(&config.server)?;
            rt.block_on(run_server(config))?;
        }
    }

    Ok(())
}

async fn print_cluster_health() -> Result<()> {
    let config = FlustraConfig::load(None)?;
    println!("Node ID:     {}", config.cluster.node_id);
    println!("Node Name:   {}", config.cluster.node_name);
    println!(
        "Cluster:     {}",
        if config.cluster.enabled {
            "enabled"
        } else {
            "disabled"
        }
    );
    println!("Peers:       {}", config.cluster.peers.len());
    for peer in &config.cluster.peers {
        println!("  - {} at {} ({})", peer.id, peer.address, peer.role);
    }
    Ok(())
}

async fn run_server(config: FlustraConfig) -> Result<()> {
    info!(
        version = env!("CARGO_PKG_VERSION"),
        "Flustra server starting"
    );

    let event_bus = EventBus::default();
    let scheduler = Scheduler::new(tokio::runtime::Handle::current());

    scheduler.every(std::time::Duration::from_secs(300), || async {
        tracing::debug!("scheduler tick");
    });

    let db_pool = storage::init(&config.storage).await?;
    let _plugin_manager = PluginManager::new(event_bus.clone());

    if config.cluster.enabled {
        let cluster = Cluster::new(config.cluster.clone(), event_bus.clone());
        cluster.start_gossip();

        if let Some(replica_url) = &config.cluster.replica_db_url {
            match flustra_server::cluster::ha::HaPool::new(
                &config.storage.db_url,
                Some(replica_url),
            )
            .await
            {
                Ok(ha) => {
                    info!("HA pool initialized with replica");
                    std::mem::drop(ha);
                }
                Err(e) => {
                    tracing::warn!("failed to init HA pool: {}", e);
                }
            }
        }

        info!(
            cluster_size = config.cluster.peers.len() + 1,
            "cluster mode enabled"
        );
    }

    let http_server = HttpServer::new(Arc::new(config.server), event_bus, db_pool);

    info!("server initialized, starting HTTP listener");
    http_server.run().await
}
