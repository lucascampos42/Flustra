use std::fs::OpenOptions;
use std::sync::Arc;

use tracing::subscriber::set_global_default;
use tracing_subscriber::filter::EnvFilter;
use tracing_subscriber::fmt;
use tracing_subscriber::layer::SubscriberExt;
use tracing_subscriber::Registry;

use crate::config::LoggingConfig;

pub fn init(config: &LoggingConfig) -> anyhow::Result<()> {
    let filter = EnvFilter::builder()
        .with_default_directive(config.level.parse()?)
        .from_env_lossy();

    let registry = Registry::default().with(filter);

    match config.format.as_str() {
        "json" => {
            let fmt_layer = fmt::layer()
                .json()
                .with_target(true)
                .with_thread_ids(true)
                .with_thread_names(true)
                .with_file(true)
                .with_line_number(true);

            if let Some(ref path) = config.file {
                let file = OpenOptions::new().create(true).append(true).open(path)?;
                let file_layer = fmt::layer()
                    .json()
                    .with_writer(Arc::new(file))
                    .with_target(true)
                    .with_thread_ids(true)
                    .with_thread_names(false)
                    .with_file(true)
                    .with_line_number(true);
                let subscriber = registry.with(fmt_layer).with(file_layer);
                set_global_default(subscriber)?;
            } else {
                let subscriber = registry.with(fmt_layer);
                set_global_default(subscriber)?;
            }
        }
        _ => {
            let fmt_layer = fmt::layer()
                .pretty()
                .with_target(true)
                .with_file(true)
                .with_line_number(true);

            if let Some(ref path) = config.file {
                let file = OpenOptions::new().create(true).append(true).open(path)?;
                let file_layer = fmt::layer()
                    .json()
                    .with_writer(Arc::new(file))
                    .with_target(true)
                    .with_file(true)
                    .with_line_number(true);
                let subscriber = registry.with(fmt_layer).with(file_layer);
                set_global_default(subscriber)?;
            } else {
                let subscriber = registry.with(fmt_layer);
                set_global_default(subscriber)?;
            }
        }
    }

    Ok(())
}
