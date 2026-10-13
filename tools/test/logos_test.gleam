import fabric/logos
import fabric/sys

pub fn check_accepts_the_pinned_hash_test() {
  let data = <<"x":utf8>>
  assert logos.check(data, sys.sha256_hex(data), "u") == Ok(Nil)
}

pub fn check_refuses_a_wrong_hash_test() {
  let zeros = "0000000000000000000000000000000000000000000000000000000000000000"
  assert logos.check(<<"x":utf8>>, zeros, "u")
    == Error(
      "u: sha256 is 2d711642b726b04401627ca9fbac32f5c8530fb1903cc4db02258717921a4881, metadata.md pins "
      <> zeros,
    )
}

pub fn with_suffix_test() {
  assert logos.with_suffix("build/logos/marola.pdf", ".svg")
    == "build/logos/marola.svg"
  assert logos.with_suffix("build/a.b.pdf", ".svg") == "build/a.b.svg"
  assert logos.with_suffix("build/x", ".svg") == "build/x.svg"
  assert logos.with_suffix("build/.x", ".svg") == "build/.x.svg"
}
