use axum::extract::State;
use axum::Json;
use serde::Serialize;

use crate::api::routes::AppState;

#[derive(Serialize)]
pub struct Metric {
    pub name: String,
    pub value: f64,
}

#[derive(Serialize)]
pub struct MetricsResponse {
    pub metrics: Vec<Metric>,
}

pub async fn get_metrics(State(_state): State<AppState>) -> Json<MetricsResponse> {
    Json(MetricsResponse {
        metrics: vec![
            Metric {
                name: "uptime_seconds".into(),
                value: crate::api::routes::health::START_TIME
                    .elapsed()
                    .as_secs_f64(),
            },
            Metric {
                name: "version_info".into(),
                value: 1.0,
            },
        ],
    })
}
