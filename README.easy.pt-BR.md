<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
<!-- easy: source="README.md"; sha256="54fc9ec854a43cb0596b2f57b39291bd71d37f58d17ff47bdeb75a7d313a46d8" -->
# versão fácil: closed source: the god that failed

> **esta é a versão fácil, em português, do [README.md](README.md).**
>
> - **vale o original.** se este texto e o original discordarem, vale o original, em inglês.
> - **feita a partir de:** a versão do original de 13 de novembro de 2026.
> - **para quem é:** quem quer entender o projeto sem ser da área.
> - **o que ficou de fora:** o bloco de citação gerado (bibtex, APA e ABNT), que fica na seção
>   [cite](README.md#cite) do original. os detalhes saíram do original e foram para
>   [building](docs/4-ways-of-working/building.md), [releasing](docs/4-ways-of-working/releasing.md)
>   e [the book](docs/1-product/the-book.md), em inglês.
> - **escrita por:** claude, com a skill [`easy-pt-br`](.claude/skills/easy-pt-br/SKILL.md);
>   revisão de matheus hoffmann.

este repositório guarda um livro, *closed source: the god that failed* ("código fechado: o deus
que falhou"). o livro diz que esconder o código não protege mais a ciência. então mostre como
você trabalha, dê ao trabalho um nome que não muda e diga quem ajudou você. o livro é feito com
a **paper fabric**: ela recebe texto em markdown, entrega um PDF e confere cada referência.

**leia o livro:** [no navegador](https://h0ffmann.github.io/closed-source/paper.pdf) ·
[o PDF](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source.pdf) ·
[em inglês técnico simplificado](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source-ste.pdf) ·
[em português](https://github.com/h0ffmann/closed-source/releases/latest/download/closed-source-pt-BR.pdf).

## a ideia, em cinco linhas

1. você monta um brinquedo e esconde como ele funciona.
2. desde 2024, agentes de inteligência artificial (AI) desmontam programas e copiam modelos.
   esconder não protege mais o brinquedo.
3. então mostre como você fez, dê a ele um DOI (um nome que não muda) e cite o que você usou.
4. o livro se apoia em *zen and the art of motorcycle maintenance* (1974), de robert m. pirsig:
   a ciência nunca se fecha. um método que só o dono abre, ninguém mais consegue testar
   ([a nota](notes/202610181353-pirsig-infinite-hypotheses-science-does-not-close.md)).
5. 66 páginas: 33 pensadores, duas páginas para cada um ([`33THINKERS.md`](33THINKERS.md)), em
   inglês e em português.

quem escreve é matheus hoffmann, da escola politécnica da UFRJ. a ideia de uma fábrica que
melhora a si mesma é de bruno valério. os parceiros são [piabrota](https://github.com/piabrota)
e [marola-dev](https://github.com/marola-dev).

**o estado:** a versão v0.4.0 está no ar ([versões](RELEASES.md)). no zenodo, ela é um livro. ela
não passou por revisão de outros cientistas (revisão por pares).

## monte o PDF

em qualquer ubuntu, você só precisa do nix e do just:

```sh
curl -fsSL https://nixos.org/nix/install | sh -s -- --daemon        # o Nix, uma vez; depois abra um terminal novo
echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf   # liga os flakes, uma vez
sudo apt install just                                               # just 1.21 no 24.04
just paper     # os PDFs -> pdf/
just book      # os PDFs e as conferências do livro
```

mais detalhes, em inglês: [building](docs/4-ways-of-working/building.md).

## lance uma versão

uma versão é uma etiqueta (tag) do git no `main`. `just release` cria a etiqueta, o CI publica e
o zenodo dá um DOI a ela. um DOI não pode ser apagado. por isso só pessoas lançam versões; os
agentes só preparam o pull request. os passos e as chaves, em inglês:
[releasing](docs/4-ways-of-working/releasing.md).

## como citar

cite o DOI mais recente. junte o DOI da versão quando as palavras exatas importam.

| | DOI mais recente (sempre a última versão) | DOI permanente (uma versão, para sempre) |
|---|---|---|
| deste trabalho | [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656) | v0.4.0: [10.5281/zenodo.24182034](https://doi.org/10.5281/zenodo.24182034); versões anteriores: [`RELEASES.md`](RELEASES.md) |

o texto pronto para citar (bibtex, APA e ABNT) está na seção [cite](README.md#cite) do original.

## saiba mais

| se você quer | vá para |
|---|---|
| a história do livro, as grandes referências, as licenças e como os leitores o acham | [the book](docs/1-product/the-book.md), em inglês |
| os livros por trás dele | [`BOOKS.md`](BOOKS.md) |
| os outros trabalhos abertos de quem escreve | [`WORKS.md`](WORKS.md) |
| as notas e os ensaios | [`notes/`](notes/index.md), [`essays/`](essays/index.md) |
| trabalhar aqui com um agente de programação | [`AGENTS.md`](AGENTS.md) |
| esta página no original, em inglês | [`README.md`](README.md) |

## licença

- o texto do livro, os documentos e as figuras: [CC BY 4.0](LICENSE).
- os scripts, os workflows, os arquivos de build e o site (`scripts/`, `.github/`, `justfile`,
  `flake.nix`, `site/`): [AGPL-3.0-only](LICENSES/AGPL-3.0-only.txt).
- o modelo de latex (`format/`), que outros livros copiam: [MIT](LICENSES/MIT.txt).
- o rodapé do site mostra a lucy, do gleam ([gleam-lang/branding](https://github.com/gleam-lang/branding)),
  e o ícone do claude code. os dois vêm dos sites dos donos, e nenhum é licenciado aqui.

a licença de cada arquivo está em [`REUSE.toml`](REUSE.toml).
