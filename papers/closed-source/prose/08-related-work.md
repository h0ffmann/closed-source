<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Related work by the same author {#sec:related}

The argument of this paper is also a description of how I have worked since the
closed thesis of Section [-@sec:chemorx]. Each project below is open source, archived on Zenodo
with a concept DOI, and carries machine-readable citation metadata.

- **WW3 GPU Lab** [@hoffmann2026ww3gpu]: a book in progress on agentic coding and agentic
  research, built around porting kernels of the WAVEWATCH III spectral wave model to GPUs with
  coding agents, under a bit-for-bit parity harness against the Fortran reference.
- **marola** [@hoffmann2026marola]: an open, non-profit platform for sea conditions and
  bathing-water quality at Brazilian beaches, built on public data. I am
  among its creators.
- **picasso** [@hoffmann2026picasso]: self-contained Nix flakes that pin the toolchains used by the
  projects above, including a pandoc and TeX Live publishing pipeline. picasso is also a use case
  of a self-improving system: when a project needs a tool, the need goes back into picasso as a new
  lab or a new tool, and every project that uses picasso receives it on its next update. The
  `paper` and `gleam-website` labs, which build this paper and its website, came into picasso
  that way.
- **nashkell** [@hoffmann2026nashkell]: a Haskell pipeline that reads the declassified Nash–NSA
  letters with OCR and a language model, and stores its identifiers in Latin through a Git filter;
  Section [-@sec:securing] discusses it as an example of obfuscation and its limits.

One influence is not my work. The ouroboric ideas in this paper are Bruno Valério's: Ouroboric
[@ouroboric2026], open factories that improve themselves, for software and companies. Its
documentation standard, writing styles and readiness checklist shaped Paper Fabric.

**[AUTHOR ANECDOTE: why the author has worked in the open for years, in the author's own words.
For example, what changed after Chemo-RX, and what open work has returned to the author.]**

For prior work by others on the themes of this paper, see Raymond on the social method of open
source [@raymond1998cathedral], Samuelson and Scotchmer on the law and economics of reverse
engineering [@samuelson2002law], Smith, Katz and Niemeyer on software citation
[@smith2016software] and Barker and colleagues on FAIR research software [@barker2022fair4rs].
