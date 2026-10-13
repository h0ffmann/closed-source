import fabric/cite_check

fn known() -> List(String) {
  cite_check.personas(
    "| A | person | x | y |\n| B | agent | x | y |\n| Kind | x |",
  )
}

pub fn personas_test() {
  assert known() == ["A", "B"]
}

pub fn check_test() {
  let good = "<!-- cite: main=\"A\"; last=\"B\" -->\n# T\n"
  assert cite_check.check("f", good, known()) == []
  assert cite_check.check("f", "---\nt: 1\n---\n" <> good, known()) == []
  assert cite_check.check("f", "# T\n" <> good, known())
    == ["f: no cite line after the front matter (see PERSONAS.md)"]
  assert cite_check.check("f", "---\nt: 1\n", known())
    == ["f: no cite line after the front matter (see PERSONAS.md)"]
  assert cite_check.check(
      "f",
      "<!-- cite: main=\"C\"; last=\"B\" -->\n",
      known(),
    )
    == ["f: main author 'C' is not in PERSONAS.md"]
}

pub fn verbatim_test() {
  assert cite_check.verbatim("---\ntitle: x\nverbatim: [a.md, b.md]\n---\n")
    == ["a.md", "b.md"]
  assert cite_check.verbatim("---\ntitle: x\n---\nverbatim: [a.md]\n") == []
}
