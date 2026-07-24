use axum::routing::get;
use axum::Router;

use crate::core::EventBus;

pub(crate) mod config;
pub(crate) mod health;
pub(crate) mod status;

pub fn router(event_bus: EventBus) -> Router {
    Router::new()
        .route("/health", get(health::health_check))
        .route("/status", get(status::get_status))
        .route("/config", get(config::get_config))
        .with_state(event_bus)
}
