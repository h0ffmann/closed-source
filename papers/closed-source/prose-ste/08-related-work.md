# Related work by the same author {#sec:related}

The argument of this paper also describes how I worked from the time of the closed
thesis of Section [-@sec:chemorx] until now. Each project below is open source and has an archive
on Zenodo with a concept DOI. Each project also has machine-readable citation metadata.

- **WW3 GPU Lab** [@hoffmann2026ww3gpu]: a book, not yet complete, about agentic coding and
  agentic research. Its subject is the port of kernels of the WAVEWATCH III spectral wave model to
  GPUs with coding agents. A bit-for-bit parity harness compares the port with the Fortran
  reference.
- **marola** [@hoffmann2026marola]: an open, non-profit platform for sea conditions and
  bathing-water quality at Brazilian beaches. It uses public data. I am one
  of its creators.
- **picasso** [@hoffmann2026picasso]: self-contained Nix flakes that pin the toolchains of the
  projects above. These toolchains include a publication pipeline with pandoc and TeX Live.
  picasso is also a use case of a system that improves itself. When a project needs a tool, the
  need goes back into picasso as a new lab or a new tool. Then each project that uses picasso gets
  the tool when it updates. The `paper` and `gleam-website` labs, which build this paper and its
  website, came into picasso in this way.
- **nashkell** [@hoffmann2026nashkell]: a Haskell pipeline that reads the declassified Nash–NSA
  letters with OCR and a language model. It stores its identifiers in Latin through a Git filter.
  Section [-@sec:securing] examines it as an example of obfuscation and of the limits of
  obfuscation.

One influence is not my work. The ouroboric ideas in this paper are from Bruno Valério. His
project Ouroboric [@ouroboric2026] is about open factories that improve themselves, for software
and companies. Its documentation standard, its writing styles and its readiness checklist gave
Paper Fabric its form.

**[AUTHOR ANECDOTE: why the author has worked in the open for years, in the author's own words.
For example, what changed after Chemo-RX, and what open work has returned to the author.]**

For prior work by other authors on the subjects of this paper, refer to these four sources. Raymond
wrote about the social method of open source [@raymond1998cathedral]. Samuelson and Scotchmer
wrote about the law and economics of reverse engineering [@samuelson2002law]. Smith, Katz and
Niemeyer wrote about software citation [@smith2016software]. Barker and colleagues wrote about
FAIR research software [@barker2022fair4rs].
