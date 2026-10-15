import fabric/timeline.{Era, Life}
import gleam/list

const tsv =
  "# comment\nnow\t2026\n3\tSocrates\t-470\t-399\tQ913\n2\tAustin Kleon\t1983\t\tQ1\n9\tNo Dates\t\t\t\n7\tCarl Jung\t1875\t1961\tQ41532\n"

pub fn parse_test() {
  let #(now, lives, unknown) = timeline.parse(tsv)
  assert now == 2026
  assert list.map(lives, fn(l) { l.name })
    == ["Socrates", "Carl Jung", "Austin Kleon"]
  assert unknown == ["No Dates"]
  assert list.last(lives) == Ok(Life(2, "Austin Kleon", 1983, Error(Nil)))
}

pub fn a_long_gap_is_cut_test() {
  let #(now, lives, _) = timeline.parse(tsv)
  let eras = timeline.eras(lives, now)
  // Socrates alone, then Jung and Kleon: 1983 - 1961 is less than max_gap, so they share an era.
  assert list.map(eras, fn(e) { #(e.start, e.end) })
    == [#(-478, -391), #(1867, 2034)]
}

pub fn the_scale_is_the_same_in_every_era_test() {
  let #(now, lives, _) = timeline.parse(tsv)
  let eras = timeline.eras(lives, now)
  assert timeline.x_of(eras, -400) - timeline.x_of(eras, -450)
    == 50 * timeline.px_per_year
  assert timeline.x_of(eras, 1950) - timeline.x_of(eras, 1900)
    == 50 * timeline.px_per_year
}

pub fn overlapping_lives_take_different_lanes_test() {
  let eras = [Era(1900, 2030, 0)]
  let a = Life(1, "A", 1900, Ok(1990))
  let b = Life(2, "B", 1950, Error(Nil))
  let c = Life(3, "C", 1995, Error(Nil))
  assert timeline.lanes([a, b, c], eras, 2026) == [#(a, 0), #(b, 1), #(c, 0)]
}

pub fn year_label_test() {
  assert timeline.year_label(-470) == "470 BCE"
  assert timeline.year_label(1821) == "1821"
}
