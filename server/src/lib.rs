pub mod api;
pub mod cli;
pub mod cluster;
pub mod config;
pub mod core;
pub mod logging;
pub mod metrics;
pub mod network;
pub mod plugins;
pub mod security;
pub mod storage;

use std::sync::{Arc, RwLock};

use config::FlustraConfig;

pub static APP_CONFIG: std::sync::LazyLock<Arc<RwLock<FlustraConfig>>> =
    std::sync::LazyLock::new(|| Arc::new(RwLock::new(FlustraConfig::load(None).unwrap())));
