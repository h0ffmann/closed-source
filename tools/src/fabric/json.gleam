//// JSON as Python's json module reads and writes it: objects keep their key order, and `encode`
//// prints what json.dumps prints, so generated files do not change when the tool changes.

import gleam/float
import gleam/int
import gleam/list
import gleam/string

pub type Json {
  Null
  Bool(Bool)
  Int(Int)
  Float(Float)
  String(String)
  Array(List(Json))
  Object(List(#(String, Json)))
}

@external(erlang, "fabric_ffi", "json_decode")
pub fn decode(text: String) -> Result(Json, String)

/// d.get(key)
pub fn get(j: Json, key: String) -> Result(Json, Nil) {
  case j {
    Object(kvs) -> list.key_find(kvs, key)
    _ -> Error(Nil)
  }
}

/// d.get(key, "") for a string value; anything else is "".
pub fn get_string(j: Json, key: String) -> String {
  case get(j, key) {
    Ok(String(s)) -> s
    _ -> ""
  }
}

/// d.get(key, []) for an array value.
pub fn get_list(j: Json, key: String) -> List(Json) {
  case get(j, key) {
    Ok(Array(l)) -> l
    _ -> []
  }
}

/// d[key] = value, keeping the key's place when it exists, else appending it.
pub fn set(j: Json, key: String, value: Json) -> Json {
  case j {
    Object(kvs) ->
      case list.key_find(kvs, key) {
        Ok(_) ->
          Object(
            list.map(kvs, fn(kv) {
              case kv.0 == key {
                True -> #(key, value)
                False -> kv
              }
            }),
          )
        Error(_) -> Object(list.append(kvs, [#(key, value)]))
      }
    _ -> j
  }
}

/// json.dumps(j, indent=indent, ensure_ascii=ascii); indent 0 means no indent argument.
pub fn encode(j: Json, indent: Int, ascii: Bool) -> String {
  dump(j, indent, ascii, 0)
}

fn dump(j: Json, indent: Int, ascii: Bool, level: Int) -> String {
  case j {
    Null -> "null"
    Bool(True) -> "true"
    Bool(False) -> "false"
    Int(i) -> int.to_string(i)
    Float(f) -> float.to_string(f)
    String(s) -> quote(s, ascii)
    Array([]) -> "[]"
    Object([]) -> "{}"
    Array(items) ->
      wrap(
        "[",
        list.map(items, fn(x) { dump(x, indent, ascii, level + 1) }),
        "]",
        indent,
        level,
      )
    Object(kvs) ->
      wrap(
        "{",
        list.map(kvs, fn(kv) {
          quote(kv.0, ascii) <> ": " <> dump(kv.1, indent, ascii, level + 1)
        }),
        "}",
        indent,
        level,
      )
  }
}

fn wrap(
  open: String,
  items: List(String),
  close: String,
  indent: Int,
  level: Int,
) -> String {
  case indent {
    0 -> open <> string.join(items, ", ") <> close
    _ -> {
      let inner = "\n" <> string.repeat(" ", indent * { level + 1 })
      open
      <> inner
      <> string.join(items, "," <> inner)
      <> "\n"
      <> string.repeat(" ", indent * level)
      <> close
    }
  }
}

/// A JSON string literal, escaped as json.dumps escapes it.
pub fn quote(s: String, ascii: Bool) -> String {
  "\""
  <> {
    string.to_utf_codepoints(s)
    |> list.map(fn(cp) { escape(string.utf_codepoint_to_int(cp), cp, ascii) })
    |> string.concat
  }
  <> "\""
}

fn escape(c: Int, cp: UtfCodepoint, ascii: Bool) -> String {
  case c {
    0x22 -> "\\\""
    0x5C -> "\\\\"
    0x0A -> "\\n"
    0x0D -> "\\r"
    0x09 -> "\\t"
    0x08 -> "\\b"
    0x0C -> "\\f"
    _ if c < 0x20 -> u(c)
    _ if ascii && c > 0x7E && c < 0x10000 -> u(c)
    _ if ascii && c >= 0x10000 -> {
      let v = c - 0x10000
      u(0xD800 + v / 0x400) <> u(0xDC00 + v % 0x400)
    }
    _ -> string.from_utf_codepoints([cp])
  }
}

fn u(c: Int) -> String {
  "\\u" <> string.pad_start(string.lowercase(int.to_base16(c)), 4, "0")
}
