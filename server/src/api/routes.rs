use axum::routing::{get, post};
use axum::Router;

use crate::core::EventBus;
use crate::storage::DbPool;

use super::ws;

mod config;
pub(crate) mod health;
mod logs;
mod media;
mod metrics;
mod plugins;
mod status;
mod users;

pub fn router(event_bus: EventBus, db_pool: DbPool) -> Router {
    let state = AppState { event_bus, db_pool };

    Router::new()
        .route("/health", get(health::health_check))
        .route("/status", get(status::get_status))
        .route("/config", get(config::get_config))
        .route("/users", get(users::list).post(users::create))
        .route("/users/:id", get(users::get).put(users::update))
        .route("/users/:id/delete", post(users::delete))
        .route("/media", get(media::list))
        .route("/media/:id", get(media::get))
        .route("/media/scan", post(media::scan))
        .route("/logs", get(logs::list))
        .route("/metrics", get(metrics::get_metrics))
        .route("/plugins", get(plugins::list).post(plugins::toggle))
        .route("/ws", get(ws::ws_handler))
        .with_state(state)
}

#[derive(Clone)]
pub struct AppState {
    pub event_bus: EventBus,
    pub db_pool: DbPool,
}
