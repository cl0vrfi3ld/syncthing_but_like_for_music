// protocol/sync management
use std::sync::{Arc, Mutex};

use tokio::sync::mpsc;

// pub struct EngineHandle {}

// impl EngineHandle {
//     /// create a new handle for our engine and return it as a shareable (via Arc) Mutex
//     pub fn new() -> Arc<Mutex<Self>> {
//         Arc::new(Mutex::new(Self {}))
//     }
// }

/// commands to be sent to the backend
pub enum BackendCommand {
    Ping,
    AddLikedSong,
    RmLikedSong,
}

/// reply codes/statuses from the backend
pub enum BackendSignal {
    Pong,
    Startup,
    Started,
}

#[flutter_rust_bridge::frb(opaque)]
pub type SenderChannel = mpsc::Sender<BackendCommand>;


/// launches async background rust functions while handling the passing of messages to the main command loop
#[flutter_rust_bridge::frb(async)] 
pub async fn start<C: Fn(SenderChannel), S: Fn(BackendSignal)>(
    set_channel_handle: C,
    message_frontend: S,
) {
    // TODO:
    // - call dart state setter function from rust, passing the messaging handle as a parameter (saves the handle on the flutter side)
    // - setup networking protocols
    // - start execution loop
    message_frontend(BackendSignal::Startup);
    let (tx, mut rx) = mpsc::channel::<BackendCommand>(100);
    set_channel_handle(tx.clone());

    // init has completed, begin main logic loop
    message_frontend(BackendSignal::Started);
    // main logic loop
    loop {
        let cmd = rx.recv().await.unwrap();
        let action_result = action_index(cmd).await;

        tokio::spawn(async move {
            //
        });
    }
}

/// matches BackendCommand values to actions and handles errors
async fn action_index(command: BackendCommand) -> anyhow::Result<BackendSignal> {
    let res = match command {
        BackendCommand::Ping => todo!(),
        BackendCommand::AddLikedSong => todo!(),
        BackendCommand::RmLikedSong => todo!(),
    };
}
