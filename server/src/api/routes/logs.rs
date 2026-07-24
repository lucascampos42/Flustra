use axum::extract::{Query, State};
use axum::Json;
use serde::{Deserialize, Serialize};

use crate::api::routes::AppState;

#[derive(Serialize)]
pub struct LogEntry {
    pub timestamp: String,
    pub level: String,
    pub message: String,
}

#[derive(Deserialize)]
#[expect(dead_code)]
pub struct ListLogsParams {
    pub level: Option<String>,
    pub search: Option<String>,
    pub limit: Option<i32>,
    pub offset: Option<i32>,
}

#[derive(Serialize)]
pub struct ListLogsResponse {
    pub entries: Vec<LogEntry>,
    pub total: i32,
}

pub async fn list(
    State(_state): State<AppState>,
    Query(_params): Query<ListLogsParams>,
) -> Json<ListLogsResponse> {
    Json(ListLogsResponse {
        entries: vec![],
        total: 0,
    })
}
