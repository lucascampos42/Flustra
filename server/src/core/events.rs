use std::any::Any;
use std::sync::Arc;

use dashmap::DashMap;
use tokio::sync::broadcast;
use tracing::debug;

#[derive(Debug, Clone)]
pub struct Event {
    pub kind: &'static str,
    pub payload: Arc<dyn Any + Send + Sync>,
}

pub type EventHandler = Arc<dyn Fn(Event) + Send + Sync>;

#[derive(Clone)]
pub struct EventBus {
    tx: broadcast::Sender<Event>,
    handlers: Arc<DashMap<String, Vec<EventHandler>>>,
}

impl EventBus {
    pub fn new(capacity: usize) -> Self {
        let (tx, _) = broadcast::channel(capacity);
        Self {
            tx,
            handlers: Arc::new(DashMap::new()),
        }
    }

    pub fn emit(&self, kind: &'static str, payload: impl Any + Send + Sync) {
        let event = Event {
            kind,
            payload: Arc::new(payload),
        };
        if let Err(e) = self.tx.send(event.clone()) {
            debug!("event channel full, dropping event {}: {}", kind, e);
        }
        if let Some(handlers) = self.handlers.get(kind) {
            for handler in handlers.value() {
                handler(event.clone());
            }
        }
    }

    pub fn subscribe(&self, kind: &'static str, handler: EventHandler) {
        self.handlers
            .entry(kind.to_string())
            .or_default()
            .push(handler);
    }

    pub fn subscribe_all(&self) -> broadcast::Receiver<Event> {
        self.tx.subscribe()
    }
}

impl Default for EventBus {
    fn default() -> Self {
        Self::new(256)
    }
}
