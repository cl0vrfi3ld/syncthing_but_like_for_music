// networking code. management, initialization, etc

use iroh::{protocol::Router, Endpoint};
use iroh_blobs::{store::mem::MemStore, BlobsProtocol, ALPN as BLOBS_ALPN};
use iroh_docs::{protocol::Docs, ALPN as DOCS_ALPN};
use iroh_gossip::{net::Gossip, ALPN as GOSSIP_ALPN};

pub fn test() -> String {
    "hi".to_string()
}

#[flutter_rust_bridge::frb(opaque)]
pub struct NetController {
    // endpoint: Endpoint,
    router: Router,
    store: MemStore,
    pub blobs_protocol: BlobsProtocol,
    pub docs_protocol: Docs,
    pub gossip_protocol: Gossip,
}

impl NetController {
    pub async fn init() -> anyhow::Result<Self> {
        // create a connection endpoint and advertise self to network
        let endpoint = Endpoint::builder().discovery_n0().bind().await?;
        // We initialize an in-memory backing store for iroh-blobs
        let store = MemStore::new();

        // build the blobs protocol
        let blobs = BlobsProtocol::new(&store, endpoint.clone(), None);
        // build the gossip protocol
        let gossip = Gossip::builder().spawn(endpoint.clone());
        // build the docs protocol
        let docs = Docs::memory()
            .spawn(endpoint.clone(), (*blobs).clone(), gossip.clone())
            .await?;

        // create router so we can reuse the one endpoint for multiple independent protos
        let router_builder = Router::builder(endpoint.clone());
        let p2p_router = router_builder
            .accept(BLOBS_ALPN, blobs.clone())
            .accept(GOSSIP_ALPN, gossip.clone())
            .accept(DOCS_ALPN, docs.clone())
            .spawn();

        Ok(Self {
            store,
            blobs_protocol: blobs,
            gossip_protocol: gossip,
            docs_protocol: docs,
            router: p2p_router,
        })
    }
}
