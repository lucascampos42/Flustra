use axum::extract::ws::{Message, WebSocket, WebSocketUpgrade};
use axum::extract::State;
use axum::response::IntoResponse;
use futures_util::{SinkExt, StreamExt};
use tokio::sync::broadcast;
use tracing::{info, warn};

use crate::api::routes::AppState;
use crate::core::Event;

pub async fn ws_handler(ws: WebSocketUpgrade, State(state): State<AppState>) -> impl IntoResponse {
    ws.on_upgrade(move |socket| handle_socket(socket, state.event_bus.subscribe_all()))
}

async fn handle_socket(socket: WebSocket, mut rx: broadcast::Receiver<Event>) {
    let (mut sender, _receiver) = socket.split();

    info!("websocket client connected");

    loop {
        match rx.recv().await {
            Ok(event) => {
                let msg = serde_json::json!({
                    "type": event.kind,
                    "payload": format!("{:?}", event.payload),
                });
                let text = serde_json::to_string(&msg).unwrap_or_default();
                if sender.send(Message::Text(text.into())).await.is_err() {
                    break;
                }
            }
            Err(broadcast::error::RecvError::Lagged(n)) => {
                warn!("websocket client lagged by {} events", n);
            }
            Err(broadcast::error::RecvError::Closed) => break,
        }
    }

    info!("websocket client disconnected");
}
