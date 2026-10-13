<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
<!-- easy: source="README.md"; sha256="a6f2e7eabfb0b6b799bd8752e632ed83ae866865469e692e6b0e0b1b85f85d77" -->
# versão fácil: closed source: the god that failed

> **esta é a versão fácil, em português, do [README.md](README.md).**
>
> - **vale o original.** se este texto e o original discordarem, vale o original, em inglês.
> - **feita a partir de:** a versão do original de 13 de outubro de 2026.
> - **para quem é:** quem quer entender o projeto sem ser da área.
> - **o que ficou de fora:** a lista completa de arquivos, a tabela de chaves e os detalhes do
>   envio ao arxiv. cada parte encurtada aponta para a seção do original.
> - **escrita por:** claude, com a skill [`easy-pt-br`](.claude/skills/easy-pt-br/SKILL.md);
>   revisão de matheus hoffmann.

este repositório guarda um artigo e a ferramenta que o produz. o artigo se chama *closed source:
the god that failed* ("código fechado: o deus que falhou"). a ferramenta se chama **paper
fabric**. ela recebe texto em markdown e entrega um PDF. ela confere cada referência e dá a cada
versão um identificador para citação. o estilo de trabalho é o da
[ouroboric](https://github.com/ouroboric-dev/ouroboric).

a ideia do artigo, em poucas palavras:

> o código fechado pediu aos pesquisadores que confiassem no segredo. entre 2024 e 2026, essa
> confiança falhou em público. se qualquer pessoa consegue desmontar qualquer programa para ver
> como ele funciona, o caminho honesto é outro: publicar o método, registrar um identificador e
> citar tudo o que você usa. o mesmo vale para os agentes de inteligência artificial, que hoje
> leem e escrevem boa parte do trabalho.

**autor:** a capa traz o nome mr. nobody. quem escreve, em primeira pessoa, é matheus hoffmann, da
escola politécnica da UFRJ. as ideias ouroboric são de bruno valério.
outros trabalhos do autor que você pode citar, cada um com seu DOI (um identificador que não
muda):
[marola](https://github.com/marola-dev/marola) ([10.5281/zenodo.23224155](https://doi.org/10.5281/zenodo.23224155)),
[ww3-gpu](https://github.com/h0ffmann/ww3-gpu) ([10.5281/zenodo.23221351](https://doi.org/10.5281/zenodo.23221351)) e
[picasso](https://github.com/h0ffmann/picasso) ([10.5281/zenodo.23311208](https://doi.org/10.5281/zenodo.23311208)).

**situação:** é a versão v0, um rascunho público (*preprint*). nenhuma revista revisou o texto
ainda. a [avaliação de prontidão](docs/1-product/readiness/2026-10-12-ready-to-promote.md) diz o
que falta para a v1.

**estilo.** o original é escrito em letras minúsculas, e esta versão também. só as siglas, como
UFRJ, DOI e PDF, ficam em maiúsculas. `just check` falha quando esta versão está mais velha que
o original.

## como gerar o PDF

você precisa de um computador com ubuntu e de dois programas: nix e just. o nix instala todas as
outras ferramentas sozinho, sempre nas mesmas versões. por isso o PDF sai igual em qualquer
máquina.

```sh
curl -fsSL https://nixos.org/nix/install | sh -s -- --daemon        # nix, uma vez; depois abra um novo terminal
echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf   # liga os flakes, uma vez
sudo apt install just                                               # just 1.21 no 24.04
just paper     # os PDFs, no laboratório paper do picasso -> pdf/
just book      # os PDFs e as conferências do livro (50 pensadores, linhas de autoria, referências, STE)
```

as ferramentas vêm do laboratório `paper` do
[h0ffmann/picasso](https://github.com/h0ffmann/picasso/tree/main/labs/paper). o arquivo
`flake.lock` fixa a versão de cada uma.

os comandos do dia a dia:

```sh
nix develop            # ou `just shell`: todas as ferramentas no PATH
just                   # cada artigo -> pdf/<slug>.pdf, pdf/<slug>-ste.pdf e pdf/<slug>-pt-BR.pdf
just build closed-source
just check             # gera, depois confere as referências e o STE (o que o CI roda)
just arxiv             # pacotes de código-fonte para o arxiv, conferidos com pdfLaTeX, em build/arxiv/
just --list            # todas as receitas
```

**as conferências.** os programas que conferem e geram arquivos ficam em `tools/`. eles são
escritos na linguagem gleam. você os chama com `tools/fabric <comando>`, e o `just` faz isso por
você.

cada artigo sai em três PDFs:

- o texto original, em inglês;
- o mesmo texto em inglês técnico simplificado (ASD-STE100), feito com o comando `/ste100`;
- a edição em português do brasil.

`just check` confere que as três versões têm as mesmas citações, os mesmos números e as mesmas
frases entre aspas.

o modo de montar o livro segue os livros de sandy maguire
([isovector/thinking-with-types](https://github.com/isovector/thinking-with-types)).

## site

a pasta `site/` é o site do artigo. o título, o resumo, os autores e as citações do site vêm do
artigo e do README. ninguém copia esses dados à mão, então o site não fica diferente do artigo.

```sh
just site-build        # os PDFs, depois site/dist/; precisa só de nix e just
just site-serve        # o mesmo, servido em http://localhost:8000
```

o github publica o site a cada mudança aceita no ramo `main`. para ligar isso, uma vez: no github,
em settings → pages → source, escolha **github actions**.

a aparência do site imita a capa de um livro: *democracy: the god that failed*, de hans-hermann
hoppe (2001). o site usa as cores e o tipo de letra dessa capa, de memória. ele não copia a arte
nem o texto do livro, que têm direito autoral. os logotipos da marola e da ouroboric são
carregados dos repositórios de cada projeto e não são copiados para cá
([`TRADEMARKS.md`](TRADEMARKS.md)). [`BOOKS.md`](BOOKS.md) fala dos livros por trás do projeto.

## o que há em cada pasta

os lugares principais:

| caminho | o que tem |
|---|---|
| [`papers/closed-source/`](papers/closed-source/) | o artigo: o texto, as referências e o registro de como cada referência foi conferida |
| [`site/`](site/) | o site |
| [`tools/`](tools/) e [`scripts/`](scripts/) | os programas que conferem, geram e publicam |
| [`docs/`](docs/README.md) | como o projeto trabalha: a carta, os modos de trabalho e o diário |
| [`50THINKERS.md`](50THINKERS.md) | os 50 pensadores do livro: duas páginas para cada um, 100 páginas |
| [`notes/`](notes/index.md) | as notas do livro, uma ideia em cada nota |
| [`.claude/skills/`](.claude/skills/README.md) | as skills (instruções para os agentes) escritas para este repositório. uma delas, `citation-score`, mede quanto de um texto tem citação |
| [`AGENTS.md`](AGENTS.md) | as regras que todo agente segue aqui |

a lista completa está na seção [layout](README.md#layout) do original.

## senhas e chaves

não há nenhum segredo neste repositório. para publicar uma versão, você precisa de:

- uma conta no github com verificação em duas etapas (2FA);
- uma chave SSH que possa enviar para este repositório;
- uma conta no zenodo ligada ao github, com este repositório ligado. o zenodo é o arquivo público
  que guarda cada versão e cria o DOI. nenhuma senha fica guardada;
- uma conta no arxiv, se você for enviar o artigo para lá.

**nunca** coloque uma senha ou um *token* em um arquivo, em uma *issue* ou em um *pull request*.
se um deles vazar, apague-o na hora e crie outro.

a tabela completa, com o passo a passo de cada item, está na seção
[secrets and keys](README.md#secrets-and-keys) do original.

## publicar uma versão

uma versão é uma etiqueta (*tag*) do git no ramo `main`. um comando cria a etiqueta. o resto
acontece sozinho.

1. **aceite** o *pull request*. confira que as conferências passaram no `main`.
2. **ensaie**: `just release minor --dry-run` roda todas as conferências e não cria nada.
3. **crie a etiqueta**:

   ```sh
   git switch main && git pull
   just release                   # lista o que ainda não foi publicado e sugere patch, minor ou major
   just release minor --dry-run   # mostra a etiqueta que será criada (ou diga o número: just release 0.2.0)
   just release minor             # cria a etiqueta (assinada, se você tiver uma chave de assinatura) e a envia
   just releases                  # as etiquetas de versão, da mais nova para a mais velha
   ```

4. **o CI** gera os PDFs e publica a versão no github, com os PDFs anexados.
5. **o zenodo** guarda a versão alguns minutos depois e cria o DOI dela. o DOI de todas as
   versões juntas é [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656).
   **atenção:** um DOI é para sempre. você não consegue apagar uma versão publicada.
6. **confira** a nova versão no zenodo.org: o título, os autores e a licença.
7. **o arxiv** é manual, pelo navegador. desde 31 de outubro de 2025, o arxiv só aceita artigos
   de opinião da área de computação depois da revisão de uma revista ou conferência
   ([blog do arxiv](https://blog.arxiv.org/?p=1740)). então este artigo só vai para lá depois de
   aceito.

o comando recusa a publicação se o `main` tiver mudanças não salvas, se o número da versão não
subir ou se nada tiver mudado além dos ponteiros das pastas em `forks/`.

o passo a passo completo, com o envio ao arxiv, está na seção
[release](README.md#release-a-new-zenodo-version-and-a-new-arxiv-pdf) do original e em
[releasing](docs/4-ways-of-working/releasing.md).

## como citar

### dois DOIs: o mais recente e o permanente

um DOI é um identificador que continua funcionando mesmo quando o endereço da página muda. este
trabalho tem dois tipos de DOI. cada um responde a uma pergunta.

| | DOI mais recente | DOI permanente |
|---|---|---|
| deste trabalho | [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656) | v0.1.0: [10.5281/zenodo.23333657](https://doi.org/10.5281/zenodo.23333657) |
| leva para | a versão mais nova, seja qual for no dia do clique | uma versão só, sempre o mesmo texto |
| quantos existem | um para o trabalho inteiro | um para cada versão |
| serve para | citar o trabalho | dizer exatamente qual texto você leu |

- **cite o DOI mais recente** na sua lista de referências. assim o leitor chega ao texto
  corrigido, e todas as citações contam para um só trabalho.
- **junte o DOI permanente** quando as palavras exatas importam: uma frase entre aspas, uma
  reprodução, uma revisão.
- nenhum dos dois pode ser apagado. uma versão errada continua no zenodo; uma versão nova só
  toma o lugar dela como a mais recente.

cada `just release` cria um DOI permanente novo. a
[página do zenodo](https://zenodo.org/doi/10.5281/zenodo.23333656) lista todas as versões.

as citações prontas, nos formatos bibtex, APA e ABNT, estão na seção [cite](README.md#cite) do
original. um programa gera esse bloco, então ele fica só lá.

## licença

- o texto do artigo, os documentos e as figuras: [CC BY 4.0](LICENSE). você pode copiar e
  adaptar, desde que cite o autor.
- os programas, as receitas e o site: [AGPL-3.0-only](LICENSES/AGPL-3.0-only.txt). quem usar e
  mudar o código precisa publicar as mudanças com a mesma licença.
- o modelo latex em `format/`, que outros artigos copiam: [MIT](LICENSES/MIT.txt).
- os nomes e os logotipos da ouroboric, do gleam e do claude code não são licenciados aqui.

a licença de cada arquivo está em [`REUSE.toml`](REUSE.toml).
