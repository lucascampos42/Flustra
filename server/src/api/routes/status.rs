use axum::extract::State;
use axum::Json;
use serde::Serialize;

use crate::api::routes::AppState;

#[derive(Serialize)]
pub struct StatusResponse {
    pub status: &'static str,
    pub version: &'static str,
    pub uptime_secs: u64,
    pub db_type: String,
    pub active_sessions: u64,
    pub media_count: u64,
    pub user_count: u64,
}

pub async fn get_status(State(state): State<AppState>) -> Json<StatusResponse> {
    let db_type = state.db_pool.db_type().to_string();

    Json(StatusResponse {
        status: "running",
        version: env!("CARGO_PKG_VERSION"),
        uptime_secs: crate::api::routes::health::START_TIME.elapsed().as_secs(),
        db_type,
        active_sessions: 0,
        media_count: 0,
        user_count: 0,
    })
}
