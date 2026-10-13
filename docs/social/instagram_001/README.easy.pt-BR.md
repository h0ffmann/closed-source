---
title: "instagram_001, versão fácil: o livro, o autor, a ferramenta e os pensadores"
status: draft
date: 2026-10-13
related: [README.md, render.mjs, ../../../.claude/skills/easy-pt-br/SKILL.md]
style: reference
instagram: not posted
caption: pt-BR
---
<!-- cite: main="Claude"; last="Matheus Hoffmann" -->

# Versão fácil: o primeiro post do closed-source

> **Esta é a versão fácil, em português, de [README.md](README.md), e os slides dela.**
>
> - **Vale o original.** Se este texto e o original discordarem, vale o original, em inglês.
> - **Feita a partir de:** a versão do original de 13 de outubro de 2026.
> - **Para quem é:** quem vai ler o post sem ser da área de computação ou de pesquisa.
> - **O que ficou de fora:** como gerar os slides de novo. Isso está no original, em "Render again".
> - **Escrita por:** Claude, com a skill [`easy-pt-br`](../../../.claude/skills/easy-pt-br/SKILL.md);
>   revisão de Matheus Hoffmann.

**Não foi postado.** Quem posta é o dono do repositório. Um agente não posta.

São cinco slides em português, no tamanho do Instagram (1080x1350). Eles contam a mesma história
do post em inglês, com frases mais curtas e com cada palavra difícil explicada. Cada número tem a
fonte escrita embaixo dele.

## Os slides

| Slide | O que mostra | De onde vem |
|---|---|---|
| [slide-1.easy.pt-BR.png](slide-1.easy.pt-BR.png) | o livro: a capa em preto, vermelho e letras amarelas; a frase "cite o que você pega emprestado"; o DOI | [10.5281/zenodo.23333656](https://doi.org/10.5281/zenodo.23333656) |
| [slide-2.easy.pt-BR.png](slide-2.easy.pt-BR.png) | o autor: na capa está Mr. Nobody; quem escreve é Matheus Hoffmann; três outros trabalhos dele | [`metadata.md`](../../../papers/closed-source/metadata.md) |
| [slide-3.easy.pt-BR.png](slide-3.easy.pt-BR.png) | a ferramenta `citation-score` e a nota de cinco páginas de projeto | [`CITATION_SCORES.md`](../../../CITATION_SCORES.md) |
| [slide-4.easy.pt-BR.png](slide-4.easy.pt-BR.png) | os 50 pensadores do livro e as 41 referências do artigo | [`50THINKERS.md`](../../../50THINKERS.md), [`REFERENCES.md`](../../../papers/closed-source/REFERENCES.md) |
| [slide-5.easy.pt-BR.png](slide-5.easy.pt-BR.png) | o convite: publique, registre, cite; onde ler | a citação gerada no [README](../../../README.md#cite) |

## As palavras difíceis

- **Código fechado** (*closed source*): um programa que você pode usar, mas não pode ler por
  dentro.
- **Engenharia reversa**: desmontar um programa pronto para descobrir como ele foi feito.
- **DOI**: um endereço permanente para um trabalho. O site pode mudar de lugar; o DOI continua
  funcionando. Por isso se cita o DOI.
- **Zenodo**: um arquivo público que guarda trabalhos de pesquisa e cria o DOI de cada um.
- **README**: a página de entrada de um projeto, que diz o que ele é.
- **Citação**: dizer de onde veio uma ideia, uma frase ou um número.
- **Preprint**: um artigo publicado antes de uma revista revisar. Este é um preprint.
- **Skill**: uma instrução escrita para um agente de inteligência artificial fazer uma tarefa.

## O que a nota de citação quer dizer

A `citation-score` lê um texto e conta quantas frases apontam para uma fonte. Uma frase aponta
para uma fonte quando tem um link, um DOI, ou um autor e um ano.

- **100%** quer dizer que todas as frases apontam para uma fonte. A escala chama isso de
  "perfeito, nível máximo de maturidade".
- **0%** quer dizer que nenhuma frase aponta para uma fonte. A escala chama isso de "fraco, QI de
  2 dígitos". As duas frases são do dono do repositório.
- **A nota é do texto, não da pessoa.** Uma nota baixa não é um defeito. Uma página que conta o
  que o autor fez, com as palavras dele, tem pouco para citar.
- **A ferramenta conta as marcas.** Ela não sabe se a citação está certa.

## Legenda (pt-BR, versão fácil)

```text
Saiu a primeira versão de "Closed Source: The God that Failed" ("Código fechado: o deus que falhou").

A ideia é simples. Código fechado é um programa que você usa, mas não pode ler por dentro. Hoje, com inteligência artificial, qualquer pessoa consegue desmontar um programa e ver como ele funciona. Então esconder não protege mais. O caminho honesto é outro: mostrar como você fez e citar de quem você pegou cada ideia.

O livro vai ter 100 páginas: 50 pensadores, duas páginas para cada um.

Junto vem uma ferramenta, a citation-score. Ela lê um texto e diz quanto dele tem citação. Ela conta as citações, mas não confere se estão certas.

O trabalho tem um DOI, que é um endereço que não muda: 10.5281/zenodo.23333656. Ainda é um rascunho público. Nenhuma revista revisou o texto.

As fontes estão em cada slide. Site, artigo e código: link na bio.

#codigoaberto #opensource #citacao #pesquisa #doi
```

Link na bio: https://h0ffmann.github.io/closed-source/

## Texto alternativo

1. Um bloco de capa de livro: CLOSED SOURCE em letras amarelas sobre preto, THE GOD THAT FAILED em uma faixa vermelha. Texto: hoje qualquer pessoa consegue desmontar um programa para ver como ele funciona, então cite o que você pega emprestado. O DOI 10.5281/zenodo.23333656, um endereço que não muda. Uma coruja desenhada com uma linha.
2. O autor. Na capa, Mr. Nobody; atrás dela, uma pessoa: Matheus Hoffmann, da Escola Politécnica da UFRJ. Três outros trabalhos com DOI: marola, ww3-gpu e picasso. Um rosto desenhado com uma linha.
3. A ferramenta. Quanto do seu texto tem citação? 100%: perfeito, nível máximo de maturidade. 0%: fraco, QI de 2 dígitos. Cinco páginas de projeto medidas em barras: closed-source 30%, marola 48%, ouroboric-dev 50%, h0ffmann 73%, picasso 42%. Ela conta as marcas e não confere se a citação está certa.
4. As referências. 50 pensadores, duas páginas para cada um: 100 páginas, 42 pensadores com nome e 8 lugares abertos; 41 referências no artigo, cada uma lida antes de ser citada. Catorze nomes, de Auguste Kerckhoffs a Geoffrey Hinton. Um violão desenhado com uma linha.
5. Publique o método, registre um identificador, cite o que você usa. Um artigo de opinião, versão v0, que nenhuma revista revisou ainda. O DOI, o site e o código. Uma pomba desenhada com uma linha.
