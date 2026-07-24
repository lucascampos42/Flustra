use sqlx::sqlite::SqlitePoolOptions;
use sqlx::{Pool, Postgres, Sqlite};
use tracing::info;

use crate::storage::detect_db_type;

#[derive(sqlx::FromRow)]
struct ConfigRow {
    id: i32,
    key: String,
    value: String,
    updated_at: String,
}

#[derive(sqlx::FromRow)]
struct UserRow {
    id: String,
    username: String,
    password_hash: String,
    role: String,
    created_at: String,
    updated_at: String,
}

#[derive(sqlx::FromRow)]
struct SessionRow {
    id: String,
    user_id: String,
    token: String,
    expires_at: String,
    created_at: String,
}

#[derive(sqlx::FromRow)]
struct MediaItemRow {
    id: String,
    title: String,
    path: String,
    media_type: String,
    size_bytes: i64,
    duration_secs: Option<i64>,
    width: Option<i64>,
    height: Option<i64>,
    codec: Option<String>,
    bitrate: Option<i64>,
    metadata_json: Option<String>,
    created_at: String,
    updated_at: String,
}

#[derive(sqlx::FromRow)]
struct PlaylistRow {
    id: String,
    name: String,
    user_id: String,
    created_at: String,
    updated_at: String,
}

#[derive(sqlx::FromRow)]
struct PlaylistItemRow {
    id: String,
    playlist_id: String,
    media_id: String,
    position: i64,
    added_at: String,
}

pub async fn run(source_url: &str, target_url: &str) -> anyhow::Result<()> {
    let source_type = detect_db_type(source_url);
    let target_type = detect_db_type(target_url);

    if source_type != "sqlite" {
        anyhow::bail!("Source must be a SQLite database (sqlite://)");
    }
    if target_type != "postgres" {
        anyhow::bail!("Target must be a PostgreSQL database (postgres://)");
    }

    info!("source: {} ({})", source_url, source_type);
    info!("target: {} ({})", target_url, target_type);

    let source = connect_sqlite(source_url).await?;
    let target = connect_postgres(target_url).await?;

    info!("running migrations on target database...");
    crate::storage::migrations::run_postgres(&target).await?;

    migrate_config(&source, &target).await?;
    migrate_users(&source, &target).await?;
    migrate_sessions(&source, &target).await?;
    migrate_media_items(&source, &target).await?;
    migrate_playlists(&source, &target).await?;
    migrate_playlist_items(&source, &target).await?;

    info!("migration completed successfully");
    Ok(())
}

async fn connect_sqlite(url: &str) -> anyhow::Result<Pool<Sqlite>> {
    let pool = SqlitePoolOptions::new()
        .max_connections(1)
        .connect(url)
        .await?;
    Ok(pool)
}

async fn connect_postgres(url: &str) -> anyhow::Result<Pool<Postgres>> {
    let pool = Pool::<Postgres>::connect(url).await?;
    Ok(pool)
}

async fn migrate_config(source: &Pool<Sqlite>, target: &Pool<Postgres>) -> anyhow::Result<()> {
    let rows = sqlx::query_as::<_, ConfigRow>("SELECT * FROM server_config")
        .fetch_all(source)
        .await?;

    if rows.is_empty() {
        info!("  server_config: no rows to migrate");
        return Ok(());
    }

    for row in &rows {
        sqlx::query(
            "INSERT INTO server_config (id, key, value, updated_at)
             VALUES ($1, $2, $3, $4::timestamptz)
             ON CONFLICT (id) DO UPDATE SET
               key = EXCLUDED.key,
               value = EXCLUDED.value,
               updated_at = EXCLUDED.updated_at",
        )
        .bind(row.id)
        .bind(&row.key)
        .bind(&row.value)
        .bind(&row.updated_at)
        .execute(target)
        .await?;
    }

    info!("  server_config: {} rows migrated", rows.len());
    Ok(())
}

async fn migrate_users(source: &Pool<Sqlite>, target: &Pool<Postgres>) -> anyhow::Result<()> {
    let rows = sqlx::query_as::<_, UserRow>("SELECT * FROM users")
        .fetch_all(source)
        .await?;

    if rows.is_empty() {
        info!("  users: no rows to migrate");
        return Ok(());
    }

    for row in &rows {
        sqlx::query(
            "INSERT INTO users (id, username, password_hash, role, created_at, updated_at)
             VALUES ($1, $2, $3, $4, $5::timestamptz, $6::timestamptz)
             ON CONFLICT (id) DO UPDATE SET
               username = EXCLUDED.username,
               password_hash = EXCLUDED.password_hash,
               role = EXCLUDED.role,
               updated_at = EXCLUDED.updated_at",
        )
        .bind(uuid::Uuid::parse_str(&row.id)?)
        .bind(&row.username)
        .bind(&row.password_hash)
        .bind(&row.role)
        .bind(&row.created_at)
        .bind(&row.updated_at)
        .execute(target)
        .await?;
    }

    info!("  users: {} rows migrated", rows.len());
    Ok(())
}

async fn migrate_sessions(source: &Pool<Sqlite>, target: &Pool<Postgres>) -> anyhow::Result<()> {
    let rows = sqlx::query_as::<_, SessionRow>("SELECT * FROM sessions")
        .fetch_all(source)
        .await?;

    if rows.is_empty() {
        info!("  sessions: no rows to migrate");
        return Ok(());
    }

    for row in &rows {
        sqlx::query(
            "INSERT INTO sessions (id, user_id, token, expires_at, created_at)
             VALUES ($1, $2, $3, $4::timestamptz, $5::timestamptz)
             ON CONFLICT (id) DO UPDATE SET
               user_id = EXCLUDED.user_id,
               token = EXCLUDED.token,
               expires_at = EXCLUDED.expires_at",
        )
        .bind(uuid::Uuid::parse_str(&row.id)?)
        .bind(uuid::Uuid::parse_str(&row.user_id)?)
        .bind(&row.token)
        .bind(&row.expires_at)
        .bind(&row.created_at)
        .execute(target)
        .await?;
    }

    info!("  sessions: {} rows migrated", rows.len());
    Ok(())
}

async fn migrate_media_items(source: &Pool<Sqlite>, target: &Pool<Postgres>) -> anyhow::Result<()> {
    let rows = sqlx::query_as::<_, MediaItemRow>("SELECT * FROM media_items")
        .fetch_all(source)
        .await?;

    if rows.is_empty() {
        info!("  media_items: no rows to migrate");
        return Ok(());
    }

    for row in &rows {
        sqlx::query(
            "INSERT INTO media_items
               (id, title, path, media_type, size_bytes, duration_secs,
                width, height, codec, bitrate, metadata_json, created_at, updated_at)
             VALUES
               ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11::jsonb, $12::timestamptz, $13::timestamptz)
             ON CONFLICT (id) DO UPDATE SET
               title = EXCLUDED.title,
               path = EXCLUDED.path,
               media_type = EXCLUDED.media_type,
               size_bytes = EXCLUDED.size_bytes,
               updated_at = EXCLUDED.updated_at",
        )
        .bind(uuid::Uuid::parse_str(&row.id)?)
        .bind(&row.title)
        .bind(&row.path)
        .bind(&row.media_type)
        .bind(row.size_bytes)
        .bind(row.duration_secs)
        .bind(row.width)
        .bind(row.height)
        .bind(&row.codec)
        .bind(row.bitrate)
        .bind(&row.metadata_json)
        .bind(&row.created_at)
        .bind(&row.updated_at)
        .execute(target)
        .await?;
    }

    info!("  media_items: {} rows migrated", rows.len());
    Ok(())
}

async fn migrate_playlists(source: &Pool<Sqlite>, target: &Pool<Postgres>) -> anyhow::Result<()> {
    let rows = sqlx::query_as::<_, PlaylistRow>("SELECT * FROM playlists")
        .fetch_all(source)
        .await?;

    if rows.is_empty() {
        info!("  playlists: no rows to migrate");
        return Ok(());
    }

    for row in &rows {
        sqlx::query(
            "INSERT INTO playlists (id, name, user_id, created_at, updated_at)
             VALUES ($1, $2, $3, $4::timestamptz, $5::timestamptz)
             ON CONFLICT (id) DO UPDATE SET
               name = EXCLUDED.name,
               user_id = EXCLUDED.user_id",
        )
        .bind(uuid::Uuid::parse_str(&row.id)?)
        .bind(&row.name)
        .bind(uuid::Uuid::parse_str(&row.user_id)?)
        .bind(&row.created_at)
        .bind(&row.updated_at)
        .execute(target)
        .await?;
    }

    info!("  playlists: {} rows migrated", rows.len());
    Ok(())
}

async fn migrate_playlist_items(
    source: &Pool<Sqlite>,
    target: &Pool<Postgres>,
) -> anyhow::Result<()> {
    let rows = sqlx::query_as::<_, PlaylistItemRow>("SELECT * FROM playlist_items")
        .fetch_all(source)
        .await?;

    if rows.is_empty() {
        info!("  playlist_items: no rows to migrate");
        return Ok(());
    }

    for row in &rows {
        sqlx::query(
            "INSERT INTO playlist_items (id, playlist_id, media_id, position, added_at)
             VALUES ($1, $2, $3, $4, $5::timestamptz)
             ON CONFLICT (id) DO NOTHING",
        )
        .bind(uuid::Uuid::parse_str(&row.id)?)
        .bind(uuid::Uuid::parse_str(&row.playlist_id)?)
        .bind(uuid::Uuid::parse_str(&row.media_id)?)
        .bind(row.position)
        .bind(&row.added_at)
        .execute(target)
        .await?;
    }

    info!("  playlist_items: {} rows migrated", rows.len());
    Ok(())
}
