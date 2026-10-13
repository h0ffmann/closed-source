<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Por que o código fechado está morto: cinco linhas de evidência {#sec:dead}

"Dead" (morto) é uma palavra forte, e devo dizer o que quero dizer com ela. Software de código
fechado continuará sendo vendido por muito tempo. O que está morto é o código fechado *como
proteção*: a ideia de que manter um artefato ilegível mantém seu valor seguro, e de que essa
proteção vale o que custa à ciência. Cinco referências, da criptografia, do direito, do
aprendizado de máquina, da engenharia de software e da economia, sustentam essa afirmação.
Escolhi-as pela credibilidade: cada uma é revisada por pares, uma fonte jurídica ou histórica
primária, ou um *working paper* amplamente citado de uma universidade de pesquisa.

Table: Cinco referências sobre por que o sigilo falha como proteção. {#tbl:five}

| # | Referência | Área | O que mostra |
|--|----------------------|----------------|------------------------------------------------------------|
| 1 | @kerckhoffs1883cryptographie | criptografia | Um sistema deve continuar seguro quando o inimigo o tem; só a chave pode ser secreta. |
| 2 | @samuelson2002law | direito e economia | A engenharia reversa é uma prática antiga, lícita e economicamente útil. |
| 3 | @carlini2024stealing | aprendizado de máquina | Partes de um modelo em produção por trás de uma API podem ser extraídas por menos de 20 dólares americanos. |
| 4 | @tan2024llm4decompile | engenharia de software | Modelos de linguagem descompilam binários em código-fonte que recompila e passa nos testes. |
| 5 | @ince2012case | política científica | Resultados calculados por código não publicado não podem ser devidamente verificados nem reproduzidos. |

**1. A segurança por obscuridade foi refutada em 1883.** O segundo princípio de Auguste
Kerckhoffs para cifras militares diz que o sistema "must not require secrecy and can be stolen by the enemy without
causing trouble" (em tradução livre: não deve exigir sigilo e pode ser roubado pelo inimigo sem
causar problemas) [@kerckhoffs1883cryptographie]. A criptografia moderna se
apoia nesse princípio: os algoritmos são públicos, e só as chaves são secretas. Um projeto cuja
segurança depende de o próprio projeto permanecer oculto é considerado quebrado de antemão.

**2. O direito aceita há muito tempo a engenharia reversa.** Samuelson e Scotchmer abrem seu
levantamento com a observação de que a engenharia reversa
"has a long history as an accepted practice" (em tradução livre: tem uma longa história como prática aceita) [@samuelson2002law]. O
direito de segredo comercial protege contra meios ilícitos, como furto e quebra de
confidencialidade, e não contra alguém que estuda um produto que obteve licitamente. O código
fechado, portanto, nunca teve uma garantia jurídica contra ser compreendido. Tinha uma garantia
prática: a engenharia reversa era lenta e cara.

**3. Essa garantia prática acabou para os modelos.** Os ataques de extração a APIs de predição
[@tramer2016stealing] amadureceram em ataques a modelos de linguagem em produção
[@carlini2024stealing], e a destilação em escala é agora alegada pelos próprios provedores
[@anthropic2026distillation; @reuters2026deepseek].

**4. Ela está acabando para os binários.** Modelos abertos de descompilação, construídos sobre um
framework aberto de engenharia reversa liberado por uma agência de inteligência de sinais
[@nsa2019ghidra], recuperam código-fonte executável a partir de código compilado
[@tan2024llm4decompile].

**5. Enquanto isso, o sigilo custa caro à ciência.** Ince e colegas argumentaram na *Nature* que,
com poucas exceções, "anything less than the release of source programs is intolerable for results
that depend on computation" (em tradução livre: qualquer coisa aquém da liberação dos programas-fonte
é intolerável para resultados que dependem de computação) [@ince2012case]. O peso econômico da
alternativa é hoje mensurável: o código aberto que as empresas usam custaria cerca de 4,15
bilhões de dólares americanos para ser escrito uma vez, e cerca de 8,8 trilhões de dólares
americanos se cada empresa tivesse de substituí-lo por conta própria [@hoffmann2024value].

**[ANÁLISE]** As linhas 1 a 4 dizem que o sigilo já não protege; a linha 5 diz que ele nunca saiu
de graça. Juntas, deixam o pesquisador diante de uma escolha que já não é entre *oculto* e
*exposto*. É entre *exposto e sem crédito* e *exposto e com crédito*. A próxima seção trata de
escolher a segunda.
