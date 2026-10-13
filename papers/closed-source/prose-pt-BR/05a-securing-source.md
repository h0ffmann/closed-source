<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Ofuscação, as cartas de Nash e como proteger código-fonte em 2026 {#sec:securing}

Se o sigilo falha como proteção, o que resta para o código que precisa permanecer privado, e para o
código público do qual outros dependem? Esta seção examina uma resposta tentadora, a ofuscação, e
a resposta que a criptografia oferece em seu lugar.

## As cartas de Nash: segurança pela computação, não pela ocultação

No início de 1955, John Nash, autor do conceito de equilíbrio para jogos não cooperativos
[@nash1950equilibrium], escreveu à National Security Agency dos EUA para propor uma máquina de
cifragem [@nash1955letters]. A NSA tornou pública a
correspondência em 2012 [@branwen2012nash]. Nela, Nash argumentava que, para cifras suficientemente
complexas, "the mean key computation length increases exponentially with the length of the key"
(em tradução livre: o comprimento médio da computação da chave cresce exponencialmente com o
comprimento da chave) [@branwen2012nash]. A ideia é que a segurança deve repousar sobre o custo da
computação, e não sobre a ocultação do projeto. Rivest, Shamir e seus alunos leram as cartas como
uma antecipação da teoria da complexidade e da criptografia moderna [@rivest2012nash]. A máquina do próprio Nash não teve a mesma sorte. A NSA julgou que ela "affords only limited security" (em tradução livre: oferece apenas segurança limitada)
[@nash1955letters], e, quando Ronald Rivest, Adi Shamir e seus alunos a analisaram em 2012,
encontraram um ataque de texto claro escolhido em tempo polinomial e um ataque de texto claro
conhecido em tempo subexponencial, e concluíram que Nash era "a much better game theorist
than a cryptographer" (em tradução livre: um teórico dos jogos muito melhor do que criptógrafo)
[@rivest2012nash].

**[ANÁLISE]** As duas metades da história apoiam Kerckhoffs. O princípio de Nash, segurança a partir
do trabalho que um atacante precisa realizar, é o que a criptografia moderna conservou. Seu projeto,
uma vez publicado, foi avaliado e quebrado por outros. É assim que a criptografia deve funcionar: o
método é aberto, e somente a chave é secreta.

## Ofuscação: o que ela oferece e o que não pode oferecer

A ofuscação transforma um programa de modo que ele faça a mesma coisa, mas seja mais difícil de
ler. Um dos
Eu construí um exemplo pequeno e honesto. *nashkell*, um pipeline em Haskell que executa OCR sobre
as cartas desclassificadas de Nash e pede a um modelo de linguagem que as anote e as confronte entre
si, armazena seu código-fonte no Git com os identificadores traduzidos para o latim
[@hoffmann2026nashkell]. Um filtro `clean` do Git traduz identificadores do inglês para o latim no
commit, e um filtro `smudge` os traduz de volta no checkout, por meio de um dicionário fixo; quem
clona sem o filtro vê, e o GitHub mostra, a forma em latim.

A própria documentação do projeto lista os limites, e eles são gerais
[@hoffmann2026nashkell]:

- **A estrutura sobrevive.** Somente os nomes de nível superior mudam. Fluxo de controle, tipos e
  variáveis locais permanecem intactos e dedutíveis, de modo que o resultado "raises, not eliminates, reading difficulty" (em tradução livre: aumenta, mas não elimina, a dificuldade de
  leitura) e "not a
  security boundary" (em tradução livre: não é uma fronteira de segurança).
- **A chave é o dicionário.** O mapeamento é uma bijeção armazenada ao lado da ferramenta. Quem o
  possui, ou consegue adivinhar o suficiente dele, desfaz a transformação.
- **A forma armazenada não compila.** Os caminhos de arquivo não são renomeados, de modo que os
  módulos em latim deixam de corresponder a seus caminhos. A ofuscação também tem um custo para o
  dono.
- **É uma heurística.** O filtro opera linha a linha, não é um parser; não trata comentários de
  bloco nem strings de múltiplas linhas, e nomes novos precisam ser acrescentados ao dicionário à
  mão.

A teoria diz que esses limites não são uma questão de esforço. Barak e colegas provaram que não pode
existir um ofuscador geral de "virtual black box" (caixa-preta virtual). Tal ofuscador não permitiria
a ninguém computar, a partir do programa ofuscado, nada que não pudesse ser computado apenas com
acesso de entrada e saída. Os autores construíram uma família de programas que podem ser obtidos
por engenharia reversa a partir de qualquer programa equivalente, embora o acesso de caixa-preta
não revele nada de seu código [@barak2012impossibility]. O resultado deixa espaço para noções mais
fracas de ofuscação, mas não para um método geral que torne o código-fonte secreto. **[ANÁLISE]** E,
diante dos modelos de linguagem da Seção [-@sec:espionage], que já recuperam código-fonte a partir
de binários, renomear identificadores para o latim é apenas um quebra-molas.

## O que proteger em vez disso: integridade, identidade e chaves

**[ANÁLISE]** A lição de Nash e da ofuscação é parar de proteger a *legibilidade* do código e
proteger aquilo que a criptografia é capaz de proteger: que o código é o que seus autores
escreveram, e que somente eles poderiam tê-lo escrito. Em 2026, isso significa quatro camadas, cada
uma com ferramentas públicas e maduras.

1. **Assine commits e tags.** O Git assina tags e commits com GnuPG, e `git merge
   --verify-signatures` recusa um histórico sem assinaturas confiáveis [@chacon2014signing]. Desde o
   Git 2.34, chaves SSH podem assinar, assim como chaves GnuPG [@git2021relnotes234].
2. **Mantenha as chaves de assinatura em hardware.** Desde o OpenSSH 8.2, chaves de segurança FIDO
   dão suporte aos tipos de chave `ecdsa-sk` e `ed25519-sk`; a chave privada nunca sai do token, e o
   token precisa estar presente quando a chave é usada [@openssh2020release82]. Um laptop roubado
   deixa de significar uma chave de assinatura roubada.
3. **Exija autenticação de dois fatores na forja.** Em 2022, o GitHub se comprometeu a exigir que
   todo usuário que contribui com código no GitHub.com ativasse a autenticação de dois fatores até o
   fim de 2023 [@hanley2022twofactor]. Uma pessoa que se apodera de uma conta pode enviar código em
   nome de seu dono.
4. **Torne as assinaturas verificáveis por todos.** O Sigstore permite que desenvolvedores assinem
   com chaves efêmeras vinculadas a uma identidade existente por meio do OpenID Connect, e registra
   as assinaturas em logs de transparência, o que elimina a maior parte do ônus e do risco da gestão
   de chaves [@newman2022sigstore].

As funções de hash também importam. Em 2017, Stevens e colegas produziram a primeira colisão para o
SHA-1 completo [@stevens2017first], o hash sobre o qual os nomes de objetos do Git foram
construídos. O Git oferece um formato de objetos SHA-256 desde a versão 2.29, inicialmente marcado
como experimental [@git2020relnotes229].

O que permanece secreto sob esse modelo é pouco e explícito: chaves privadas, credenciais e dados
pessoais ou sujeitos a acordo, como na Seção [-@sec:chemorx]. Esses merecem criptografia e controle
de acesso. O próprio código-fonte é mais bem servido sendo publicado, assinado e citado.

**[ANÁLISE]** No vocabulário do próprio Nash, trata-se de uma mudança de estratégia em um jogo cujos
payoffs se deslocaram. Quando a engenharia reversa era cara, o sigilo podia ser uma estratégia
sensata para um autor. Quando a engenharia reversa é barata, o payoff do sigilo cai para perto de
zero, enquanto o payoff da publicação creditada e verificável não cai. Não afirmo ter calculado um
equilíbrio [@nash1950equilibrium]; afirmo apenas que os custos sobre os quais a velha estratégia se
apoiava desapareceram.
