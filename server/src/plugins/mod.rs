use std::sync::Arc;

use dashmap::DashMap;
use tracing::{debug, info};

use crate::config::PluginsConfig;
use crate::core::EventBus;

pub trait Plugin: Send + Sync {
    fn name(&self) -> &'static str;
    fn version(&self) -> &'static str;
    fn init(&self, event_bus: EventBus) -> anyhow::Result<()>;
    fn shutdown(&self) {}
}

pub struct PluginManager {
    plugins: Arc<DashMap<String, Box<dyn Plugin>>>,
    event_bus: EventBus,
}

impl PluginManager {
    pub fn new(event_bus: EventBus) -> Self {
        Self {
            plugins: Arc::new(DashMap::new()),
            event_bus,
        }
    }

    pub fn register(&self, plugin: Box<dyn Plugin>) -> anyhow::Result<()> {
        let name = plugin.name().to_string();
        plugin.init(self.event_bus.clone())?;
        self.plugins.insert(name.clone(), plugin);
        info!("plugin registered: {}", name);
        Ok(())
    }

    pub fn load_all(&self, _config: &PluginsConfig) {
        debug!("dynamic plugin loading not yet implemented");
    }

    pub fn shutdown_all(&self) {
        for entry in self.plugins.iter() {
            entry.shutdown();
        }
        self.plugins.clear();
        info!("all plugins shut down");
    }

    pub fn list(&self) -> Vec<String> {
        self.plugins.iter().map(|e| e.key().clone()).collect()
    }
}
