import fabric/ouroboric
import gleam/string

pub fn recorded_takes_first_hash_per_known_repo_test() {
  let a = string.repeat("a", 40)
  let text =
    "| [ouroboric-dev/ouroboric](x) | `"
    <> a
    <> "` |\n| ouroboric-dev/nope | "
    <> string.repeat("b", 40)
    <> "\n| ouroboric-dev/.github | "
    <> string.repeat("c", 40)
    <> "\n| ouroboric-dev/ouroboric-packages | "
    <> string.repeat("d", 40)
    <> "\nouroboric-dev/ouroboric again "
    <> string.repeat("e", 40)
  assert ouroboric.recorded(text)
    == [
      #("ouroboric", a),
      #(".github", string.repeat("c", 40)),
      #("ouroboric-packages", string.repeat("d", 40)),
    ]
}

pub fn recorded_needs_a_whole_name_and_hash_test() {
  let h = string.repeat("f", 40)
  assert ouroboric.recorded("ouroboric-dev/asgardx " <> h) == []
  assert ouroboric.recorded("ouroboric-dev/asgard " <> h <> "0") == []
  assert ouroboric.recorded("ouroboric-dev/asgard\n" <> h) == []
}
