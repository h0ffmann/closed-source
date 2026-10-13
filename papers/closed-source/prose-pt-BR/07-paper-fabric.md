<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Paper Fabric: uma fábrica ourobórica de artigos {#sec:fabric}

Paper Fabric é o pipeline aberto que produziu este preprint. Ele foi projetado para ser reutilizado
em qualquer artigo e segue a filosofia do Ouroboric, o projeto de Bruno Valério, cuja carta descreve "open,
self-improving factories" (em tradução livre: fábricas abertas e autoaperfeiçoáveis) que produzem
trabalho, medem-no e realimentam a si mesmas com o que aprendem [@ouroboric2026]. A carta do
Ouroboric lista uma fábrica de pesquisa "for scientific
research and papers" (em tradução livre: para
pesquisa científica e artigos) como uma possível direção futura, explicitamente não um compromisso
[@ouroboric2026]. Paper Fabric é um experimento independente nessa direção.

## Princípios

Paper Fabric adota diretamente quatro dos princípios do Ouroboric; as ideias são de Valério. *Humanos conduzem, agentes constroem*: eu
aprovo a direção e cada afirmação que se apoia na minha própria experiência; os agentes redigem,
verificam e constroem. *Verificações, não promessas*: as citações são conferidas com a fonte, e o
build falha diante de uma citação ausente. *Leia antes de tomar emprestado*: as licenças decidem o
que pode ser reutilizado, e dá-se crédito pelo que é tomado. *Aprenda em público*: o pipeline, os
prompts e a configuração de agentes que produziram um artigo são publicados junto com ele.

## Pipeline

O conjunto de ferramentas segue os livros de Sandy Maguire [@maguire2019thinking]: a prosa é escrita
em Markdown, um arquivo por seção, e um `justfile` executa o pandoc com um template LaTeX
personalizado e uma bibliografia BibTeX, depois o XeLaTeX, e carimba o PDF com a revisão do Git a
partir da qual foi gerado. Um flake Nix fixa cada ferramenta em uma única versão, por meio do lab
`paper` do picasso [@hoffmann2026picasso]. O citeproc embutido do pandoc resolve as citações, e o
build roda com avisos tratados como erros, de modo que uma chave de citação não resolvida
interrompe o build.

Cada artigo fica em seu próprio diretório, `papers/<slug>/`, com um `metadata.md`, arquivos de prosa
numerados e um `refs.bib`. Os metadados de citação do repositório (`.zenodo.json`, a partir do qual
o `CITATION.cff` é gerado) são tomados emprestados, com crédito, dos meus projetos anteriores
[@hoffmann2026picasso; @hoffmann2026marola]. Um release é uma tag do Git. Para a v0, o workflow de
release gera o PDF, anexa-o a um release do GitHub e, somente quando um mantenedor fornece um token
do Zenodo, envia *apenas o PDF* para um depósito em rascunho no Zenodo. Publicar o depósito, o que
emite um DOI permanente, continua sendo uma decisão humana.

## O ciclo

**[ANÁLISE]** O que torna o pipeline ourobórico, e não meramente automatizado, é que cada artigo
alimenta o seguinte. O log de referências, a avaliação de prontidão e a configuração de agentes
exportada são mantidos no repositório. O artigo seguinte parte deles, e o diário registra o que deu
errado. Os defeitos conhecidos deste próprio artigo estão listados na avaliação de prontidão do
repositório, que faz parte do mesmo pull request que o introduziu.
