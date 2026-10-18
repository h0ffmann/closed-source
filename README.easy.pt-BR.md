<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
<!-- easy: source="README.md"; sha256="4fef77e5148e74ab11de6892b57c166ce866106dc2375bec58ecc2dc098fb5d8" -->
# versão fácil: closed source: the god that failed

> **esta é a versão fácil, em português, do [README.md](README.md).**
>
> - **vale o original.** se este texto e o original discordarem, vale o original, em inglês.
> - **feita a partir de:** a versão do original de 18 de outubro de 2026.
> - **para quem é:** quem quer entender o projeto sem ser da área.
> - **o que ficou de fora:** os comandos de cada seção que no original ficam fechados (clique
>   para abrir), a lista completa de arquivos, a tabela de chaves e os passos do envio ao arxiv.
>   cada parte encurtada aponta para a seção do original.
> - **escrita por:** claude, com a skill [`easy-pt-br`](.claude/skills/easy-pt-br/SKILL.md);
>   revisão de matheus hoffmann.

este repositório guarda um livro e a ferramenta que o produz. o livro se chama *closed source:
the god that failed* ("código fechado: o deus que falhou"). ele diz por que o código fechado
falhou como proteção, primeiro para a ciência, e o que fazer no lugar: publicar o método, dar a
ele um identificador e citar o que se usa. o livro se apoia em *zen and the art of motorcycle
maintenance* (1974), de robert m. pirsig. a ferramenta se chama **paper fabric**: ela recebe
texto em markdown, entrega um PDF e confere cada referência. o estilo é o da
[ouroboric](https://github.com/ouroboric-dev/ouroboric).

**leia o livro:** [veja o PDF no navegador, sem baixar](https://h0ffmann.github.io/closed-source/paper.pdf) ·
para baixar: [o PDF em inglês](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source.pdf) ·
[em inglês técnico simplificado](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source-ste.pdf) ·
[em português](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source-pt-BR.pdf).

## em um minuto

- **a tese.** o código fechado pediu aos pesquisadores que confiassem no segredo. entre 2024 e
  2026, essa confiança falhou em público. agentes de inteligência artificial desmontam
  programas, e perguntas bastam para copiar modelos. então o caminho honesto é publicar o
  método, dar a ele um identificador e citar o que se usa.
- **a raiz.** pirsig escreveu: "the number of rational hypotheses that can explain any given
  phenomenon is infinite" (o número de hipóteses racionais que podem explicar qualquer fenômeno
  é infinito; [a nota](notes/202610181353-pirsig-infinite-hypotheses-science-does-not-close.md)).
  então a ciência nunca se fecha. e um método que só o dono abre, ninguém mais consegue testar.
  por isso o livro põe o código aberto em primeiro lugar para a ciência.
- **a forma.** 100 páginas: 50 pensadores, duas páginas para cada um
  ([`50THINKERS.md`](50THINKERS.md)), em inglês e em português. a capa diz mr. nobody (senhor
  ninguém). quem escreve é matheus hoffmann, da escola politécnica da UFRJ. as ideias da
  ouroboric são de bruno valério.
- **o estado.** a versão v0.3.0 está publicada ([versões](RELEASES.md)). no zenodo, ela é um
  livro. ninguém revisou o livro ainda (não tem revisão por pares). o que falta para a v1 está
  na [avaliação](docs/1-product/readiness/2026-10-12-ready-to-promote.md).

## por onde começar

| se você quer | vá para |
|---|---|
| ler o livro | [o PDF no navegador](https://h0ffmann.github.io/closed-source/paper.pdf), ou [o site](https://h0ffmann.github.io/closed-source/) |
| ler a página original, em inglês | [`README.md`](README.md) |
| saber por que o livro existe | [a história e a intenção](#o-livro-a-história-e-a-intenção) |
| ver em que ele se apoia | [as grandes referências](#as-grandes-referências) |
| saber o que pode ser copiado aqui | [a pesquisa de licenças](#a-pesquisa-de-licenças) |
| ver os outros trabalhos do autor | [outros trabalhos do autor](#outros-trabalhos-do-autor) |
| ler as notas e os ensaios | [`notes/`](notes/index.md), [`essays/`](essays/index.md) |
| gerar o PDF você mesmo | [gerar o PDF](#gerar-o-pdf) |
| trabalhar aqui com um agente | [`AGENTS.md`](AGENTS.md), depois [o ciclo de engenharia](#o-ciclo-de-engenharia) |
| citar o livro | [citar](#citar) |

## o livro: a história e a intenção

o repositório e o primeiro rascunho nasceram em 12 de outubro de 2026, como um preprint (um
texto antes da revisão). no dia seguinte vieram três versões, e a v0.3.0 virou um livro no
zenodo ([a nota](notes/202610132130-why-i-wrote-fast-from-preprint-to-book.md)). as regras do
livro estão em [`AGENTS.md`](AGENTS.md): 100 páginas, 50 pensadores, duas línguas, os
"gurus de IA" como adversários, e o nome dos autores em cada arquivo.

- **o título** vem de *the god that failed*, um livro de 1949 de seis escritores que deixaram o
  comunismo. aqui a fé que falhou é menor: a crença de que código, modelos e métodos secretos
  continuam valiosos. as cores (preto, vermelho e o título em amarelo) vêm da capa de
  *democracy: the god that failed* (2001), de hans-hermann hoppe.
- **a intenção** é trocar o segredo pela citação profissional: identificadores que não mudam,
  dados que uma máquina lê, e agentes que citam e passam o crédito adiante. o próprio livro é
  feito assim, em público, com agentes.
- **o que ele não é.** ele não foi revisado por pares. ele discute ideias, não pessoas.

## as grandes referências

- **robert m. pirsig, *zen and the art of motorcycle maintenance* (ZAMM), 1974.** é o livro em
  que este se apoia: a qualidade, o motociclista que sabe abrir o motor, e as hipóteses
  infinitas do capítulo 10. ele está no resumo e na introdução. no `.zenodo.json`, ele entra
  pelo ISBN (o número do livro). o zenodo vai mostrar essa ligação a partir da próxima versão.
  veja [`BOOKS.md`](BOOKS.md), a [decisão ADR 001](docs/2-engineering/adr/001-pirsig-is-the-most-cited-author.md),
  a [biografia](BIO_ROBERT_PIRSIG.md) e o [ensaio](essays/2026-the-hypotheses-have-no-end.md).
- **hans-hermann hoppe, *democracy: the god that failed*, 2001.** dá a segunda metade do título e
  as cores. nada da capa nem do texto é copiado.
- **stephan kinsella; michele boldrin e david k. levine.** os argumentos contra a propriedade
  intelectual, ao lado do de hoppe.
- **michel de montaigne, *essays*.** o que um ensaio precisa ter. as regras dele conferem cada
  ensaio daqui ([`essay-montaigne`](.claude/skills/essay-montaigne/SKILL.md)).

## a pesquisa de licenças

antes de copiar qualquer coisa, a licença é lida e anotada. uma licença diz o que se pode fazer
com uma obra.

- **textos inteiros** só entram em [`works/`](works/index.md) quando são livres para copiar nos
  estados unidos e no brasil. nos estados unidos: publicados antes de 1931. no brasil: 70 anos
  depois da morte do autor (lei 9.610/98, art. 41). a skill
  [`ouro-get`](.claude/skills/ouro-get/SKILL.md) faz essa conta.
- **o ZAMM tem direitos autorais.** por isso ele só é citado em trechos curtos, com a página, e
  nunca copiado ([`QUOTES.md`](QUOTES.md)). o mesmo vale para o livro de hoppe e a capa dele.
- **código e skills emprestados** mantêm a linha de licença original.
  [`REUSE.toml`](REUSE.toml) guarda a licença de cada arquivo. nomes e logos de outros projetos
  não são licenciados aqui ([`TRADEMARKS.md`](TRADEMARKS.md)).
- **um trabalho da openai**, em `works/openai/`, foi copiado com a licença apache-2.0 dele
  ([`works/index.md`](works/index.md)).

## outros trabalhos do autor

cada um é aberto e tem um DOI (um identificador que não muda) que abre a versão mais recente.
este livro cita todos eles.

- [marola](https://github.com/marola-dev/marola): uma plataforma aberta, sem fins lucrativos,
  sobre o mar e a qualidade da água das praias do brasil.
  [10.5281/zenodo.23224155](https://doi.org/10.5281/zenodo.23224155)
- [ww3-gpu](https://github.com/h0ffmann/ww3-gpu): o modelo de ondas WAVEWATCH III rodando em
  placas de vídeo (GPUs), sem mudar a resposta.
  [10.5281/zenodo.23221351](https://doi.org/10.5281/zenodo.23221351)
- [picasso](https://github.com/h0ffmann/picasso): ambientes nix para ciência e para agentes. ele
  monta este livro. [10.5281/zenodo.23311208](https://doi.org/10.5281/zenodo.23311208)
- [nashkell](https://h0ffmann.github.io/nashkell/): um livro aberto, ainda em andamento, na voz
  de nash. [10.5281/zenodo.23356739](https://doi.org/10.5281/zenodo.23356739)

## o ciclo de engenharia

as ferramentas, as conferências e o site são feitos com agentes. aqui se usam duas ferramentas,
do mesmo jeito que no [ww3-gpu](https://github.com/h0ffmann/ww3-gpu).

- **compound engineering** é um plugin do claude code. cada problema resolvido deixa uma lição
  curta em [`docs/compound/`](docs/compound/README.md), e o próximo plano lê essa lição antes.
  as regras que valem mais que o plugin estão em [`AGENTS.md`](AGENTS.md#engineering-work-the-compound-loop).
- **archify** desenha um fluxo como uma página que você pode explorar. ele não é copiado: fica
  em `vendor/archify`, numa versão fixa. veja [`docs/archify/`](docs/archify/README.md).

## gerar o PDF

você precisa só de nix e just, em qualquer ubuntu. nada mais é instalado na máquina.

```sh
just paper     # os PDFs -> pdf/
just book      # os PDFs e as conferências do livro
```

os detalhes ficam na seção [build the PDF](README.md#build-the-pdf) do original.

## o site

a pasta `site/` é o site do livro, feito em gleam e lustre. o texto do site vem do próprio livro,
então nada é repetido à mão.

```sh
just site-build        # gera o site em site/dist/
just site-serve        # o mesmo, em http://localhost:8000
```

## os arquivos

a lista de pastas e arquivos está na seção [layout](README.md#layout) do original.

## segredos e chaves

nada secreto fica neste repositório. o que uma versão nova precisa (conta no github com 2FA,
chave SSH, conta no zenodo) está na seção [secrets and keys](README.md#secrets-and-keys) do
original. nunca publique uma senha ou um token.

## publicar uma versão nova

uma versão nova é uma marca (tag) no git. um comando faz a marca, o CI publica, e o zenodo dá um
DOI novo para ela. só uma pessoa publica: os agentes só preparam o pedido de mudança. um DOI é
para sempre, ninguém apaga. os passos estão na seção
[release](README.md#release-a-new-zenodo-version-and-a-new-arxiv-pdf) do original.

## citar

para citar o livro, use o DOI mais recente,
[10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656). ele sempre abre a versão
mais nova. quando a frase exata importa, cite também o DOI da versão que você leu. a v0.3.0 é
[10.5281/zenodo.23349831](https://doi.org/10.5281/zenodo.23349831). as referências prontas
(bibtex, APA e ABNT) estão na seção [cite](README.md#cite) do original.

## licença

- o texto do livro, os documentos e as figuras: [CC BY 4.0](LICENSE).
- os scripts, os fluxos do CI e o site: [AGPL-3.0-only](LICENSES/AGPL-3.0-only.txt).
- o modelo de latex (`format/`): [MIT](LICENSES/MIT.txt).
- os nomes e logos da ouroboric não são licenciados aqui.

a licença de cada arquivo está em [`REUSE.toml`](REUSE.toml).
