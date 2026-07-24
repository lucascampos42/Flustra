use axum::extract::State;
use axum::Json;
use serde_json::Value;

use crate::api::routes::AppState;

pub async fn get_config(State(_state): State<AppState>) -> Json<Value> {
    let cfg = crate::APP_CONFIG.read().unwrap();
    Json(serde_json::to_value(&*cfg).unwrap_or_default())
}
