//// `gleam run -m closed_source_site/prerender > dist/index.html`: the first render, which the
//// client then takes over in place, so the page reads without JavaScript.

import closed_source_site/app
import closed_source_site/page
import gleam/io
import lustre/element

pub fn main() -> Nil {
  app.initial()
  |> app.view
  |> page.document
  |> element.to_document_string
  |> io.println
}
