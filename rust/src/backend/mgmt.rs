// protocol/sync management
use std::sync::{Arc, Mutex};

use iroh::Endpoint;
use iroh_blobs::store::mem::MemStore;
use iroh_blobs::BlobsProtocol;

use crate::backend;

pub struct EngineHandle {}

impl EngineHandle {
    /// create a new handle for our engine and return it as a shareable (via Arc) Mutex
    pub fn new() -> Arc<Mutex<Self>> {
        Arc::new(Mutex::new(Self {}))
    }
}

// initialise the engine, setup hooks, and return the engine handle
// #[tokio::main]
// pub async fn init() -> anyhow::Result<()> {
//     let net_controller = Arc::new(Mutex::new(backend::net::NetController::init().await?));
    


//     Ok(())
// }
