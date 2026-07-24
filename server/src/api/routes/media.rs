use axum::extract::{Path, Query, State};
use axum::Json;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

use crate::api::routes::AppState;

#[derive(Serialize)]
pub struct MediaItemResponse {
    pub id: String,
    pub title: String,
    pub path: String,
    pub media_type: String,
    pub size_bytes: i64,
}

#[derive(Deserialize)]
#[expect(dead_code)]
pub struct ListMediaParams {
    pub media_type: Option<String>,
    pub search: Option<String>,
    pub page: Option<i32>,
    pub page_size: Option<i32>,
}

#[derive(Serialize)]
pub struct ListMediaResponse {
    pub items: Vec<MediaItemResponse>,
    pub total: i64,
    pub page: i32,
    pub page_size: i32,
}

pub async fn list(
    State(_state): State<AppState>,
    Query(params): Query<ListMediaParams>,
) -> Json<ListMediaResponse> {
    Json(ListMediaResponse {
        items: vec![],
        total: 0,
        page: params.page.unwrap_or(1),
        page_size: params.page_size.unwrap_or(50),
    })
}

pub async fn get(
    State(_state): State<AppState>,
    Path(_id): Path<Uuid>,
) -> Json<Option<MediaItemResponse>> {
    Json(None)
}

#[derive(Serialize)]
pub struct ScanResponse {
    pub status: String,
    pub message: String,
}

pub async fn scan(State(state): State<AppState>) -> Json<ScanResponse> {
    state
        .event_bus
        .emit("media.scan.started", "full library scan");
    Json(ScanResponse {
        status: "started".to_string(),
        message: "Media scan initiated".to_string(),
    })
}
