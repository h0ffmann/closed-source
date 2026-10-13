import fabric/cli

const opts = [cli.Value("--version"), cli.Flag("--dry-run")]

pub fn parse_prefix_and_equals_test() {
  let assert Ok(p) =
    cli.parse(["a.pdf", "--ver", "v1", "--dry"], opts, cli.Star)
  assert p.positionals == ["a.pdf"]
  assert cli.value(p, "--version") == Ok("v1")
  assert cli.flag(p, "--dry-run")
  let assert Ok(p) = cli.parse(["--version=v2", "x"], opts, cli.Star)
  assert cli.value(p, "--version") == Ok("v2")
}

pub fn parse_errors_test() {
  assert cli.parse(["--version"], opts, cli.Star)
    == Error(cli.Usage("argument --version: expected one argument"))
  assert cli.parse(["--dry-run=1"], opts, cli.Star)
    == Error(cli.Usage("argument --dry-run: ignored explicit argument '1'"))
  assert cli.parse(["a", "--dry-run", "b", "-x"], opts, cli.Star)
    == Error(cli.Usage("unrecognized arguments: b -x"))
  assert cli.parse(["a", "b"], opts, cli.Maybe)
    == Error(cli.Usage("unrecognized arguments: b"))
  assert cli.parse(["--bogus", "-h"], opts, cli.Star) == Error(cli.Help)
}

pub fn parse_double_dash_test() {
  let assert Ok(p) = cli.parse(["--", "--x", "-1"], opts, cli.Star)
  assert p.positionals == ["--x", "-1"]
  // A "--" after the positional was taken is left over, and kept.
  assert cli.parse(["a", "--dry-run", "--", "b"], opts, cli.Star)
    == Error(cli.Usage("unrecognized arguments: -- b"))
}

pub fn repr_test() {
  assert cli.repr("a") == "'a'"
  assert cli.repr("it's") == "\"it's\""
  assert cli.repr("'\"") == "'\\'\"'"
  assert cli.repr("a\nb\\") == "'a\\nb\\\\'"
}
