//// The writer's top 10 projects, shown as a plain list at the bottom of the page.
//// The order is the ranking: move a line up or down to reorder it. Ranked by GitHub stars,
//// then by how much work the repository holds and how recently it moved (November 2026).

pub type Project {
  Project(name: String, href: String, text: String)
}

pub const projects = [
  Project(
    "marola",
    "https://github.com/marola-dev/marola",
    "water super app, in Rust.",
  ),
  Project(
    "gramatico",
    "https://github.com/piabrota/gramatico",
    "portuguese (Brazil) on rails, in Rust.",
  ),
  Project(
    "ww3-gpu",
    "https://github.com/h0ffmann/ww3-gpu",
    "a bit-for-bit GPU port of WAVEWATCH III, built with agentic coding and research.",
  ),
  Project(
    "pirsig",
    "https://github.com/piabrota/pirsig",
    "an agentic brain.",
  ),
  Project(
    "proof",
    "https://github.com/h0ffmann/proof",
    "Agda paper experiments.",
  ),
  Project(
    "nix-os",
    "https://github.com/piabrota/nix-os",
    "a software and research factory with Hermes Agent and the OpenRig spec.",
  ),
  Project(
    "chaceon",
    "https://github.com/h0ffmann/chaceon",
    "CPU/GPU wave modelling in pure agentic Rust.",
  ),
  Project(
    "picasso",
    "https://github.com/h0ffmann/picasso",
    "deterministic toolchains with just, Nix and Rust.",
  ),
  Project(
    "marola-research",
    "https://github.com/marola-dev/marola-research",
    "marola's science, in Gleam.",
  ),
  Project(
    "room",
    "https://github.com/piabrota/room",
    "a personal site that is a 3D room, with VHS tapes and lofi radio. three.js and Vite.",
  ),
]
