# Paper Fabric build, after Sandy Maguire's book Makefiles (isovector/thinking-with-types):
# Markdown prose -> pandoc (pandoc-crossref, citeproc, BibTeX) -> LaTeX -> XeLaTeX (build/Makefile).
#
#   make                     build every paper under papers/ into pdf/<slug>.pdf
#   make closed-source       build one paper
#   make check               build with warnings as errors and lint the reference log
#   make clean
#
# A paper is a directory papers/<slug>/ with metadata.md, prose/NN-*.md and refs.bib.

PAPERS   := $(notdir $(wildcard papers/*))
TEMPLATE := format/tex/template.tex

PANDOC_OPTS := --from markdown+fancy_lists+raw_tex \
               -F pandoc-crossref \
               --citeproc \
               --metadata link-citations=true \
               --number-sections \
               --top-level-division=section \
               --fail-if-warnings \
               -s

PANDOC_PDF_OPTS := --template $(TEMPLATE) -t latex

.PHONY: all check clean citation $(PAPERS)
all: $(PAPERS)

$(PAPERS): %: pdf/%.pdf

# Each paper: Markdown -> build/tex/<slug>.tex -> build/<slug>.pdf -> pdf/<slug>.pdf
.PRECIOUS: build/tex/%.tex
.SECONDEXPANSION:
build/tex/%.tex: papers/%/metadata.md $$(sort $$(wildcard papers/%/prose/*.md)) papers/%/refs.bib $(TEMPLATE) format/crossref.yaml
	@mkdir -p build/tex
	pandoc $(PANDOC_OPTS) $(PANDOC_PDF_OPTS) \
	  --metadata-file format/crossref.yaml \
	  --bibliography papers/$*/refs.bib \
	  -o $@ $(filter %.md,$^)

pdf/%.pdf: build/tex/%.tex
	$(MAKE) -C build $*.pdf
	@mkdir -p pdf
	cp build/$*.pdf $@

check: all
	python3 scripts/refs_check.py papers/*/refs.bib

citation:
	python3 scripts/citation.py

clean:
	$(MAKE) -C build clean
