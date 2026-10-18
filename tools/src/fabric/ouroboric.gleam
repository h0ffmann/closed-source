//// ouroboric: fetch the public ouroboric-dev repositories and show what changed since
//// OUROBORIC.md.
////
//// OUROBORIC.md and OUROBORIC_RESEARCH.md are digests that an agent writes (`/update-ouroboric`).
//// Their header tables record each repository at a full commit hash. This clones or updates each
//// repository into build/ouroboric/<repo>, then prints, per repository, the recorded commit, the
//// current one and the files that changed between them, so the agent reads only what is new.
////
//// ouroboric-dev/huldra (and ouroboric-dev/contact, if it exists) is private, so it is not in
//// `repos`. Add a repository here when the organisation publishes a new one.

import fabric/re
import fabric/sys
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub const repos = [
  "ouroboric", "yggdrasil", "asgard", ".github", "ouroboric-packages", "odin",
  "midgard-react", "helheim-go", "gleipnir", "havamal", "gungnir", "jormungandr",
  "mimir",
]

fn row_re() -> re.Regex {
  // The script put longer names first; the lookahead after the group already makes the
  // order irrelevant ("ouroboric" cannot match the start of "ouroboric-packages").
  let names = list.map(repos, escape) |> string.join("|")
  re.compile(
    "ouroboric-dev/(" <> names <> ")(?![A-Za-z0-9._-]).*?\\b([0-9a-f]{40})\\b",
    [],
  )
}

fn escape(name: String) -> String {
  string.replace(name, ".", "\\.") |> string.replace("-", "\\-")
}

/// str.splitlines()
fn lines(text: String) -> List(String) {
  let parts =
    re.split(
      re.compile(
        "\\r\\n|[\\n\\r\\x{0b}\\x{0c}\\x{1c}\\x{1d}\\x{1e}\\x{85}\\x{2028}\\x{2029}]",
        [],
      ),
      text,
    )
  case list.reverse(parts) {
    ["", ..rest] -> list.reverse(rest)
    _ -> parts
  }
}

/// The first full commit hash on each line that names ouroboric-dev/<repo>.
pub fn recorded(text: String) -> List(#(String, String)) {
  let r = row_re()
  list.fold(lines(text), [], fn(out, line) {
    case re.first(r, line) {
      Ok([_, repo, hash, ..]) ->
        case list.key_find(out, repo) {
          Ok(_) -> out
          Error(_) -> list.append(out, [#(repo, hash)])
        }
      _ -> out
    }
  })
}

/// git's stdout, stripped; its stderr is dropped, as the script's capture_output=True did.
fn git(args: List(String), cwd: String) -> Result(String, String) {
  sys.check_output(
    "sh",
    ["-c", "exec git \"$@\" 2>/dev/null", "git", ..args],
    cwd,
  )
  |> result.map(string.trim)
}

fn sync(repo: String, base: String) -> Result(String, String) {
  let path = sys.join(base, repo)
  case sys.is_dir(sys.join(path, ".git")) {
    True -> {
      use _ <- result.try(git(["fetch", "-q", "origin"], path))
      use _ <- result.try(git(["reset", "-q", "--hard", "origin/HEAD"], path))
      Ok(path)
    }
    False -> {
      use _ <- result.try(sys.make_dirs(base))
      use _ <- result.try(git(
        ["clone", "-q", "https://github.com/ouroboric-dev/" <> repo, path],
        "",
      ))
      Ok(path)
    }
  }
}

fn report(repo: String, old: List(#(String, String))) -> Result(Nil, String) {
  use path <- result.try(sync(repo, "build/ouroboric"))
  use head <- result.try(git(["rev-parse", "HEAD"], path))
  use date <- result.try(git(["log", "-1", "--format=%cs"], path))
  io.println(
    "## ouroboric-dev/" <> repo <> "  " <> head <> "  (" <> date <> ")",
  )
  case list.key_find(old, repo) {
    Error(_) -> io.println("  not in OUROBORIC.md yet: read all of it")
    Ok(rec) if rec == head -> io.println("  unchanged")
    Ok(rec) -> {
      let changed = case git(["diff", "--name-status", rec, head], path) {
        Ok(c) -> c
        Error(_) ->
          "  recorded " <> rec <> " is not in the history: read all of it"
      }
      io.println("  since " <> string.slice(rec, 0, 12) <> ":")
      io.println(case lines(changed) {
        [] -> "  (no file changes)"
        ls -> string.join(list.map(ls, fn(l) { "  " <> l }), "\n")
      })
    }
  }
  Ok(Nil)
}

pub fn main(_args: List(String)) -> Int {
  let old = case sys.read("OUROBORIC.md") {
    Ok(text) -> recorded(text)
    Error(_) -> []
  }
  let failed =
    list.fold_until(repos, Ok(Nil), fn(_, repo) {
      case report(repo, old) {
        Ok(Nil) -> list.Continue(Ok(Nil))
        Error(e) -> list.Stop(Error(e))
      }
    })
  case failed {
    Ok(Nil) -> 0
    Error(e) -> {
      sys.eprintln("ouroboric: " <> e)
      1
    }
  }
}
