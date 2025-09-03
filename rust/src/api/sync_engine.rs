use crate::backend::{net::{self, NetController}};

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

/// initialize networking
// #[flutter_rust_bridge::frb(async)] 
pub async fn init_networking() -> anyhow::Result<NetController> {
    let net_controller = match NetController::init().await {
        Ok(i) => i,
        Err(e) =>  return Err(e),
    };

    Ok(net_controller)
}

/// init rust runtime stuff, generate dependencies and start engines, etc
#[flutter_rust_bridge::frb(init)]
pub fn init_engine() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
    net::test();
}

