// protocol/sync management
use std::sync::{Arc, Mutex};

use iroh::Endpoint;
use iroh_blobs::store::mem::MemStore;
use iroh_blobs::BlobsProtocol;

pub struct EngineHandle {}

impl EngineHandle {
    /// create a new handle for our engine and return it as a shareable (via Arc) Mutex
    pub fn new() -> Arc<Mutex<Self>> {
        Arc::new(Mutex::new(Self {}))
    }
}

/// initialise the engine, setup hooks, and return the engine handle
#[tokio::main]
pub async fn init() -> anyhow::Result<()> {
    // create a connection endpoint and advertise self to network
    let endpoint = Endpoint::builder().discovery_n0().bind().await?;
    // We initialize an in-memory backing store for iroh-blobs
    let store = MemStore::new();
    // Then we initialize a struct that can accept blobs requests over iroh connections
    let blobs = BlobsProtocol::new(&store, endpoint.clone(), None);

    Ok(())
}
