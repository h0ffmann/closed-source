<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# A closed-source confession: Chemo-RX {#sec:chemorx}

This section is written in the first person by Matheus Hoffmann. Passages marked
**[AUTHOR ANECDOTE]** are placeholders for the author's own recollections. They must be written by
the author before this paper leaves v0; nothing in them may be invented by an agent.

In 2018 I started an undergraduate thesis at the Escola Politécnica of the Universidade Federal do
Rio de Janeiro, in association with the LESS laboratory of the Biomedical Engineering Programme. Its
alias was Chemo-RX. The goal was to compare statistical methods for predicting adverse reactions to
chemotherapy in women treated for breast cancer, using data from Brazil's National Cancer Institute
(INCA). The reactions in scope were asthenia, myalgia, arthralgia, mucositis, abdominal pain and
diarrhoea, and the predictors included comorbidities, demographic variables and single-nucleotide
polymorphisms [@hoffmann2018chemorx].

The public trace of that work is a GitHub repository with eight commits between 23 March and
25 April 2018 [@hoffmann2018chemorx]. It holds a README, a proposal in OpenDocument format and an
R Markdown data summary. The README has three headings that were never filled in: "Proposal EN
link", "Final project EN link" and "Thesis full content". Under the last one it says only "contact
me". The proposal's to-do list still includes "Add INCA formal license/ethic regiment".

**[AUTHOR ANECDOTE: how the project started, who supervised it, and what the clinical question
meant to the people involved.]**

**[AUTHOR ANECDOTE: why the thesis text and code stayed closed. Was it a supervisor's
instruction, uncertainty about the data agreement, unfinished work, or simply never getting
round to it?]**

**[AUTHOR ANECDOTE: what was lost. For example, results that could not be reused, collaborators
who could not build on the work, or the experience of being unable to show the work later.]**

**[ANALYSIS]** Two kinds of closedness are mixed in that repository, and the distinction matters
for the rest of this paper. The patient data could not be published, and should not have been:
clinical records are personal data, and their release is governed by ethics approval and data
agreements, which the to-do list itself acknowledges. The *method* could have been published: the
statistical code, the comparison protocol, the variable definitions and the negative results. The
FAIR principles make exactly this distinction. Data and software should be findable and
accessible *under well-defined conditions*, which may include restricted access, and their
metadata should remain public even when the data are not [@wilkinson2016fair; @barker2022fair4rs].
Closing the method along with the data protected no patient. It only made the work uncitable.

**[AUTHOR ANECDOTE: what the author has done differently since, leading into the open-source
projects in Section [-@sec:related].]**
