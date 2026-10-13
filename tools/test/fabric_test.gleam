import fabric/json
import fabric/re
import fabric/sys
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn json_round_trip_keeps_key_order_test() {
  let text = "{\"b\": [1, 2.5, \"é\"], \"a\": {\"x\": null, \"y\": true}}"
  let assert Ok(j) = json.decode(text)
  assert json.encode(j, 0, False) == text
  assert json.encode(j, 0, True)
    == "{\"b\": [1, 2.5, \"\\u00e9\"], \"a\": {\"x\": null, \"y\": true}}"
  assert json.encode(j, 2, False)
    == "{\n  \"b\": [\n    1,\n    2.5,\n    \"é\"\n  ],\n  \"a\": {\n    \"x\": null,\n    \"y\": true\n  }\n}"
}

pub fn json_set_keeps_place_test() {
  let assert Ok(j) = json.decode("{\"a\": 1, \"b\": 2}")
  assert json.encode(json.set(j, "a", json.Int(3)), 0, False)
    == "{\"a\": 3, \"b\": 2}"
  assert json.encode(json.set(j, "c", json.Null), 0, False)
    == "{\"a\": 1, \"b\": 2, \"c\": null}"
}

pub fn json_quote_escapes_as_python_test() {
  assert json.quote("a\"b\\c\n\u{01}😀", True)
    == "\"a\\\"b\\\\c\\n\\u0001\\ud83d\\ude00\""
}

pub fn path_helpers_test() {
  assert sys.stem("papers/x/prose/01-intro.md") == "01-intro"
  assert sys.base_name("a/b.tar.gz") == "b.tar.gz"
  assert sys.stem("a/b.tar.gz") == "b.tar"
  assert sys.parent("a/b/c.md") == "a/b"
  assert sys.parent("c.md") == "."
  assert sys.join("a", "b") == "a/b"
}

pub fn run_and_sha_test() {
  let assert Ok(sys.Run(0, out)) = sys.run("printf", ["%s", "hi"], "")
  assert out == "hi"
  assert sys.sha256_hex(<<"x":utf8>>)
    == "2d711642b726b04401627ca9fbac32f5c8530fb1903cc4db02258717921a4881"
}

pub fn re_test() {
  let r = re.compile("^(\\w+): (\\d+)?", [re.Multiline])
  assert re.scan(r, "ação: 1\nb: \n")
    == [["ação: 1", "ação", "1"], ["b: ", "b", ""]]
  assert re.search(re.compile("a.b", [re.Dotall]), "a\nb")
  assert !re.search(re.compile("a.b", []), "a\nb")
  assert re.sub(re.compile("(o)", []), "foo", "[\\1]") == "f[o][o]"
  assert re.sub_first(re.compile("o", []), "foo", "0") == "f0o"
  assert re.split(re.compile(",\\s*", []), "a, b,c") == ["a", "b", "c"]
}

pub fn re_group_count_test() {
  let r = re.compile("(?:x)(?P<n>a)?([(]b)?(?=c)?(\\()?", [])
  assert re.scan(r, "x") == [["x", "", "", ""]]
}
