import fabric/citation
import fabric/html
import fabric/json
import fabric/sys
import gleam/string

pub fn self_test_cases_test() {
  assert citation.self_test_cases() == Ok(Nil)
}

pub fn validate_sample_test() {
  assert citation.validate(citation.sample()) == []
}

pub fn validate_errors_test() {
  let bad =
    citation.sample()
    |> json.set("version", json.String("v1"))
    |> json.set("license", json.String("it's"))
    |> json.set("language", json.String("eng\n"))
    |> json.set("upload_type", json.String("publication"))
    |> json.set(
      "contributors",
      json.Array([json.Object([#("name", json.String("Jane Doe"))])]),
    )
  assert citation.validate(bad)
    == [
      "publication_type must be one of ['article', 'book', 'preprint', 'report', 'technicalnote', 'workingpaper']",
      "license \"it's\" has no SPDX mapping here",
      "language must be an ISO 639-3 code such as eng",
      "version is set by Zenodo; remove it",
      "contributors[0]: name 'Jane Doe' is not 'Family, Given'",
      "contributors[0]: type None is not Zenodo's",
    ]
}

pub fn isbn_scheme_test() {
  let with = fn(id) {
    citation.sample()
    |> json.set(
      "related_identifiers",
      json.Array([
        json.Object([
          #("identifier", json.String("https://github.com/x/y")),
          #("relation", json.String("isSupplementTo")),
          #("scheme", json.String("url")),
        ]),
        json.Object([
          #("identifier", json.String(id)),
          #("relation", json.String("references")),
          #("scheme", json.String("isbn")),
        ]),
      ]),
    )
  }
  assert citation.validate(with("0688002307")) == []
  assert citation.validate(with("9780688002305")) == []
  assert citation.validate(with("0-688-00230-7"))
    == [
      "related_identifiers[1]: '0-688-00230-7' is not an ISBN of 10 or 13 digits, without hyphens",
    ]
}

pub fn orcid_test() {
  assert citation.orcid_ok("0000-0002-1825-0097")
  assert !citation.orcid_ok("0000-0002-1825-0098")
  assert citation.orcid_ok("0000-0002-1694-233X")
  assert !citation.orcid_ok("0000-0002-1825-009")
}

pub fn render_cff_test() {
  let assert Ok(cff) = citation.render_cff(citation.sample(), "")
  assert string.contains(cff, "family-names: \"Santos\"")
  assert string.contains(cff, "orcid.org/0009-0009-1056-7661")
  assert string.contains(cff, "  One & two.\n\n  Three.\n")
  assert !string.contains(cff, "doi:")
  assert string.contains(cff, "type: software\n")
  let assert Ok(cff) =
    citation.render_cff(citation.sample(), "10.5281/zenodo.1")
  assert string.contains(cff, "doi: 10.5281/zenodo.1\n")
}

pub fn render_refs_test() {
  let assert Ok(refs) = citation.render_refs(citation.sample(), "")
  assert string.contains(
    refs,
    "> Santos, M. H. F. (2026). *t* [Computer software]. https://github.com/x/y",
  )
  assert string.contains(
    refs,
    "> SANTOS, Matheus Hoffmann Fernandes. **t**. [S. l.]: GitHub, 2026. Disponível em: https://github.com/x/y.",
  )
  let no_repo =
    json.set(citation.sample(), "related_identifiers", json.Array([]))
  assert citation.render_refs(no_repo, "") |> is_error
}

fn is_error(r: Result(a, b)) -> Bool {
  case r {
    Ok(_) -> False
    Error(_) -> True
  }
}

pub fn add_person_test() {
  let assert Ok(meta) =
    citation.add_person(
      citation.sample(),
      "Doe, Jane",
      "0000-0002-1825-0097",
      "X",
      "Other",
      True,
    )
  let assert [_, jane] = json.get_list(meta, "creators")
  assert json.encode(jane, 0, False)
    == "{\"name\": \"Doe, Jane\", \"affiliation\": \"X\", \"orcid\": \"0000-0002-1825-0097\"}"
  assert citation.add_person(meta, "Doe, Jane", "", "", "Other", False)
    == Error("Doe, Jane is already listed")
}

pub fn splice_test() {
  let s = citation.start
  let e = citation.end
  assert citation.splice("a\n" <> s <> "\nold\n" <> e <> "\nb", "NEW")
    == Ok("a\nNEW\nb")
  assert citation.splice("a\n" <> s <> "\nold\n", "NEW") |> is_error
  assert citation.splice("nothing", "NEW") |> is_error
}

pub fn run_test() {
  let d = sys.temp_dir()
  let z = sys.join(d, ".zenodo.json")
  let c = sys.join(d, "CITATION.cff")
  let r = sys.join(d, "README.md")
  let assert Ok(_) = citation.write_json(z, citation.sample())
  let assert Ok(_) =
    sys.write(r, "# x\n\n" <> citation.start <> "\n" <> citation.end <> "\n")
  assert citation.run(z, c, True, [r]) == 1
  assert citation.run(z, c, False, [r]) == 0
  assert citation.run(z, c, True, [r]) == 0
  let assert Ok(_) = sys.write(c, "drift\n")
  assert citation.run(z, c, True, [r]) == 1
  sys.remove_all(d)
}

pub fn wrap_test() {
  assert citation.wrap("aa bb cc", 5) == ["aa bb", "cc"]
  assert citation.wrap("  ", 5) == []
  assert citation.wrap("abcdefgh x", 5) == ["abcdefgh", "x"]
}

pub fn python_str_helpers_test() {
  assert citation.py_split(" a\u{00A0}b\u{2003}c\n\nd ") == ["a", "b", "c", "d"]
  assert citation.py_strip("\u{3000} x y \n") == "x y"
  assert citation.repr_str("it's") == "\"it's\""
  assert citation.repr_str("a'b\"c\\\n") == "'a\\'b\"c\\\\\\n'"
  assert citation.repr_str("ação") == "'ação'"
  assert citation.repr(json.Null) == "None"
}

pub fn plain_test() {
  assert citation.plain("<p>One &amp; <b>two</b>.</p>\n <p>Three&nbsp;</p>")
    == "One & two.\n\nThree"
}

pub fn unescape_numeric_test() {
  assert html.unescape("&#233; &#xE9; &#XE9 &#65&#66;") == "é é é AB"
  // windows-1252 remap, replacement character, dropped code points, as Python's html.unescape.
  assert html.unescape("&#x80;&#150;&#0;&#13;") == "€–\u{FFFD}\r"
  assert html.unescape("&#55296;&#1114112;&#999999999999;")
    == "\u{FFFD}\u{FFFD}\u{FFFD}"
  assert html.unescape("a&#1;&#11;&#127;&#65534;&#x1FFFF;&#64976;b") == "ab"
  assert html.unescape("&#; &#x; &#xg;") == "&#; &#x; &#xg;"
}

pub fn unescape_named_test() {
  assert html.unescape("&amp; &AMP; &lt &gt; &quot; &apos;") == "& & < > \" '"
  assert html.unescape("&copy; &copy &eacute &Eacute;x &mdash; &hellip;")
    == "© © é Éx — …"
  assert html.unescape("&nbsp;x") == "\u{00A0}x"
  // Longest legacy prefix: &notit; is ¬it; and &ampx; is &x;, as in Python.
  assert html.unescape("&notin; &notit; &ampx;") == "∉ ¬it; &x;"
  assert html.unescape("&check; &ThickSpace; &fjlig;")
    == "✓ \u{205F}\u{200A} fj"
  assert html.unescape("&unknown; &bogus a&b && ;")
    == "&unknown; &bogus a&b && ;"
  assert html.unescape("no refs") == "no refs"
}

pub fn main_self_test_flag_test() {
  assert citation.main(["--self-test"]) == 0
}
