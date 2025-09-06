// apis for handling media files and fs stufjf

use crate::backend::fs_glue;

/// run index of user's music directory
pub async fn run_index(music_dir: String) {
    fs_glue::scan_media_directory(music_dir).await;
}
