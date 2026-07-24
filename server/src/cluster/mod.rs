use std::sync::Arc;

use dashmap::DashMap;
use tokio::time::{interval, Duration};
use tracing::{debug, warn};

use crate::config::ClusterConfig;
use crate::core::EventBus;

pub mod ha;
pub mod health;
pub mod transcode;

pub use health::HealthChecker;
pub use transcode::TranscodeQueue;

#[derive(Debug, Clone)]
pub struct PeerState {
    pub id: String,
    pub address: String,
    pub role: String,
    pub alive: bool,
    pub last_seen: u64,
    pub latency_ms: u64,
}

#[derive(Clone)]
pub struct Cluster {
    pub config: ClusterConfig,
    pub peers: Arc<DashMap<String, PeerState>>,
    pub self_id: String,
    #[expect(dead_code)]
    event_bus: EventBus,
}

impl Cluster {
    pub fn new(config: ClusterConfig, event_bus: EventBus) -> Self {
        let self_id = config.node_id.clone();
        let peers = Arc::new(DashMap::new());

        for peer in &config.peers {
            peers.insert(
                peer.id.clone(),
                PeerState {
                    id: peer.id.clone(),
                    address: peer.address.clone(),
                    role: peer.role.clone(),
                    alive: false,
                    last_seen: 0,
                    latency_ms: 0,
                },
            );
        }

        Self {
            config,
            peers,
            self_id,
            event_bus,
        }
    }

    pub fn is_leader(&self) -> bool {
        self.config.node_name == "primary"
    }

    pub fn alive_peers(&self) -> Vec<PeerState> {
        self.peers
            .iter()
            .filter(|e| e.alive)
            .map(|e| e.value().clone())
            .collect()
    }

    pub fn start_gossip(&self) {
        if !self.config.enabled || self.config.peers.is_empty() {
            return;
        }

        let peers = self.peers.clone();
        let interval_secs = self.config.gossip_interval_secs;

        tokio::spawn(async move {
            let mut ticker = interval(Duration::from_secs(interval_secs));
            loop {
                ticker.tick().await;
                for mut entry in peers.iter_mut() {
                    let start = std::time::Instant::now();
                    match reqwest::get(&format!("http://{}/api/health", entry.address)).await {
                        Ok(resp) if resp.status().is_success() => {
                            entry.alive = true;
                            entry.last_seen = std::time::SystemTime::now()
                                .duration_since(std::time::UNIX_EPOCH)
                                .unwrap()
                                .as_secs();
                            entry.latency_ms = start.elapsed().as_millis() as u64;
                            debug!("peer {} alive ({}ms)", entry.id, entry.latency_ms);
                        }
                        _ => {
                            entry.alive = false;
                            warn!("peer {} unreachable", entry.id);
                        }
                    }
                }
            }
        });
    }
}
