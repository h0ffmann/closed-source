# Paper Fabric build, after Sandy Maguire's book Makefiles (isovector/thinking-with-types):
# Markdown prose -> pandoc (pandoc-crossref, citeproc, BibTeX) -> LaTeX -> XeLaTeX (build/Makefile).
#
#   make                     build every paper under papers/ into pdf/<slug>.pdf
#   make closed-source       build one paper
#   make check               build with warnings as errors and lint the reference log
#   make arxiv               pdfLaTeX-checked arXiv source bundles in build/arxiv/
#   make clean
#
# A paper is a directory papers/<slug>/ with metadata.md, prose/NN-*.md and refs.bib. A paper
# with a prose-ste/ directory (its ASD-STE100 text, .claude/commands/ste100.md) also builds
# pdf/<slug>-ste.pdf; prose-ste/00-metadata.md overrides metadata.md keys such as the abstract.

PAPERS   := $(notdir $(wildcard papers/*))
STE      := $(patsubst papers/%/prose-ste,%,$(wildcard papers/*/prose-ste))
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

.PHONY: all check clean citation arxiv $(PAPERS)
all: $(PAPERS)

$(PAPERS): %: pdf/%.pdf
$(foreach p,$(STE),$(eval $(p): pdf/$(p)-ste.pdf))

# Each paper: Markdown -> build/tex/<slug>.tex -> build/<slug>.pdf -> pdf/<slug>.pdf
.PRECIOUS: build/tex/%.tex
.SECONDEXPANSION:
build/tex/%-ste.tex: papers/%/metadata.md $$(sort $$(wildcard papers/%/prose-ste/*.md)) papers/%/refs.bib $(TEMPLATE) format/crossref.yaml
	@mkdir -p build/tex
	pandoc $(PANDOC_OPTS) $(PANDOC_PDF_OPTS) \
	  --metadata-file format/crossref.yaml \
	  --bibliography papers/$*/refs.bib \
	  -o $@ $(filter %.md,$^)

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
	for p in $(STE); do python3 scripts/ste_check.py $$p || exit 1; done

arxiv: all
	for p in $(PAPERS); do python3 scripts/arxiv.py $$p || exit 1; done

citation:
	python3 scripts/citation.py

clean:
	$(MAKE) -C build clean
	rm -f pdf/*.pdf
	rm -rf build/arxiv
