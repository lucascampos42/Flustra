use tokio::runtime::{self, Runtime as TokioRuntime};

use crate::config::ServerConfig;

pub struct Runtime {
    runtime: TokioRuntime,
}

impl Runtime {
    pub fn new(config: &ServerConfig) -> anyhow::Result<Self> {
        let runtime = runtime::Builder::new_multi_thread()
            .worker_threads(config.worker_threads)
            .enable_all()
            .thread_name("flustra-worker")
            .build()?;

        Ok(Self { runtime })
    }

    pub fn handle(&self) -> &TokioRuntime {
        &self.runtime
    }

    pub fn block_on<F: std::future::Future>(&self, future: F) -> F::Output {
        self.runtime.block_on(future)
    }

    pub fn spawn<F>(&self, future: F)
    where
        F: std::future::Future + Send + 'static,
        F::Output: Send + 'static,
    {
        self.runtime.spawn(future);
    }
}
