use sqlx::migrate::Migrator;
use sqlx::{Pool, Postgres, Sqlite};

pub static SQLITE_MIGRATOR: Migrator = sqlx::migrate!("src/storage/migrations_sqlite");

pub static POSTGRES_MIGRATOR: Migrator = sqlx::migrate!("src/storage/migrations_postgres");

pub async fn run_sqlite(pool: &Pool<Sqlite>) -> anyhow::Result<()> {
    SQLITE_MIGRATOR.run(pool).await?;
    Ok(())
}

pub async fn run_postgres(pool: &Pool<Postgres>) -> anyhow::Result<()> {
    POSTGRES_MIGRATOR.run(pool).await?;
    Ok(())
}
