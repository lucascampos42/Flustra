use std::net::SocketAddr;
use std::sync::Arc;

use axum::http::HeaderName;
use axum::Router;
use tokio::net::TcpListener;
use tower_http::compression::CompressionLayer;
use tower_http::cors::CorsLayer;
use tower_http::request_id::{MakeRequestUuid, SetRequestIdLayer};
use tower_http::trace::TraceLayer;
use tracing::info;

use crate::api;
use crate::config::ServerConfig;
use crate::core::EventBus;

pub struct HttpServer {
    config: Arc<ServerConfig>,
    event_bus: EventBus,
}

impl HttpServer {
    pub fn new(config: Arc<ServerConfig>, event_bus: EventBus) -> Self {
        Self { config, event_bus }
    }

    pub async fn run(self) -> anyhow::Result<()> {
        let addr = SocketAddr::new(self.config.host.parse()?, self.config.port);

        let app = self.build_router();

        info!("HTTP server listening on {}", addr);

        let listener = TcpListener::bind(addr).await?;
        axum::serve(listener, app)
            .with_graceful_shutdown(shutdown_signal())
            .await?;

        Ok(())
    }

    fn build_router(&self) -> Router {
        let x_request_id = HeaderName::from_static("x-request-id");

        Router::new()
            .nest("/api", api::router(self.event_bus.clone()))
            .layer(CompressionLayer::new())
            .layer(CorsLayer::permissive())
            .layer(TraceLayer::new_for_http())
            .layer(SetRequestIdLayer::new(x_request_id, MakeRequestUuid))
    }
}

async fn shutdown_signal() {
    let ctrl_c = async {
        tokio::signal::ctrl_c()
            .await
            .expect("failed to install Ctrl+C handler");
    };

    let terminate = async {
        tokio::signal::unix::signal(tokio::signal::unix::SignalKind::terminate())
            .expect("failed to install SIGTERM handler")
            .recv()
            .await;
    };

    tokio::select! {
        _ = ctrl_c => {},
        _ = terminate => {},
    }

    info!("shutdown signal received, starting graceful shutdown");
}
