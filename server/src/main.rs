use std::sync::Arc;

use anyhow::Result;
use clap::Parser;
use tracing::info;

use flustra_server::cli::{Cli, Commands, DbCommands};
use flustra_server::config::FlustraConfig;
use flustra_server::core::{EventBus, Runtime, Scheduler};
use flustra_server::logging;
use flustra_server::network::HttpServer;
use flustra_server::plugins::PluginManager;
use flustra_server::storage;
use flustra_server::APP_CONFIG;

fn main() -> Result<()> {
    let cli = Cli::parse();

    match cli.command {
        Some(Commands::Db(db)) => match db.command {
            DbCommands::Migrate { from, to } => {
                let rt = tokio::runtime::Runtime::new()?;
                rt.block_on(flustra_server::cli::migrate::run(&from, &to))?;
            }
        },
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

    let _db_pool = storage::init(&config.storage).await?;
    let _plugin_manager = PluginManager::new(event_bus.clone());
    let http_server = HttpServer::new(Arc::new(config.server), event_bus);

    info!("server initialized, starting HTTP listener");
    http_server.run().await
}
