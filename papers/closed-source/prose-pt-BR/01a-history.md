<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Uma breve história da fé {#sec:history}

O código fechado nem sempre foi o padrão, e nunca foi a única visão. Três documentos, de 1976, 1983
e 1998, marcam como a fé foi fundada, contestada e abandonada pela primeira vez por uma empresa que
vivia dela. Cito cada um longamente porque os argumentos de 2026 já estão neles.

## 1976: a carta que fundou o negócio

Em 3 de fevereiro de 1976, um jovem Bill Gates escreveu aos entusiastas que copiavam o interpretador
BASIC que ele tinha escrito com Paul Allen para o computador Altair. A carta saiu no boletim do
Homebrew Computer Club. A acusação central é direta: "As the majority of hobbyists must be aware,
most of you steal your software" (em tradução livre: como a maioria dos entusiastas deve saber, a
maioria de vocês rouba o seu software) [@gates1976letter]. O argumento central é sobre custo: "The
value of the computer time we have used exceeds $40,000" (o valor do tempo de computador que usamos
passa de quarenta mil dólares), e "Who can afford to do professional work for nothing?" (quem pode se dar
ao luxo de fazer trabalho profissional por nada?) [@gates1976letter].

**[ANÁLISE]** A carta é justa nos seus próprios termos. Em 1976, software era caro de escrever,
barato de copiar e difícil de entender a partir do binário. O segredo do código-fonte e as licenças
sobre o binário eram o caminho óbvio para recuperar o custo. Todas as premissas desse argumento
mudaram desde então. Escrever código ficou mais barato, já que agentes escrevem boa parte dele;
copiar sempre foi barato; e a terceira premissa, a de que um binário é difícil de entender, é a que
a Seção [-@sec:espionage] mostra ter desabado. A pergunta da carta, quem paga pelo trabalho
profissional, continua boa. A resposta dela, o segredo, depende de um custo que não existe mais.

## 1983: o anúncio que a contestou

Em 27 de setembro de 1983, Richard Stallman anunciou na Usenet que escreveria um sistema completo
compatível com o Unix e o daria de graça: o GNU. Sua razão era ética, não econômica: "I consider
that the golden rule requires that if I like a program I must share it with other people who like
it" (em tradução livre: considero que a regra de ouro exige que, se gosto de um programa, devo
compartilhá-lo com outras pessoas que gostam dele) [@stallman1983gnu]. A GNU General Public License
que saiu do projeto é a licença sob a qual o Linux foi lançado a partir de 1992 (Seção
[-@sec:bazaar]).

**[ANÁLISE]** O argumento de Stallman e o deste artigo são parentes, mas não iguais. O dele é sobre a
liberdade dos usuários; o meu é sobre a testabilidade da ciência e o crédito dos autores. Eles se
encontram na mesma prática: publicar o código-fonte. E se encontram diante do mesmo inimigo, que não é
o comércio, mas um método que mais ninguém consegue ler.

## 1998: uma empresa abandona a fé

Em 22 de janeiro de 1998, a Netscape, então uma das principais empresas de navegadores, anunciou que
disponibilizaria o código-fonte do seu próximo navegador "for free licensing on the Internet" (para
licenciamento gratuito na Internet). O comunicado dá a razão: "harness the creative power of
thousands of programmers on the Internet" (aproveitar o poder criativo de milhares de programadores
na Internet) [@netscape1998source]. O ensaio de Eric Raymond sobre o bazar foi publicado no mesmo ano
[@raymond1998cathedral].

**[ANÁLISE]** A Netscape é um caso antigo e claro de uma empresa que concluiu que o seu código valia
mais lido do que escondido. As liberações de pesos abertos de 2025 (Seção [-@sec:openweights])
repetem a decisão na escala dos modelos de IA. Nos dois casos a mudança veio sob pressão competitiva,
não por caridade, e nos dois casos a empresa manteve outras coisas fechadas. O padrão não é que as
empresas fiquem generosas. É que o valor de ser lido, a certa altura, supera o valor de ficar
escondido, e as empresas percebem.

## O que a história mostra

**[ANÁLISE]** Cinquenta anos separam a carta aberta da explosão da engenharia reversa de 2026
(Seção [-@sec:espionage]). Nesse tempo, a fé no código
fechado foi fundada sobre um custo real, contestada por razões éticas e abandonada aos poucos por
empresas que refizeram a conta. As evidências de 2024 a 2026 não iniciam a história. Elas removem a
última premissa em que a fé se apoiava: a de que o que é compilado ou servido continua sem ser lido.
