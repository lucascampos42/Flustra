use axum::extract::State;
use axum::Json;
use serde::Serialize;
use std::sync::atomic::{AtomicU64, Ordering};

use crate::core::EventBus;

static TOTAL_REQUESTS: AtomicU64 = AtomicU64::new(0);

#[derive(Serialize)]
pub struct StatusResponse {
    pub status: &'static str,
    pub version: &'static str,
    pub uptime_secs: u64,
    pub total_requests: u64,
}

pub async fn get_status(State(_event_bus): State<EventBus>) -> Json<StatusResponse> {
    Json(StatusResponse {
        status: "running",
        version: env!("CARGO_PKG_VERSION"),
        uptime_secs: crate::api::routes::health::START_TIME.elapsed().as_secs(),
        total_requests: TOTAL_REQUESTS.load(Ordering::Relaxed),
    })
}
