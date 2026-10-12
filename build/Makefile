# Runs XeLaTeX twice (cross-references, then page numbers) and stamps the Git revision, as in
# isovector/thinking-with-types/build/Makefile.

%.pdf: tex/%.tex .current-revision
	xelatex -interaction=nonstopmode -halt-on-error tex/$*.tex > /dev/null
	xelatex -interaction=nonstopmode -halt-on-error tex/$*.tex > /dev/null

.current-revision: git-revision
	git rev-parse --short HEAD | tr -d '\n' > .current-revision
	echo -n "+" >> .current-revision
	git rev-list --count HEAD | tr -d '\n' >> .current-revision

.PHONY: git-revision clean

clean:
	rm -f tex/*.tex *.aux *.log *.out *.pdf .current-revision
