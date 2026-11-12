<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Por que o código fechado está morto: sete linhas de evidência {#sec:dead}

"Dead" (morto) é uma palavra forte, e preciso dizer o que quero dizer com ela. Software de código
fechado continuará a ser vendido por muito tempo. O que está morto é o código fechado *como
proteção*: a ideia de que manter um artefato ilegível mantém o seu valor a salvo, e de que essa
proteção vale o que custa à ciência. Sete referências, da criptografia, do direito, do aprendizado
de máquina, da engenharia de software, da segurança, da prática de pesquisa e da economia, sustentam
essa tese. Escolhi-as pela credibilidade: cada uma é revisada por pares, uma fonte jurídica ou
oficial primária, ou um texto de trabalho amplamente citado de uma universidade de pesquisa.

Table: Sete referências sobre por que o segredo falha como proteção. {#tbl:seven}

| # | Referência | Área | O que mostra |
|--|----------------------|----------------|------------------------------------------------------------|
| 1 | @kerckhoffs1883cryptographie | criptografia | Um sistema deve continuar seguro quando o inimigo o tem; só a chave pode ser secreta. |
| 2 | @samuelson2002law | direito e economia | A engenharia reversa é uma prática antiga, lícita e economicamente útil. |
| 3 | @carlini2024stealing | aprendizado de máquina | Partes de um modelo em produção por trás de uma API podem ser extraídas por menos de 20 dólares. |
| 4 | @tan2024llm4decompile | engenharia de software | Modelos de linguagem descompilam binários em código que recompila e passa nos testes. |
| 5 | @doj2026ding | segurança | Segredos saem por pessoas de dentro: mais de duas mil páginas por uma conta na nuvem. |
| 6 | @collberg2016repeatability | prática de pesquisa | Só 27% de 601 artigos de sistemas de computação tinham código disponível publicamente. |
| 7 | @ince2012case | política científica | Resultados calculados por código não publicado não podem ser devidamente verificados nem reproduzidos. |

**1. A segurança pela obscuridade foi refutada em 1883.** O segundo princípio de Auguste Kerckhoffs
para cifras militares diz que o sistema "must not require secrecy and can be stolen by the enemy
without causing trouble" (não deve exigir segredo e pode ser roubado pelo inimigo sem causar
problema) [@kerckhoffs1883cryptographie]. A criptografia moderna é construída sobre esse princípio:
os algoritmos são públicos, e só as chaves são secretas. Um projeto cuja segurança depende de o
próprio projeto ficar escondido é considerado quebrado de antemão.

**2. O direito há muito aceita a engenharia reversa.** Samuelson e Scotchmer abrem o seu estudo com a
observação de que a engenharia reversa "has a long history as an accepted practice" (tem uma longa
história como prática aceita) [@samuelson2002law]. A lei de segredos comerciais protege contra meios
impróprios, como furto e quebra de confiança, não contra quem estuda um produto obtido licitamente.
O código fechado, portanto, nunca teve uma garantia legal contra ser compreendido. Tinha uma garantia
prática: a engenharia reversa era lenta e cara. A Seção [-@sec:law] lê as leis.

**3. Essa garantia prática acabou para os modelos.** Ataques de extração a APIs de predição
[@tramer2016stealing] amadureceram em ataques a modelos de linguagem em produção
[@carlini2024stealing], e a destilação em escala é hoje alegada pelos próprios provedores
[@anthropic2026distillation; @reuters2026deepseek] e por três agências dos EUA
[@csa2026distillation].

**4. Está acabando para binários e aplicativos inteiros.** Modelos abertos de descompilação,
construídos sobre um framework aberto de engenharia reversa liberado por uma agência de inteligência
de sinais [@nsa2019ghidra], recuperam código executável a partir de código compilado
[@tan2024llm4decompile]. Em 2026, uma ferramenta aberta pôs a cadeia inteira atrás de um agente
[@morluto2026rea], e uma reconstrução em sala limpa de um editor de imagens profissional apareceu no
mesmo outono [@storytold2026photocraft].

**5. Segredos vazam por dentro de qualquer jeito.** A condenação de um ex-engenheiro do Google por
enviar segredos comerciais de IA para uma conta pessoal na nuvem [@doj2026ding], o processo de
segredo comercial que gira em torno de recrutamento e dispositivos [@apple2026complaint], e a
publicação do código de um agente comercial por um erro de empacotamento [@franzen2026claudecode]
são três falhas diferentes com uma só lição. O segredo é uma propriedade de pessoas e processos, e
pessoas e processos vazam.

**6. O segredo custa caro à ciência, e o custo é medido.** Quando Collberg e Proebsting tentaram obter
e compilar o código por trás de 601 artigos de oito conferências e cinco revistas da ACM, só 27% dos
artigos tinham código disponível publicamente, e 32% puderam ser compilados pela equipe em até 30
minutos [@collberg2016repeatability]. Mesmo o código publicado se degrada quando o seu ambiente não é
registrado: num estudo do código de pesquisa depositado no Harvard Dataverse, 74% dos arquivos R não
terminaram sem erro na primeira execução, e 56% ainda falhavam após a limpeza automática do código
[@trisovic2022code].

**7. A política científica já diz isso há anos.** Ince e colegas argumentaram na *Nature* que, com
poucas exceções, "anything less than the release of source programs is intolerable for results that
depend on computation" (qualquer coisa menos que a liberação dos programas-fonte é intolerável para
resultados que dependem de computação) [@ince2012case]. O peso econômico da alternativa hoje é
mensurável: o código aberto que as empresas usam custaria cerca de 4,15 bilhões de dólares
americanos para ser escrito uma vez, e cerca de 8,8 trilhões se cada empresa tivesse de substituí-lo
por conta própria [@hoffmann2024value].

**[ANÁLISE]** As linhas 1 a 5 dizem que o segredo já não protege; as linhas 6 e 7 dizem que ele
nunca foi de graça. Juntas, deixam o pesquisador diante de uma escolha que já não é entre *escondido*
e *exposto*. É entre *exposto e sem crédito* e *exposto e com crédito*. O restante deste artigo trata
de escolher a segunda.

**[ANÁLISE]** A evidência tem uma fraqueza que preciso nomear. As linhas 3 a 5 se apoiam em parte em
eventos de 2026 cujos fatos ainda estão em disputa nos tribunais ou são relatados por partes
interessadas. Retire todos eles, e as linhas 1, 2, 6 e 7, cada uma uma fonte revisada por pares ou
primária com mais de dois anos, ainda sustentam o argumento. Os eventos de 2026 mudam a velocidade do
argumento, não a sua direção.
