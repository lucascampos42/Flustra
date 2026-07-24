use sqlx::{Pool, Postgres};
use tracing::info;

/// Read/write splitting for PostgreSQL HA.
/// The primary handles writes, replicas handle reads.
pub struct HaPool {
    pub primary: Pool<Postgres>,
    pub replica: Option<Pool<Postgres>>,
}

impl HaPool {
    pub async fn new(primary_url: &str, replica_url: Option<&str>) -> anyhow::Result<Self> {
        let primary = Pool::<Postgres>::connect(primary_url).await?;
        info!("HA primary pool connected");

        let replica = if let Some(url) = replica_url {
            let pool = Pool::<Postgres>::connect(url).await?;
            info!("HA replica pool connected");
            Some(pool)
        } else {
            info!("HA replica not configured, using primary for reads");
            None
        };

        Ok(Self { primary, replica })
    }

    pub fn for_read(&self) -> &Pool<Postgres> {
        self.replica.as_ref().unwrap_or(&self.primary)
    }

    pub fn for_write(&self) -> &Pool<Postgres> {
        &self.primary
    }
}
