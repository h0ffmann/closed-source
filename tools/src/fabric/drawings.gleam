//// drawings: write experimental one-line drawings to site/static/drawings/experiments/.
////
//// Each figure is built in its own coordinates with svg_path (MIT, vistuleB/svg_path v3.1.1),
//// then measured (length, bounds) and moved into the house canvas: viewBox 0 0 360 240, stroke
//// 3.2, round caps and joins, no fill, a broken frame. The drawings are original, in the manner
//// of the drawings on picasso's site; none traces or copies a work by Pablo Picasso.
////
////     tools/fabric drawings

import fabric/sys
import gleam/float
import gleam/list
import gleam/string
import svg_path.{type Path, type Point, Point}
import svg_path/basic_shapes
import svg_path/bounds
import svg_path/fit
import svg_path/measure
import svg_path/point
import svg_path/serialize
import svg_path/transform

pub const dir = "site/static/drawings/experiments"

/// The box the figure is scaled into, inside the 360 x 240 canvas.
const box_w = 250.0

const box_h = 164.0

/// A drawing: its file name, what its <title> says, and its paths in canvas coordinates.
pub type Drawing {
  Drawing(name: String, title: String, path: Path)
}

pub fn all() -> List(Drawing) {
  [
    drawing("ouroboros", "A snake that bites its tail", ouroboros()),
    drawing(
      "serpent-spiral",
      "A serpent coiled in a spiral, the eternal cycle",
      spiral(),
    ),
    drawing("quill", "A quill pen and a drop of ink", quill()),
    drawing("open-book", "An open book", book()),
  ]
}

fn drawing(name: String, what: String, figure: Path) -> Drawing {
  let title =
    what
    <> ", one line: an original drawing in the manner of the drawings on picasso's site"
  Drawing(name, title, svg_path.path_combine([place(figure), frame()]))
}

/// Scale the figure by its exact bounds to fill the box, and centre it on the canvas.
fn place(figure: Path) -> Path {
  let assert Ok(b) = bounds.path_bounding_box(figure)
  let c = bounds.bounding_box_center(b)
  let s =
    float.min(
      box_w /. bounds.bounding_box_width(b),
      box_h /. bounds.bounding_box_height(b),
    )
  let m =
    transform.translate(x: 0.0 -. c.x, y: 0.0 -. c.y)
    |> transform.chain(then: transform.scale(s))
    |> transform.chain(then: transform.translate(x: 180.0, y: 120.0))
  let assert Ok(placed) = transform.path(figure, by: m)
  placed
}

/// Two corners of a frame that stop short, as on the drawings of picasso's site.
fn frame() -> Path {
  svg_path.Path([
    svg_path.subpath_assert_polyline([
      p(28.0, 74.0),
      p(28.0, 22.0),
      p(92.0, 22.0),
    ]),
    svg_path.subpath_assert_polyline([
      p(268.0, 218.0),
      p(332.0, 218.0),
      p(332.0, 166.0),
    ]),
  ])
}

pub fn svg(d: Drawing) -> String {
  "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 360 240\" width=\"360\" height=\"240\" role=\"img\" aria-label=\""
  <> d.title
  <> "\"><title>"
  <> d.title
  <> "</title><style>.l{fill:none;stroke:#fff;stroke-width:3.2;stroke-linecap:round;stroke-linejoin:round}</style>"
  <> string.concat(
    list.map(svg_path.path_subpaths(d.path), fn(sp) {
      "<path class=\"l\" d=\""
      <> serialize.subpath_with(sp, options: serialize.decimal_options(1))
      <> "\"/>"
    }),
  )
  <> "</svg>\n"
}

fn p(x: Float, y: Float) -> Point {
  Point(x, y)
}

fn polar(r: Float, degrees: Float) -> Point {
  point.scale(point.direction(degrees:), by: r)
}

fn pow(x: Float, e: Float) -> Float {
  let assert Ok(y) = float.power(x, e)
  y
}

/// A head drawn in a frame where the neck is at x = 0 and spans y = -1 (outside) to 1 (inside);
/// x points forward. The jaws are open; `tongue` adds a forked tongue.
fn head(tongue: Bool) -> List(svg_path.Subpath) {
  let k = fn(x, y) { p(x /. 11.0, y /. 11.0 -. 1.0) }
  let outline =
    svg_path.subpath_assert([
      svg_path.CubicBezier(
        k(0.0, 0.0),
        k(10.0, -10.0),
        k(28.0, -12.0),
        k(40.0, -2.0),
      ),
      svg_path.QuadraticBezier(k(40.0, -2.0), k(28.0, 4.0), k(14.0, 10.0)),
      svg_path.QuadraticBezier(k(14.0, 10.0), k(26.0, 18.0), k(36.0, 28.0)),
      svg_path.CubicBezier(
        k(36.0, 28.0),
        k(24.0, 34.0),
        k(8.0, 30.0),
        k(0.0, 22.0),
      ),
    ])
  let assert Ok(eye) =
    basic_shapes.circle(cx: 16.0 /. 11.0, cy: -0.5 /. 11.0 -. 1.0, r: 0.3)
  case tongue {
    False -> [outline, eye]
    True -> [
      outline,
      eye,
      svg_path.subpath_assert_polyline([
        k(14.0, 10.0),
        k(46.0, 10.0),
        k(53.0, 5.0),
      ]),
      svg_path.subpath_assert_polyline([k(46.0, 10.0), k(53.0, 15.0)]),
    ]
  }
}

/// Put the head at the end of a line: its pose comes from the line's length, end point and
/// tangent there, so the head follows the body whatever its shape. `half` is the neck's half
/// width; the neck's outer edge is at `edge` (or the centre when the body is one line).
fn head_at_end(
  line: svg_path.Subpath,
  half: Float,
  from_edge: Bool,
  tongue: Bool,
) -> List(svg_path.Subpath) {
  let assert Ok(len) = measure.subpath_length(line)
  let assert Ok(end) = measure.subpath_point_at_length(line, distance: len)
  let assert Ok(dir) = measure.subpath_derivative_at_length(line, distance: len)
  let heading = point.heading(dir)
  let shift = case from_edge {
    True -> half
    False -> 0.0
  }
  let m =
    transform.translate(x: 0.0, y: shift /. half)
    |> transform.chain(then: transform.scale(half))
    |> transform.chain(then: transform.rotate(degrees: heading))
    |> transform.chain(then: transform.translate(x: end.x, y: end.y))
  list.map(head(tongue), fn(sp) {
    let assert Ok(moved) = transform.subpath(sp, by: m)
    moved
  })
}

/// The ouroboros: a body that thins from the neck to the tail, drawn as one line (the inner
/// edge out to the tail, the outer edge back), whose tail ends in the open mouth.
fn ouroboros() -> Path {
  let r = 100.0
  let neck = -70.0
  let tail = neck -. 342.0
  let half = 16.0
  let w = fn(t) {
    half *. { 1.0 -. pow(1.0 -. { t -. tail } /. { neck -. tail }, 3.0) }
  }
  let assert Ok(inner) =
    fit.subpath_from_parametric(from: neck, to: tail, point: fn(t) {
      polar(r -. w(t), t)
    })
  let assert Ok(outer) =
    fit.subpath_from_parametric(from: tail, to: neck, point: fn(t) {
      polar(r +. w(t), t)
    })
  let body =
    svg_path.subpath_assert(list.append(
      svg_path.subpath_segments(inner),
      svg_path.subpath_segments(outer),
    ))
  svg_path.Path([body, ..head_at_end(outer, half, True, False)])
}

/// The eternal cycle: an Archimedean spiral from a still centre out to a head with a tongue.
fn spiral() -> Path {
  let turns = 2.6
  let assert Ok(coil) =
    fit.subpath_from_parametric(from: 0.0, to: turns *. 360.0, point: fn(a) {
      polar(4.0 +. a /. 360.0 *. 30.0, a)
    })
  svg_path.Path([coil, ..head_at_end(coil, 10.0, False, True)])
}

/// A quill, its vane drawn as one line with two notches, its shaft ending in a split nib.
fn quill() -> Path {
  let c = fn(a, b, cc, d) { svg_path.CubicBezier(a, b, cc, d) }
  let l = fn(a, b) { svg_path.Line(a, b) }
  let vane =
    svg_path.subpath_assert([
      c(p(46.0, -3.0), p(80.0, -30.0), p(170.0, -52.0), p(214.0, -44.0)),
      l(p(214.0, -44.0), p(200.0, -36.0)),
      c(p(200.0, -36.0), p(232.0, -40.0), p(262.0, -34.0), p(282.0, -22.0)),
      c(p(282.0, -22.0), p(240.0, 4.0), p(186.0, 16.0), p(150.0, 14.0)),
      l(p(150.0, 14.0), p(162.0, 6.0)),
      c(p(162.0, 6.0), p(120.0, 16.0), p(80.0, 12.0), p(52.0, 3.0)),
    ])
  let shaft =
    svg_path.subpath_assert([
      c(p(0.0, 0.0), p(90.0, -4.0), p(200.0, -14.0), p(282.0, -22.0)),
    ])
  let nib =
    svg_path.subpath_assert_polyline([p(0.0, 0.0), p(-26.0, 4.0), p(4.0, 6.0)])
  let quill_path =
    svg_path.Path([vane, shaft, nib])
    |> transform.path(by: transform.rotate(degrees: -28.0))
  let assert Ok(quill_path) = quill_path
  let assert Ok(drop) =
    basic_shapes.ellipse(cx: -30.0, cy: 36.0, rx: 5.0, ry: 7.0)
  svg_path.path_append_subpath(quill_path, drop)
}

/// An open book: the left page is drawn once and mirrored for the right.
fn book() -> Path {
  let c = fn(a, b, cc, d) { svg_path.CubicBezier(a, b, cc, d) }
  let page =
    svg_path.Path([
      svg_path.subpath_assert([
        c(p(0.0, 0.0), p(-40.0, -22.0), p(-100.0, -22.0), p(-140.0, -6.0)),
        svg_path.Line(p(-140.0, -6.0), p(-140.0, 120.0)),
        c(p(-140.0, 120.0), p(-100.0, 104.0), p(-40.0, 104.0), p(0.0, 126.0)),
      ]),
      text_line(-22.0, 18.0, 82.0),
      text_line(-22.0, 42.0, 96.0),
      text_line(-22.0, 66.0, 70.0),
    ])
  let assert Ok(right) =
    transform.path(page, by: transform.scale_xy(x: -1.0, y: 1.0))
  let spine = svg_path.subpath_assert_polyline([p(0.0, 0.0), p(0.0, 126.0)])
  svg_path.path_combine([page, right, svg_path.subpath_as_path(spine)])
}

/// A line of text on the left page, bent like the page.
fn text_line(x: Float, y: Float, w: Float) -> svg_path.Subpath {
  svg_path.subpath_assert([
    svg_path.QuadraticBezier(
      p(x, y),
      p(x -. w /. 2.0, y -. 10.0),
      p(x -. w, y -. 6.0),
    ),
  ])
}

pub fn main(_args: List(String)) -> Int {
  let assert Ok(_) = sys.make_dirs(dir)
  list.each(all(), fn(d) {
    let file = sys.join(dir, d.name <> ".svg")
    let assert Ok(_) = sys.write(file, svg(d))
    sys.eprintln("drawings: wrote " <> file)
  })
  0
}
