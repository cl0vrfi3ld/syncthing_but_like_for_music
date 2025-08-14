use iroh::Endpoint;
use iroh_blobs::store::mem::MemStore;
use iroh_blobs::BlobsProtocol;

// protocol/sync manager
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
