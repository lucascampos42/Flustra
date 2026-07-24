use std::sync::atomic::{AtomicU64, Ordering};
use std::sync::Arc;

use dashmap::DashMap;

#[derive(Clone)]
pub struct Metrics {
    counters: Arc<DashMap<String, AtomicU64>>,
}

impl Metrics {
    pub fn new() -> Self {
        Self {
            counters: Arc::new(DashMap::new()),
        }
    }

    pub fn increment(&self, name: &str) {
        self.counters
            .entry(name.to_string())
            .or_insert_with(|| AtomicU64::new(0))
            .fetch_add(1, Ordering::Relaxed);
    }

    pub fn get(&self, name: &str) -> u64 {
        self.counters
            .get(name)
            .map(|c| c.load(Ordering::Relaxed))
            .unwrap_or(0)
    }

    pub fn snapshot(&self) -> Vec<(String, u64)> {
        self.counters
            .iter()
            .map(|e| (e.key().clone(), e.value().load(Ordering::Relaxed)))
            .collect()
    }
}

impl Default for Metrics {
    fn default() -> Self {
        Self::new()
    }
}
