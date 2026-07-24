use axum::extract::State;
use axum::Json;
use serde::{Deserialize, Serialize};

use crate::api::routes::AppState;

#[derive(Serialize)]
pub struct PluginInfo {
    pub name: String,
    pub version: String,
    pub enabled: bool,
}

#[derive(Deserialize)]
#[expect(dead_code)]
pub struct TogglePluginRequest {
    pub name: String,
    pub enabled: bool,
}

pub async fn list(State(_state): State<AppState>) -> Json<Vec<PluginInfo>> {
    Json(vec![])
}

pub async fn toggle(
    State(_state): State<AppState>,
    Json(_req): Json<TogglePluginRequest>,
) -> Json<PluginInfo> {
    Json(PluginInfo {
        name: String::new(),
        version: String::new(),
        enabled: false,
    })
}
