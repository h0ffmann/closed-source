//// The part of Python's argparse that zenodo_upload.py and arxiv.py used: long options that are
//// flags or take one value, unique prefixes (`--ver`), `--opt=value`, `--`, -h/--help, one
//// positional that is `nargs="*"` or `nargs="?"`, and argparse's error texts, so the commands
//// fail as the scripts did.

import fabric/re
import fabric/sys
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type Opt {
  /// action="store_true"
  Flag(name: String)
  /// one value
  Value(name: String)
}

pub type Positional {
  /// nargs="*"
  Star
  /// nargs="?"
  Maybe
}

pub type Parsed {
  Parsed(
    flags: List(String),
    values: List(#(String, String)),
    positionals: List(String),
  )
}

pub type Stop {
  /// -h or --help was given.
  Help
  /// The text after "error: ".
  Usage(String)
}

type Token {
  Arg(String)
  /// The first "--": argparse drops it only when a positional takes the run it starts.
  Sep
  Known(opt: Opt, explicit: Result(String, Nil))
  Unknown(String)
}

/// Parses as argparse did; options are written with their dashes ("--version").
pub fn parse(
  args: List(String),
  opts: List(Opt),
  positional: Positional,
) -> Result(Parsed, Stop) {
  case tokens(args, opts, False, []) {
    Error(e) -> Error(e)
    Ok(toks) -> walk(toks, positional, Parsed([], [], []), [], False)
  }
}

pub fn flag(p: Parsed, name: String) -> Bool {
  list.contains(p.flags, name)
}

/// The last value given for an option (argparse keeps the last).
pub fn value(p: Parsed, name: String) -> Result(String, Nil) {
  list.key_find(p.values, name)
}

/// ap.error(msg): usage and the message on stderr, status 2.
pub fn fail(usage: String, prog: String, msg: String) -> Int {
  sys.eprintln(usage <> prog <> ": error: " <> msg)
  2
}

fn tokens(
  args: List(String),
  opts: List(Opt),
  dashdash: Bool,
  acc: List(Token),
) -> Result(List(Token), Stop) {
  case args {
    [] -> Ok(list.reverse(acc))
    ["--", ..rest] if !dashdash -> tokens(rest, opts, True, [Sep, ..acc])
    [a, ..rest] ->
      case dashdash || !looks_optional(a) {
        True -> tokens(rest, opts, dashdash, [Arg(a), ..acc])
        False ->
          case classify(a, opts) {
            Ok(t) -> tokens(rest, opts, dashdash, [t, ..acc])
            Error(e) -> Error(e)
          }
      }
  }
}

fn looks_optional(a: String) -> Bool {
  string.starts_with(a, "-")
  && a != "-"
  && !re.search(re.compile("^-\\d+$|^-\\d*\\.\\d+$", []), a)
}

fn names(opts: List(Opt)) -> List(String) {
  ["-h", "--help", ..list.map(opts, fn(o) { o.name })]
}

fn find(opts: List(Opt), name: String) -> Result(Opt, Nil) {
  case name {
    "-h" | "--help" -> Ok(Flag("--help"))
    _ -> list.find(opts, fn(o) { o.name == name })
  }
}

fn classify(a: String, opts: List(Opt)) -> Result(Token, Stop) {
  case find(opts, a) {
    Ok(o) -> Ok(Known(o, Error(Nil)))
    Error(_) -> {
      let #(head, explicit) = case string.split_once(a, "=") {
        Ok(#(h, v)) -> #(h, Ok(v))
        Error(_) -> #(a, Error(Nil))
      }
      case find(opts, head), string.starts_with(head, "--") {
        Ok(o), _ -> Ok(Known(o, explicit))
        Error(_), True ->
          case
            list.filter(names(opts), fn(n) {
              string.starts_with(n, "--") && string.starts_with(n, head)
            })
          {
            [n] -> {
              let assert Ok(o) = find(opts, n)
              Ok(Known(o, explicit))
            }
            [] -> Ok(unknown(a))
            many ->
              Error(Usage(
                "ambiguous option: "
                <> head
                <> " could match "
                <> string.join(many, ", "),
              ))
          }
        Error(_), False -> Ok(unknown(a))
      }
    }
  }
}

// argparse reads an unknown "-x y" (with a space) as a positional.
fn unknown(a: String) -> Token {
  case string.contains(a, " ") {
    True -> Arg(a)
    False -> Unknown(a)
  }
}

fn walk(
  toks: List(Token),
  positional: Positional,
  p: Parsed,
  extras: List(String),
  taken: Bool,
) -> Result(Parsed, Stop) {
  case toks {
    [] ->
      case extras {
        [] ->
          Ok(Parsed(
            list.reverse(p.flags),
            list.reverse(p.values),
            p.positionals,
          ))
        _ ->
          Error(Usage(
            "unrecognized arguments: " <> string.join(list.reverse(extras), " "),
          ))
      }
    [Arg(_), ..] | [Sep, ..] -> {
      let #(run, rest) = args_run(toks, [])
      let chunk = result.values(run)
      case taken, positional {
        // A later run of positionals is left over, as argparse leaves it.
        True, _ -> {
          let left = list.map(run, result.unwrap(_, "--"))
          walk(
            rest,
            positional,
            p,
            list.append(list.reverse(left), extras),
            True,
          )
        }
        False, Star ->
          walk(rest, positional, Parsed(..p, positionals: chunk), extras, True)
        // nargs="?" takes one value and the "--" right before or after it; a "--" further
        // on is left over with the rest.
        False, Maybe -> {
          let run = case run {
            [Error(_), ..r] -> r
            r -> r
          }
          let #(taken_values, more) = case run {
            [Ok(a), Error(_), ..m] -> #([a], m)
            [Ok(a), ..m] -> #([a], m)
            m -> #([], m)
          }
          let left = list.map(more, result.unwrap(_, "--"))
          walk(
            rest,
            positional,
            Parsed(..p, positionals: taken_values),
            list.append(list.reverse(left), extras),
            True,
          )
        }
      }
    }
    [Unknown(a), ..rest] -> walk(rest, positional, p, [a, ..extras], taken)
    [Known(Flag("--help"), Error(_)), ..] -> Error(Help)
    [Known(Flag(name), Ok(v)), ..] ->
      Error(Usage(
        "argument "
        <> display(name)
        <> ": ignored explicit argument "
        <> repr(v),
      ))
    [Known(Flag(name), Error(_)), ..rest] ->
      walk(
        rest,
        positional,
        Parsed(..p, flags: [name, ..p.flags]),
        extras,
        taken,
      )
    [Known(Value(name), Ok(v)), ..rest] ->
      walk(rest, positional, set(p, name, v), extras, taken)
    [Known(Value(name), Error(_)), Arg(v), ..rest] ->
      walk(rest, positional, set(p, name, v), extras, taken)
    [Known(Value(name), Error(_)), ..] ->
      Error(Usage("argument " <> display(name) <> ": expected one argument"))
  }
}

fn display(name: String) -> String {
  case name {
    "--help" -> "-h/--help"
    _ -> name
  }
}

fn set(p: Parsed, name: String, v: String) -> Parsed {
  Parsed(..p, values: [
    #(name, v),
    ..list.filter(p.values, fn(kv) { kv.0 != name })
  ])
}

/// The run of positionals at the head of `toks`; Error(Nil) marks the "--".
fn args_run(
  toks: List(Token),
  acc: List(Result(String, Nil)),
) -> #(List(Result(String, Nil)), List(Token)) {
  case toks {
    [Arg(a), ..rest] -> args_run(rest, [Ok(a), ..acc])
    [Sep, ..rest] -> args_run(rest, [Error(Nil), ..acc])
    _ -> #(list.reverse(acc), toks)
  }
}

/// Python's repr() of a str.
pub fn repr(s: String) -> String {
  let quote = case string.contains(s, "'") && !string.contains(s, "\"") {
    True -> "\""
    False -> "'"
  }
  let body =
    string.to_utf_codepoints(s)
    |> list.map(fn(cp) {
      case string.utf_codepoint_to_int(cp) {
        0x5C -> "\\\\"
        0x0A -> "\\n"
        0x0D -> "\\r"
        0x09 -> "\\t"
        0x27 if quote == "'" -> "\\'"
        c if c < 0x20 || { c >= 0x7F && c <= 0xA0 } || c == 0xAD ->
          "\\x" <> string.pad_start(string.lowercase(int.to_base16(c)), 2, "0")
        _ -> string.from_utf_codepoints([cp])
      }
    })
    |> string.concat
  quote <> body <> quote
}
