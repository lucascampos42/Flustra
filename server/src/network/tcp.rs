use crate::core::EventBus;

#[allow(dead_code)]
pub struct TcpServer {
    event_bus: EventBus,
}

impl TcpServer {
    pub fn new(event_bus: EventBus) -> Self {
        Self { event_bus }
    }
}
