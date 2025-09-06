// barebones fs logic
use std::path::{Path, PathBuf};
use walkdir::WalkDir;

/// scan media dir and return index struct
pub(crate) async fn scan_media_directory<I: AsRef<Path>>(music_path: I) {
    // let music_path_buf: PathBuf = music_path.into();
    let walker = WalkDir::new(music_path);

    for entry in walker.into_iter() {
        let out = entry.unwrap();
        let out_str = out.path().to_str().unwrap();
        println!("{out_str}");
    }

}
