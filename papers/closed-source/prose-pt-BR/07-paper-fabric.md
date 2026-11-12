<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Paper Fabric: uma fábrica autoaperfeiçoável de artigos {#sec:fabric}

Paper Fabric é o pipeline aberto que produziu este preprint. Ele foi projetado para ser reutilizado
em qualquer artigo. Ele segue uma ideia de Bruno Valério: fábricas abertas e autoaperfeiçoáveis
que produzem trabalho, medem-no e realimentam a si mesmas com o que aprendem. Paper Fabric é um
experimento independente com essa ideia, para artigos.

## Princípios

Paper Fabric adota diretamente quatro dos princípios de Valério. *Humanos conduzem, agentes constroem*: eu
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

## Verificações

O build é cercado de verificações, cada uma um pequeno programa nas ferramentas do próprio
repositório, e a CI as executa em todo pull request. Eu as listo porque são elas que fazem das regras
da Seção [-@sec:citing] mais do que conselhos.

1. **Referências.** Cada chave da bibliografia precisa ter uma linha no log de referências, com
   situação `verified` ou `partial` e uma nota do que foi buscado; uma chave sem linha, ou uma linha
   sem chave, faz o build falhar.
2. **Citação em todo arquivo.** Cada arquivo Markdown do repositório nomeia o seu autor principal e o
   seu último autor numa linha; um arquivo sem essa linha falha.
3. **As traduções mantêm os fatos.** O artigo é escrito três vezes: em inglês, em ASD-STE100
   Simplified Technical English e em português do Brasil. Uma verificação compara cada versão com o
   texto em inglês e falha se uma citação, um número, uma citação literal ou um marcador de
   interpretação se perdeu ou foi acrescentado.
4. **Avisos são erros.** O Pandoc roda com avisos tratados como erros, então uma chave de citação não
   resolvida ou uma referência cruzada quebrada interrompe o build.
5. **Links vivos.** Os links dos arquivos Markdown do repositório são verificados em todo pull
   request.

## O ciclo

**[ANÁLISE]** O que torna o pipeline autoaperfeiçoável, e não meramente automatizado, é que cada artigo
alimenta o seguinte. O log de referências, a avaliação de prontidão e a configuração de agentes
exportada são mantidos no repositório. O artigo seguinte parte deles, e o diário registra o que deu
errado. Os defeitos conhecidos deste próprio artigo estão listados na avaliação de prontidão do
repositório, que faz parte do mesmo pull request que o introduziu.

**[ANÁLISE]** Esta versão é um exemplo do ciclo. O dono pediu, em 12 de novembro de 2026, que o artigo
fosse ampliado, que os seus buracos fossem preenchidos e que as suas evidências fossem trazidas até
aquele dia. O agente leu a avaliação de prontidão, que listava um número de processo não verificado,
uma entrada ausente para a antologia de 1949, um DOI ausente e uma frase quebrada; cada um está
corrigido nesta versão, e cada correção está no log de referências ou no diff. O que o agente não
podia fazer, escrever a experiência do próprio autor, ele deixou marcado para o autor.

## Esta versão em números

A versão de 12 de novembro de 2026 cresceu de 10 seções para 16. A sua bibliografia cresceu de 41
entradas para 81: cada uma das 40 novas entradas foi buscada naquele dia e tem uma linha no log de
referências, e 6 das 40 estão marcadas como `partial` porque um detalhe não pôde ser lido no
documento primário. O artigo existe em três edições construídas a partir das mesmas fontes e da
mesma bibliografia, e a verificação de tradução passa tanto para a edição em ASD-STE100 quanto para
a edição em português do Brasil. Uma passagem continua reservada ao autor, e nenhum agente a
escreveu.

**[ANÁLISE]** Dou esses números porque um artigo de posição sobre citação deve poder ser medido pelo
seu próprio padrão. Um leitor pode contar as entradas, abrir o log, seguir cada link e verificar se o
artigo fez o que pede aos outros. Se não fez, o defeito fica visível, e a próxima versão pode
corrigi-lo.
