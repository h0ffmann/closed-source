---
id: "202610132352"
title: "The first Scala: a risk project at UFRJ, 2017"
type: fleeting
status: partial
source: "Matheus Hoffmann, message, 2026-10-13: his own memory; and the public repository h0ffmann/mdd-risk-analysis at commit 75d09e0"
tags: [scala, ufrj, stone, origin, risk]
created: 2026-10-13
---
<!-- cite: main="Matheus Hoffmann"; last="Matheus Hoffmann" -->

# The first Scala: a risk project at UFRJ, 2017

My first project in the Scala language is public:
[h0ffmann/mdd-risk-analysis](https://github.com/h0ffmann/mdd-risk-analysis). MDD is the maximum
drawdown, a measure of risk. Each point below says what the record shows on 13 October 2026.

**What the repository shows (verified, read from GitHub at commit `75d09e0`).**

- It was made on 18 April 2017, and its description is "Risk analysis using Apache Spark.". The
  licence is Apache-2.0.
- GitHub counts 20,583 bytes of R and 5,198 bytes of Scala. The R is in `src/R-analysis/`. The
  Scala is four files, with `src/mdd/src/main/scala/mddApp.scala` as the Spark program;
  `src/README.md` names Apache Spark 2.1.0 and sbt.
- Almost all of the work is from 31 May to 29 June 2017, when the final report was added
  (`doc/AR_RelatFinal.pdf`). Three commits of 2019 only delete a file.
- `doc/` holds a thesis as a PDF, in a file named `Tese_IMPA_Maximo_Dropdown.pdf`. I did not open
  that file for this note, so the note does not say what the thesis argues.

**What I remember (unverified: it is my memory, and no record here proves it).**

- It was the work of a course named "Big Data" at UFRJ, given by prof1 (DEL/UFRJ, GTA). We were
  three: friend4, friend5 and I.
- The paper on the maximum drawdown came from IMPA, in Rio de Janeiro. We did its OCR by hand:
  we read it and typed it. I did that myself.
- We converted a part of the R to Scala, so that Spark could process it. Spark from R went wrong.
  That is how I learned Scala.
- At that time Stone was looking for an intern, six hours a day, for the Risk team, which was
  later named the ML team.

**Status: partial.** The repository is verified. The course, the people, the work by hand and
the opening at Stone are my memory.

What came of that opening: [[202610132353-marcus-baffa-laughed-with-me]]. Where the Scala and
the Erlang went: [[202610132355-gleam-principles-and-the-port-to-pure-gleam]].
