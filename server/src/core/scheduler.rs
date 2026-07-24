use std::time::Duration;

use tokio::time::interval;

pub struct Scheduler {
    runtime: tokio::runtime::Handle,
}

impl Scheduler {
    pub fn new(runtime: tokio::runtime::Handle) -> Self {
        Self { runtime }
    }

    pub fn every<F, Fut>(&self, duration: Duration, task: F)
    where
        F: Fn() -> Fut + Send + 'static,
        Fut: std::future::Future<Output = ()> + Send + 'static,
    {
        self.runtime.spawn(async move {
            let mut ticker = interval(duration);
            loop {
                ticker.tick().await;
                task().await;
            }
        });
    }
}
