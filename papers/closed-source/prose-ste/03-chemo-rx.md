# A closed-source confession: Chemo-RX {#sec:chemorx}

Matheus Hoffmann writes this section in the first person. The passages with the mark
**[AUTHOR ANECDOTE]** are placeholders for the author's own memories. The author must write them
before this paper leaves v0. An agent must not invent any part of them.

In 2018, I started an undergraduate thesis with the alias Chemo-RX at the Escola Politécnica of the
Universidade Federal do Rio de Janeiro. The thesis was in association with the LESS laboratory of
the Biomedical Engineering Programme. The goal was to compare statistical methods that predict
adverse reactions to chemotherapy in women who received treatment for breast cancer. The thesis used
data from Brazil's National Cancer Institute (INCA). The reactions in scope were asthenia, myalgia,
arthralgia, mucositis, abdominal pain and diarrhoea. The predictors included comorbidities,
demographic variables and single-nucleotide polymorphisms [@hoffmann2018chemorx].

The public trace of that work is a GitHub repository with eight commits between 23 March and 25
April 2018 [@hoffmann2018chemorx]. It contains a README, a proposal in OpenDocument format and a
data summary in R Markdown. The README has three headings that nobody ever completed: "Proposal EN
link", "Final project EN link" and "Thesis full content". Under the last heading, the only text is
"contact me". The to-do list of the proposal still contains "Add INCA formal license/ethic
regiment".

**[AUTHOR ANECDOTE: how the project started, who supervised it, and what the clinical question
meant to the people involved.]**

**[AUTHOR ANECDOTE: why the thesis text and code stayed closed. Was it a supervisor's
instruction, uncertainty about the data agreement, unfinished work, or simply never getting
round to it?]**

**[AUTHOR ANECDOTE: what was lost. For example, results that could not be reused, collaborators
who could not build on the work, or the experience of being unable to show the work later.]**

**[ANALYSIS]** That repository mixes two kinds of closedness, and the distinction is important for
the rest of this paper. The patient data could not be published, and it was correct not to publish
them. Clinical records are personal data, and ethics approval and data agreements control their
release, as the to-do list itself shows. But it was possible to publish the *method*: the
statistical code, the comparison protocol, the variable definitions and the negative results.

**[ANALYSIS]** The FAIR principles make this exact distinction. Data and software should be findable
and accessible *under well-defined conditions*, and these conditions can include restricted access.
Their metadata should stay public even when the data are not public [@wilkinson2016fair;
@barker2022fair4rs]. To close the method together with the data protected no patient. It only made
the work impossible to cite.

**[AUTHOR ANECDOTE: what the author has done differently since, leading into the open-source
projects in Section [-@sec:related].]**
