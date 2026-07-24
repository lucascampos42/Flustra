use serde::Serialize;
use std::sync::Arc;

#[derive(Serialize)]
pub struct NodeHealth {
    pub node_id: String,
    pub status: &'static str,
    pub version: &'static str,
    pub uptime_secs: u64,
    pub is_leader: bool,
    pub alive_peers: usize,
    pub db_connected: bool,
}

pub struct HealthChecker {
    cluster: Arc<crate::cluster::Cluster>,
}

impl HealthChecker {
    pub fn new(cluster: Arc<crate::cluster::Cluster>) -> Self {
        Self { cluster }
    }

    pub fn node_health(&self) -> NodeHealth {
        let uptime = crate::api::routes::health::START_TIME.elapsed().as_secs();

        NodeHealth {
            node_id: self.cluster.self_id.clone(),
            status: "healthy",
            version: env!("CARGO_PKG_VERSION"),
            uptime_secs: uptime,
            is_leader: self.cluster.is_leader(),
            alive_peers: self.cluster.alive_peers().len(),
            db_connected: true,
        }
    }
}
