//// Bindings to `closed_source_site_ffi.mjs`.

/// Copy text to the clipboard; the callback gets whether it worked.
@external(javascript, "../closed_source_site_ffi.mjs", "copy")
pub fn copy(text: String, done: fn(Bool) -> Nil) -> Nil
