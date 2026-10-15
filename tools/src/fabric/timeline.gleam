//// timeline: draw the lives of the thinkers of 50THINKERS.md as one SVG (the ouro-timeline skill).
////
//// Lives overlap, so each one gets the first lane where it fits, its name included. The scale is
//// the same everywhere (`px_per_year`); a stretch of empty years longer than `max_gap` is cut out
//// and drawn as a break that says how many years it hides, so 470 BCE and 2026 fit on one page
//// without squeezing the crowded last century.
////
////     tools/fabric timeline           write timeline/thinkers.svg from timeline/lives.tsv
////     tools/fabric timeline --check   fail if the SVG is out of date or a thinker has no row

import fabric/book_check
import fabric/pystr
import fabric/sys
import gleam/int
import gleam/list
import gleam/string

const lives_path = "timeline/lives.tsv"

const svg_path = "timeline/thinkers.svg"

/// Pixels for one year, in every era.
pub const px_per_year = 3

/// Empty years longer than this are cut out of the axis.
pub const max_gap = 60

/// Years of margin around each era.
const pad = 8

/// The width of a break between two eras.
const break_w = 72

const lane_h = 30

const left = 48

const top = 150

/// A thinker's life: `died` is `Error(Nil)` while the thinker is alive.
pub type Life {
  Life(number: Int, name: String, born: Int, died: Result(Int, Nil))
}

/// An era: a stretch of the axis with no cut in it, and its x on the page.
pub type Era {
  Era(start: Int, end: Int, x: Int)
}

/// The rows of lives.tsv: the year now, the lives with dates, and the names without them.
pub fn parse(text: String) -> #(Int, List(Life), List(String)) {
  pystr.splitlines(text)
  |> list.fold(#(0, [], []), fn(acc, line) {
    let #(now, lives, unknown) = acc
    case string.split(line, "\t") {
      ["now", y] -> #(pystr.to_int(y), lives, unknown)
      [n, name, born, died, ..] ->
        case string.starts_with(n, "#"), int.parse(born) {
          True, _ -> acc
          False, Ok(b) -> #(
            now,
            [Life(pystr.to_int(n), name, b, int.parse(died)), ..lives],
            unknown,
          )
          False, Error(_) -> #(now, lives, [name, ..unknown])
        }
      _ -> acc
    }
  })
  |> fn(r) {
    #(
      r.0,
      list.sort(list.reverse(r.1), fn(a, b) { int.compare(a.born, b.born) }),
      list.reverse(r.2),
    )
  }
}

fn end(l: Life, now: Int) -> Int {
  case l.died {
    Ok(d) -> d
    Error(_) -> now
  }
}

/// The eras: lives closer than `max_gap` years share one; each era's x follows the last one's.
pub fn eras(lives: List(Life), now: Int) -> List(Era) {
  let spans =
    list.fold(lives, [], fn(acc, l) {
      case acc {
        [#(s, e), ..rest] if l.born - e <= max_gap -> [
          #(s, int.max(e, end(l, now))),
          ..rest
        ]
        _ -> [#(l.born, end(l, now)), ..acc]
      }
    })
    |> list.reverse
  list.fold(spans, #([], left), fn(acc, span) {
    let #(done, x) = acc
    let era = Era(span.0 - pad, span.1 + pad, x)
    #([era, ..done], x + { era.end - era.start } * px_per_year + break_w)
  }).0
  |> list.reverse
}

/// The x of a year, on the era that holds it.
pub fn x_of(eras: List(Era), year: Int) -> Int {
  case list.find(eras, fn(e) { year >= e.start && year <= e.end }) {
    Ok(e) -> e.x + { year - e.start } * px_per_year
    Error(_) -> 0
  }
}

/// An estimate of a name's width at 13 px, for the lanes.
fn label_w(name: String) -> Int {
  string.length(name) * 7 + 12
}

/// Each life's lane: the first lane whose last life (name included) ends before this one starts.
pub fn lanes(
  lives: List(Life),
  eras: List(Era),
  now: Int,
) -> List(#(Life, Int)) {
  list.fold(lives, #([], []), fn(acc, l) {
    let #(placed, rights) = acc
    let x0 = x_of(eras, l.born)
    let right = int.max(x_of(eras, end(l, now)), x0 + label_w(l.name)) + 10
    let lane =
      list.index_fold(rights, -1, fn(found, r, i) {
        case found < 0 && r < x0 {
          True -> i
          False -> found
        }
      })
    case lane {
      -1 -> #(
        [#(l, list.length(rights)), ..placed],
        list.append(rights, [right]),
      )
      i -> #(
        [#(l, i), ..placed],
        list.index_map(rights, fn(r, j) {
          case j == i {
            True -> right
            False -> r
          }
        }),
      )
    }
  }).0
  |> list.reverse
}

pub fn year_label(y: Int) -> String {
  case y < 0 {
    True -> int.to_string(-y) <> " BCE"
    False -> int.to_string(y)
  }
}

fn esc(s: String) -> String {
  s
  |> string.replace("&", "&amp;")
  |> string.replace("<", "&lt;")
  |> string.replace(">", "&gt;")
}

fn n(i: Int) -> String {
  int.to_string(i)
}

/// The ticks of an era: every 50 years, or every 25 in a short era.
fn ticks(e: Era) -> List(Int) {
  let step = case e.end - e.start > 160 {
    True -> 50
    False -> 25
  }
  let first = case e.start % step {
    0 -> e.start
    r if r < 0 -> e.start - r
    r -> e.start - r + step
  }
  int.range(from: first, to: e.end + 1, with: [], run: fn(acc, y) {
    case y % step == 0 {
      True -> [y, ..acc]
      False -> acc
    }
  })
  |> list.reverse
}

/// A frame drawn as four strokes that stop short of the corners, after picasso's drawings.
fn broken_frame(x: Int, y: Int, w: Int, h: Int) -> String {
  let g = 14
  let line = fn(x1, y1, x2, y2) {
    "<path class=\"tl-frame\" d=\"M"
    <> n(x1)
    <> " "
    <> n(y1)
    <> " L"
    <> n(x2)
    <> " "
    <> n(y2)
    <> "\"/>"
  }
  line(x + g, y, x + w - g * 3, y)
  <> line(x + w, y + g, x + w, y + h - g)
  <> line(x + w - g, y + h, x + g * 3, y + h)
  <> line(x, y + h - g, x, y + g)
}

/// The SVG of the timeline.
pub fn draw(
  now: Int,
  lives: List(Life),
  unknown: List(String),
  cited: List(String),
) -> String {
  let eras = eras(lives, now)
  let placed = lanes(lives, eras, now)
  let n_lanes = list.fold(placed, 0, fn(m, p) { int.max(m, p.1 + 1) })
  let last = case list.last(eras) {
    Ok(e) -> e.x + { e.end - e.start } * px_per_year
    Error(_) -> left
  }
  let width = last + left
  let axis_y = top + n_lanes * lane_h + 18
  let height = axis_y + 136
  let era_svg =
    list.map(eras, fn(e) {
      let x1 = e.x + { e.end - e.start } * px_per_year
      "<path class=\"tl-axis\" d=\"M"
      <> n(e.x)
      <> " "
      <> n(axis_y)
      <> " L"
      <> n(x1)
      <> " "
      <> n(axis_y)
      <> "\"/>"
      <> string.concat(
        list.map(ticks(e), fn(y) {
          let x = x_of(eras, y)
          "<path class=\"tl-tick\" d=\"M"
          <> n(x)
          <> " "
          <> n(top - 8)
          <> " L"
          <> n(x)
          <> " "
          <> n(axis_y + 6)
          <> "\"/><text class=\"tl-year\" x=\""
          <> n(x)
          <> "\" y=\""
          <> n(axis_y + 24)
          <> "\">"
          <> year_label(y)
          <> "</text>"
        }),
      )
    })
    |> string.concat
  let breaks =
    list.window_by_2(eras)
    |> list.map(fn(pair) {
      let #(a, b) = pair
      let x = a.x + { a.end - a.start } * px_per_year + break_w / 2
      let hidden = b.start + pad - { a.end - pad }
      let zig = fn(dx) {
        "<path class=\"tl-break\" d=\"M"
        <> n(x + dx - 6)
        <> " "
        <> n(axis_y + 9)
        <> " L"
        <> n(x + dx + 6)
        <> " "
        <> n(axis_y - 9)
        <> "\"/>"
      }
      zig(-5)
      <> zig(5)
      <> "<path class=\"tl-gap\" d=\"M"
      <> n(x)
      <> " "
      <> n(top - 8)
      <> " L"
      <> n(x)
      <> " "
      <> n(axis_y - 16)
      <> "\"/><text class=\"tl-gaptext\" x=\""
      <> n(x)
      <> "\" y=\""
      <> n(axis_y + 48)
      <> "\">≈ "
      <> n(hidden)
      <> " years</text>"
    })
    |> string.concat
  let lives_svg =
    list.map(placed, fn(p) {
      let #(l, lane) = p
      let y = top + lane * lane_h + 16
      let x0 = x_of(eras, l.born)
      let x1 = x_of(eras, end(l, now))
      let class = case list.contains(cited, l.name) {
        True -> "tl-life tl-cited"
        False -> "tl-life"
      }
      let tail = case l.died {
        Ok(_) ->
          "<path class=\""
          <> class
          <> "\" d=\"M"
          <> n(x1)
          <> " "
          <> n(y - 5)
          <> " L"
          <> n(x1)
          <> " "
          <> n(y + 5)
          <> "\"/>"
        Error(_) ->
          "<path class=\""
          <> class
          <> "\" d=\"M"
          <> n(x1 - 6)
          <> " "
          <> n(y - 5)
          <> " L"
          <> n(x1)
          <> " "
          <> n(y)
          <> " L"
          <> n(x1 - 6)
          <> " "
          <> n(y + 5)
          <> "\"/>"
      }
      let span = case l.died {
        Ok(d) -> year_label(l.born) <> "–" <> year_label(d)
        Error(_) -> "born " <> year_label(l.born)
      }
      let mark = fn(x, label) {
        "<path class=\"tl-drop\" d=\"M"
        <> n(x)
        <> " "
        <> n(y + 6)
        <> " L"
        <> n(x)
        <> " "
        <> n(axis_y)
        <> "\"/><text class=\"tl-when\" x=\""
        <> n(x)
        <> "\" y=\""
        <> n(axis_y - 8)
        <> "\">"
        <> label
        <> "</text>"
      }
      let marks = case l.died {
        Ok(d) -> mark(x0, year_label(l.born)) <> mark(x1, year_label(d))
        Error(_) -> mark(x0, year_label(l.born))
      }
      "<g class=\"tl-who\" tabindex=\"0\" aria-label=\""
      <> esc(l.name)
      <> ", "
      <> span
      <> "\"><g class=\"tl-mark\">"
      <> marks
      <> "</g><path class=\"tl-hit\" d=\"M"
      <> n(x0)
      <> " "
      <> n(y - 6)
      <> " L"
      <> n(int.max(x1, x0 + label_w(l.name)))
      <> " "
      <> n(y - 6)
      <> "\"/><title>"
      <> n(l.number)
      <> ". "
      <> esc(l.name)
      <> ", "
      <> span
      <> "</title><circle class=\""
      <> class
      <> "\" cx=\""
      <> n(x0)
      <> "\" cy=\""
      <> n(y)
      <> "\" r=\"3.5\"/><path class=\""
      <> class
      <> "\" d=\"M"
      <> n(x0 + 4)
      <> " "
      <> n(y)
      <> " L"
      <> n(x1)
      <> " "
      <> n(y)
      <> "\"/>"
      <> tail
      <> "<text class=\"tl-name\" x=\""
      <> n(x0)
      <> "\" y=\""
      <> n(y - 8)
      <> "\">"
      <> esc(l.name)
      <> "</text></g>"
    })
    |> string.concat
  let missing = case unknown {
    [] -> ""
    _ ->
      "<text class=\"tl-note\" x=\""
      <> n(left)
      <> "\" y=\""
      <> n(axis_y + 112)
      <> "\">Not drawn, no dates found: "
      <> esc(string.join(unknown, ", "))
      <> ".</text>"
  }
  let title =
    "The 50 thinkers, their lives: "
    <> n(list.length(lives))
    <> " lives from "
    <> year_label(case lives {
      [l, ..] -> l.born
      [] -> now
    })
    <> " to "
    <> n(now)
  "<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 "
  <> n(width)
  <> " "
  <> n(height)
  <> "\" width=\""
  <> n(width)
  <> "\" height=\""
  <> n(height)
  <> "\" id=\"tl\" role=\"group\" aria-label=\""
  <> title
  <> "\"><title>"
  <> title
  <> "</title><style>"
  <> "#tl{--paper:#F4EFE6;--ink:#141210;--muted:#5F5B56;--rule:#CFC8BC;--red:#A3201C;--black:#0F0E0D;--yellow:#F2C230;background:var(--paper)}"
  <> "@media (prefers-color-scheme:dark){:root:not([data-theme=light]) #tl{--paper:#121110;--ink:#F1EADF;--muted:#B4AEA6;--rule:#3A3734;--red:#E0675F;--black:#050505}}"
  <> ":root[data-theme=dark] #tl{--paper:#121110;--ink:#F1EADF;--muted:#B4AEA6;--rule:#3A3734;--red:#E0675F;--black:#050505}"
  <> "#tl .tl-bg{fill:var(--paper)}"
  <> "#tl text{font-family:'EB Garamond',Garamond,Georgia,serif;fill:var(--ink)}"
  <> "#tl .tl-band{fill:var(--black)}"
  <> "#tl .tl-head{font-family:Oswald,'Arial Narrow',sans-serif;font-size:34px;letter-spacing:.06em;fill:var(--yellow)}"
  <> "#tl .tl-sub{font-size:16px;fill:#F4EFE6;font-style:italic}"
  <> "#tl .tl-frame,#tl .tl-axis,#tl .tl-tick,#tl .tl-break,#tl .tl-gap,#tl .tl-life,#tl .tl-drop,#tl .tl-hit{fill:none;stroke-linecap:round;stroke-linejoin:round}"
  <> "#tl .tl-frame{stroke:var(--ink);stroke-width:3.2}"
  <> "#tl .tl-axis{stroke:var(--ink);stroke-width:2.4}"
  <> "#tl .tl-tick{stroke:var(--rule);stroke-width:1}"
  <> "#tl .tl-gap{stroke:var(--red);stroke-width:1;stroke-dasharray:2 6}"
  <> "#tl .tl-break{stroke:var(--red);stroke-width:2.4}"
  <> "#tl .tl-life{stroke:var(--ink);stroke-width:3.2}"
  <> "#tl circle.tl-life{fill:var(--paper)}"
  <> "#tl .tl-cited{stroke:var(--red)}"
  <> "#tl .tl-name{font-size:13px}"
  <> "#tl .tl-year{font-family:Oswald,'Arial Narrow',sans-serif;font-size:12px;fill:var(--muted);text-anchor:middle}"
  <> "#tl .tl-gaptext{font-size:14px;font-style:italic;fill:var(--red);text-anchor:middle}"
  <> "#tl .tl-note{font-size:14px;fill:var(--muted)}"
  <> "#tl .tl-hit{stroke:transparent;stroke-width:26;pointer-events:stroke}"
  <> "#tl .tl-who{cursor:pointer;outline:none}"
  <> "#tl .tl-mark{visibility:hidden}"
  <> "#tl .tl-drop{stroke:var(--red);stroke-width:1.2;stroke-dasharray:3 4}"
  <> "#tl .tl-when{font-family:Oswald,'Arial Narrow',sans-serif;font-size:14px;font-weight:600;fill:var(--red);text-anchor:middle;paint-order:stroke;stroke:var(--paper);stroke-width:5px}"
  <> "#tl .tl-who:hover .tl-mark,#tl .tl-who:focus .tl-mark{visibility:visible}"
  <> "#tl .tl-who:hover .tl-life,#tl .tl-who:focus .tl-life{stroke-width:5}"
  <> "#tl .tl-who:focus-visible .tl-name{text-decoration:underline;text-decoration-color:var(--red)}"
  <> "#tl:has(.tl-who:hover,.tl-who:focus) .tl-who:not(:hover):not(:focus){opacity:.3}"
  <> "</style><rect class=\"tl-bg\" x=\"0\" y=\"0\" width=\""
  <> n(width)
  <> "\" height=\""
  <> n(height)
  <> "\"/><g class=\"tl-title\"><rect class=\"tl-band\" x=\"0\" y=\"0\" width=\""
  <> n(width)
  <> "\" height=\"96\"/><text class=\"tl-head\" x=\""
  <> n(left)
  <> "\" y=\"52\">THE 50 THINKERS, THEIR LIVES</text><text class=\"tl-sub\" x=\""
  <> n(left)
  <> "\" y=\"80\">"
  <> n(px_per_year)
  <> " px a year in every era; a cut (≈) hides a stretch of more than "
  <> n(max_gap)
  <> " empty years. Red: cited by the paper. ▸ still living. Point at a life for its years.</text></g>"
  <> broken_frame(left / 2, top - 30, width - left, axis_y + 96 - top)
  <> era_svg
  <> breaks
  <> lives_svg
  <> missing
  <> "</svg>\n"
}

/// The svg from the repository's files, and the named thinkers that lives.tsv lacks.
fn build() -> Result(#(String, List(String)), String) {
  case pystr.read_text(lives_path), pystr.read_text("50THINKERS.md") {
    Ok(tsv), Ok(roster) -> {
      let #(now, lives, unknown) = parse(tsv)
      let listed = list.append(list.map(lives, fn(l) { l.name }), unknown)
      let lacking =
        list.filter(book_check.named(roster), fn(t) {
          !list.contains(listed, t)
        })
      Ok(#(draw(now, lives, unknown, book_check.cited_names(roster)), lacking))
    }
    Error(e), _ | _, Error(e) -> Error(e)
  }
}

pub fn main(args: List(String)) -> Int {
  case build() {
    Error(e) -> {
      sys.eprintln("timeline: " <> e)
      1
    }
    Ok(#(svg, lacking)) -> {
      list.each(lacking, fn(t) {
        sys.eprintln("timeline: " <> t <> " has no row in " <> lives_path)
      })
      case args, lacking {
        _, [_, ..] -> 1
        ["--check"], [] ->
          case pystr.read_text(svg_path) {
            Ok(old) if old == svg -> {
              sys.eprintln("timeline: " <> svg_path <> " is up to date")
              0
            }
            _ -> {
              sys.eprintln(
                "timeline: "
                <> svg_path
                <> " is out of date; run tools/fabric timeline",
              )
              1
            }
          }
        _, [] ->
          case sys.write(svg_path, svg) {
            Ok(_) -> {
              sys.eprintln("timeline: wrote " <> svg_path)
              0
            }
            Error(e) -> {
              sys.eprintln("timeline: " <> e)
              1
            }
          }
      }
    }
  }
}
