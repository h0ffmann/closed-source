import fabric/drawings
import gleam/list
import gleam/string
import svg_path/bounds

pub fn every_drawing_fits_the_canvas_with_a_margin_test() {
  list.each(drawings.all(), fn(d) {
    let assert Ok(b) = bounds.path_bounding_box(d.path)
    // 8 units of margin: more than half the stroke, so no round cap is cut off.
    assert b.min.x >=. 8.0
    assert b.min.y >=. 8.0
    assert b.max.x <=. 352.0
    assert b.max.y <=. 232.0
  })
}

pub fn every_drawing_is_in_the_house_manner_test() {
  assert list.length(drawings.all()) == 4
  list.each(drawings.all(), fn(d) {
    let s = drawings.svg(d)
    assert string.contains(s, "viewBox=\"0 0 360 240\"")
    assert string.contains(
      s,
      "stroke-width:3.2;stroke-linecap:round;stroke-linejoin:round",
    )
    assert string.contains(s, "fill:none")
    assert string.contains(s, "<title>" <> d.title <> "</title>")
    assert string.contains(
      d.title,
      "an original drawing in the manner of the drawings on picasso's site",
    )
  })
}
