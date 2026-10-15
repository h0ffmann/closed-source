//// Bindings to `closed_source_site_ffi.mjs`.

/// Copy text to the clipboard; the callback gets whether it worked.
@external(javascript, "../closed_source_site_ffi.mjs", "copy")
pub fn copy(text: String, done: fn(Bool) -> Nil) -> Nil

/// Scroll the element with this id sideways, smoothly unless the reader asks for less motion.
@external(javascript, "../closed_source_site_ffi.mjs", "scroll_by")
pub fn scroll_by(id: String, dx: Int) -> Nil

/// Ask the refpulse service (its URL, or the page's `?refpulse=` parameter) about these DOIs.
/// The callback gets "ms\tendpoint" and one "doi\tstatus\tok" line per DOI, or why it failed.
@external(javascript, "../closed_source_site_ffi.mjs", "refpulse")
pub fn refpulse(
  url: String,
  dois: List(String),
  done: fn(Result(String, String)) -> Nil,
) -> Nil
