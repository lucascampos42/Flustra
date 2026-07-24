use std::path::Path;

use sqlx::migrate::MigrateDatabase;
use sqlx::sqlite::SqlitePoolOptions;
use sqlx::{Pool, Postgres, Sqlite};
use tracing::info;

use crate::config::StorageConfig;

pub mod migrations;

#[derive(Clone)]
pub enum DbPool {
    Sqlite(Pool<Sqlite>),
    Postgres(Pool<Postgres>),
}

impl DbPool {
    pub fn is_sqlite(&self) -> bool {
        matches!(self, Self::Sqlite(_))
    }

    pub fn is_postgres(&self) -> bool {
        matches!(self, Self::Postgres(_))
    }

    pub fn db_type(&self) -> &str {
        match self {
            Self::Sqlite(_) => "sqlite",
            Self::Postgres(_) => "postgres",
        }
    }
}

pub fn detect_db_type(url: &str) -> &str {
    if url.starts_with("postgres://") || url.starts_with("postgresql://") {
        "postgres"
    } else {
        "sqlite"
    }
}

pub async fn init(config: &StorageConfig) -> anyhow::Result<DbPool> {
    let db_type = detect_db_type(&config.db_url);

    match db_type {
        "postgres" => init_postgres(config).await,
        _ => init_sqlite(config).await,
    }
}

async fn init_sqlite(config: &StorageConfig) -> anyhow::Result<DbPool> {
    let url = &config.db_url;

    ensure_sqlite_dir(url)?;

    if !sqlx::Sqlite::database_exists(url).await.unwrap_or(false) {
        sqlx::Sqlite::create_database(url).await?;
        info!("sqlite database created at {}", url);
    }

    let pool = SqlitePoolOptions::new()
        .max_connections(config.max_connections)
        .connect(url)
        .await?;

    info!("sqlite database connected");

    migrations::run_sqlite(&pool).await?;

    Ok(DbPool::Sqlite(pool))
}

fn ensure_sqlite_dir(url: &str) -> anyhow::Result<()> {
    if let Some(path) = url.strip_prefix("sqlite://") {
        if let Some(parent) = Path::new(path).parent() {
            if !parent.exists() || parent.as_os_str().is_empty() {
                std::fs::create_dir_all(parent)?;
            }
        }
    }
    Ok(())
}

async fn init_postgres(config: &StorageConfig) -> anyhow::Result<DbPool> {
    let url = &config.db_url;

    if !sqlx::Postgres::database_exists(url).await.unwrap_or(false) {
        sqlx::Postgres::create_database(url).await?;
        info!("postgres database created at {}", url);
    }

    let pool = Pool::<Postgres>::connect(url).await?;

    info!("postgres database connected");

    migrations::run_postgres(&pool).await?;

    Ok(DbPool::Postgres(pool))
}
