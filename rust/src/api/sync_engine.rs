use crate::fs_sync::{net,init};

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(init)]
pub fn init_engine() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
    net::test();
}
