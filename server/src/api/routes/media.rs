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

#[derive(sqlx::FromRow)]
struct MediaRow {
    id: String,
    title: String,
    path: String,
    media_type: String,
    size_bytes: i64,
}

pub async fn list(
    State(state): State<AppState>,
    Query(params): Query<ListMediaParams>,
) -> Json<ListMediaResponse> {
    let page = params.page.unwrap_or(1);
    let page_size = params.page_size.unwrap_or(50);
    let offset = ((page - 1) * page_size) as i64;

    let items: Vec<MediaItemResponse> = match &state.db_pool {
        crate::storage::DbPool::Sqlite(pool) => {
            sqlx::query_as::<_, MediaRow>(
                "SELECT id, title, path, media_type, size_bytes FROM media_items LIMIT ? OFFSET ?"
            )
            .bind(page_size as i64)
            .bind(offset)
            .fetch_all(pool)
            .await
            .unwrap_or_default()
            .into_iter()
            .map(|row| MediaItemResponse {
                id: row.id,
                title: row.title,
                path: row.path,
                media_type: row.media_type,
                size_bytes: row.size_bytes,
            })
            .collect()
        }
        crate::storage::DbPool::Postgres(pool) => {
            sqlx::query_as::<_, MediaRow>(
                "SELECT id::text as id, title, path, media_type, size_bytes FROM media_items LIMIT $1 OFFSET $2"
            )
            .bind(page_size as i64)
            .bind(offset)
            .fetch_all(pool)
            .await
            .unwrap_or_default()
            .into_iter()
            .map(|row| MediaItemResponse {
                id: row.id,
                title: row.title,
                path: row.path,
                media_type: row.media_type,
                size_bytes: row.size_bytes,
            })
            .collect()
        }
    };

    let total = items.len() as i64;

    Json(ListMediaResponse {
        items,
        total,
        page,
        page_size,
    })
}

pub async fn get(
    State(state): State<AppState>,
    Path(id): Path<Uuid>,
) -> Json<Option<MediaItemResponse>> {
    let id_str = id.to_string();
    let item = match &state.db_pool {
        crate::storage::DbPool::Sqlite(pool) => {
            sqlx::query_as::<_, MediaRow>(
                "SELECT id, title, path, media_type, size_bytes FROM media_items WHERE id = ?"
            )
            .bind(&id_str)
            .fetch_optional(pool)
            .await
            .ok()
            .flatten()
            .map(|row| MediaItemResponse {
                id: row.id,
                title: row.title,
                path: row.path,
                media_type: row.media_type,
                size_bytes: row.size_bytes,
            })
        }
        crate::storage::DbPool::Postgres(pool) => {
            sqlx::query_as::<_, MediaRow>(
                "SELECT id::text as id, title, path, media_type, size_bytes FROM media_items WHERE id = $1"
            )
            .bind(id)
            .fetch_optional(pool)
            .await
            .ok()
            .flatten()
            .map(|row| MediaItemResponse {
                id: row.id,
                title: row.title,
                path: row.path,
                media_type: row.media_type,
                size_bytes: row.size_bytes,
            })
        }
    };

    Json(item)
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
