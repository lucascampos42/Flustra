use axum::extract::{Path, State};
use axum::Json;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

use crate::api::routes::AppState;

#[derive(Serialize)]
pub struct UserResponse {
    pub id: String,
    pub username: String,
    pub role: String,
}

#[derive(Deserialize)]
#[expect(dead_code)]
pub struct CreateUserRequest {
    pub username: String,
    pub password: String,
    #[serde(default = "default_role")]
    pub role: String,
}

#[derive(Deserialize)]
#[expect(dead_code)]
pub struct UpdateUserRequest {
    pub username: Option<String>,
    pub password: Option<String>,
    pub role: Option<String>,
}

#[derive(Serialize)]
pub struct DeleteResponse {
    pub status: &'static str,
}

fn default_role() -> String {
    "viewer".to_string()
}

pub async fn list(State(_state): State<AppState>) -> Json<Vec<UserResponse>> {
    Json(vec![])
}

pub async fn get(
    State(_state): State<AppState>,
    Path(_id): Path<Uuid>,
) -> Json<Option<UserResponse>> {
    Json(None)
}

pub async fn create(
    State(_state): State<AppState>,
    Json(_req): Json<CreateUserRequest>,
) -> Json<UserResponse> {
    Json(UserResponse {
        id: Uuid::new_v4().to_string(),
        username: String::new(),
        role: String::new(),
    })
}

pub async fn update(
    State(_state): State<AppState>,
    Path(_id): Path<Uuid>,
    Json(_req): Json<UpdateUserRequest>,
) -> Json<Option<UserResponse>> {
    Json(None)
}

pub async fn delete(State(_state): State<AppState>, Path(_id): Path<Uuid>) -> Json<DeleteResponse> {
    Json(DeleteResponse { status: "deleted" })
}
