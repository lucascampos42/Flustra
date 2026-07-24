use std::path::PathBuf;

use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FlustraConfig {
    #[serde(default = "default_server")]
    pub server: ServerConfig,
    #[serde(default = "default_logging")]
    pub logging: LoggingConfig,
    #[serde(default = "default_storage")]
    pub storage: StorageConfig,
    #[serde(default = "default_security")]
    pub security: SecurityConfig,
    #[serde(default = "default_plugins")]
    pub plugins: PluginsConfig,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ServerConfig {
    #[serde(default = "default_host")]
    pub host: String,
    #[serde(default = "default_port")]
    pub port: u16,
    #[serde(default = "default_data_dir")]
    pub data_dir: PathBuf,
    #[serde(default = "default_worker_threads")]
    pub worker_threads: usize,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LoggingConfig {
    #[serde(default = "default_log_level")]
    pub level: String,
    #[serde(default = "default_log_format")]
    pub format: String,
    pub file: Option<PathBuf>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StorageConfig {
    #[serde(default = "default_db_url")]
    pub db_url: String,
    #[serde(default = "default_max_connections")]
    pub max_connections: u32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SecurityConfig {
    #[serde(default = "default_jwt_secret")]
    pub jwt_secret: String,
    #[serde(default = "default_token_expiry")]
    pub token_expiry_secs: u64,
    pub tls_cert: Option<PathBuf>,
    pub tls_key: Option<PathBuf>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PluginsConfig {
    #[serde(default = "default_plugins_dir")]
    pub dir: PathBuf,
    #[serde(default = "default_enabled_plugins")]
    pub enabled: Vec<String>,
}

fn default_host() -> String {
    "0.0.0.0".into()
}
fn default_port() -> u16 {
    8080
}
fn default_data_dir() -> PathBuf {
    PathBuf::from("data")
}
fn default_worker_threads() -> usize {
    num_cpus::get()
}
fn default_log_level() -> String {
    "info".into()
}
fn default_log_format() -> String {
    "json".into()
}
fn default_db_url() -> String {
    "sqlite://data/flustra.db".into()
}
fn default_max_connections() -> u32 {
    10
}
fn default_jwt_secret() -> String {
    "change-me-in-production".into()
}
fn default_token_expiry() -> u64 {
    86400
}
fn default_plugins_dir() -> PathBuf {
    PathBuf::from("plugins/installed")
}
fn default_enabled_plugins() -> Vec<String> {
    vec![]
}

pub fn default_server() -> ServerConfig {
    ServerConfig {
        host: default_host(),
        port: default_port(),
        data_dir: default_data_dir(),
        worker_threads: default_worker_threads(),
    }
}

pub fn default_logging() -> LoggingConfig {
    LoggingConfig {
        level: default_log_level(),
        format: default_log_format(),
        file: None,
    }
}

pub fn default_storage() -> StorageConfig {
    StorageConfig {
        db_url: default_db_url(),
        max_connections: default_max_connections(),
    }
}

pub fn default_security() -> SecurityConfig {
    SecurityConfig {
        jwt_secret: default_jwt_secret(),
        token_expiry_secs: default_token_expiry(),
        tls_cert: None,
        tls_key: None,
    }
}

pub fn default_plugins() -> PluginsConfig {
    PluginsConfig {
        dir: default_plugins_dir(),
        enabled: default_enabled_plugins(),
    }
}

impl FlustraConfig {
    pub fn load(config_path: Option<&std::path::Path>) -> anyhow::Result<Self> {
        if let Some(path) = config_path {
            let content = std::fs::read_to_string(path).map_err(|e| {
                anyhow::anyhow!("Failed to read config file {}: {}", path.display(), e)
            })?;
            let config: FlustraConfig = toml::from_str(&content)
                .map_err(|e| anyhow::anyhow!("Failed to parse config file: {}", e))?;
            return Ok(config);
        }

        let config_paths: Vec<Option<PathBuf>> = vec![
            Some(PathBuf::from("config/flustra.toml")),
            directories::ProjectDirs::from("com", "flustra", "Flustra")
                .map(|d| d.config_dir().join("flustra.toml")),
            std::env::var("FLUSTRA_CONFIG").ok().map(PathBuf::from),
        ];

        for path in config_paths.into_iter().flatten() {
            if path.exists() {
                let content = std::fs::read_to_string(&path)?;
                let config: FlustraConfig = toml::from_str(&content)?;
                return Ok(config);
            }
        }

        Ok(Self {
            server: default_server(),
            logging: default_logging(),
            storage: default_storage(),
            security: default_security(),
            plugins: default_plugins(),
        })
    }

    pub fn override_from_env(&mut self) {
        if let Ok(host) = std::env::var("FLUSTRA_HOST") {
            self.server.host = host;
        }
        if let Ok(port) = std::env::var("FLUSTRA_PORT") {
            if let Ok(port) = port.parse() {
                self.server.port = port;
            }
        }
        if let Ok(level) = std::env::var("FLUSTRA_LOG_LEVEL") {
            self.logging.level = level;
        }
        if let Ok(db_url) = std::env::var("FLUSTRA_DB_URL") {
            self.storage.db_url = db_url;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn config_should_load_defaults_when_no_file() {
        let config = FlustraConfig::load(None).unwrap();
        assert_eq!(config.server.port, 8080);
        assert_eq!(config.server.host, "0.0.0.0");
        assert_eq!(config.logging.level, "info");
    }

    #[test]
    fn config_should_parse_valid_toml() {
        let toml_str = r#"
            [server]
            host = "127.0.0.1"
            port = 9090

            [logging]
            level = "debug"
            format = "text"
        "#;

        let dir = tempfile::tempdir().unwrap();
        let path = dir.path().join("flustra.toml");
        std::fs::write(&path, toml_str).unwrap();
        let config = FlustraConfig::load(Some(&path)).unwrap();
        assert_eq!(config.server.host, "127.0.0.1");
        assert_eq!(config.server.port, 9090);
        assert_eq!(config.logging.level, "debug");
        assert_eq!(config.logging.format, "text");
    }
}
