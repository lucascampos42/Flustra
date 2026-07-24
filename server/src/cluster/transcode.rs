use chrono::Utc;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TranscodeJob {
    pub id: String,
    pub media_id: String,
    pub source_path: String,
    pub target_format: String,
    pub target_resolution: Option<String>,
    pub status: String,
    pub progress: f64,
    pub error_message: Option<String>,
    pub assigned_node: Option<String>,
    pub created_at: String,
    pub updated_at: String,
}

pub struct TranscodeQueue;

#[allow(clippy::new_without_default)]
impl TranscodeQueue {
    pub fn new() -> Self {
        Self
    }

    pub fn create_job(media_id: &str, source_path: &str, target_format: &str) -> TranscodeJob {
        let now = Utc::now().to_rfc3339();
        TranscodeJob {
            id: Uuid::new_v4().to_string(),
            media_id: media_id.to_string(),
            source_path: source_path.to_string(),
            target_format: target_format.to_string(),
            target_resolution: None,
            status: "pending".to_string(),
            progress: 0.0,
            error_message: None,
            assigned_node: None,
            created_at: now.clone(),
            updated_at: now,
        }
    }
}
