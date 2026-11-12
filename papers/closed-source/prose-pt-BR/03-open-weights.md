<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Os laboratórios fechados se abrem: pesos, métodos e definições {#sec:openweights}

Se o código fechado ainda fosse uma boa proteção, os laboratórios com mais a proteger seriam os
últimos a abrir mão dele. Entre 2024 e 2026, vários deles fizeram o contrário. Esta seção examina três
eventos: uma definição, um modelo revisado por pares e uma liberação de pesos abertos por um
laboratório conhecido por modelos fechados.

## Uma definição de IA de código aberto

Em 28 de outubro de 2024, a Open Source Initiative publicou a versão 1.0 da Open Source AI
Definition [@osi2024osaid]. Ela leva as quatro liberdades do software livre para os sistemas de IA:
"Use the system for any purpose and without having to ask for permission" (usar o sistema para
qualquer finalidade e sem pedir permissão), "Study how the system works and inspect its components"
(estudar como o sistema funciona e inspecionar seus componentes), "Modify the system for any
purpose, including to change its output" (modificar o sistema para qualquer finalidade, inclusive
para mudar a sua saída) e "Share the system for others to use with or without modifications, for
any purpose" (compartilhar o sistema para que outros o usem, com ou sem modificações, para qualquer
finalidade) [@osi2024osaid]. Em seguida, nomeia o que precisa ser liberado para que essas liberdades
sejam reais: os parâmetros, todo o código usado para treinar e executar o sistema, e informação
suficiente sobre os dados de treino para que uma pessoa capacitada consiga construir um sistema
substancialmente equivalente [@osi2024osaid].

**[ANÁLISE]** A definição importa aqui porque estabelece uma régua que a maioria dos modelos "open"
(abertos) não alcança. Pesos sem código de treino e sem informação sobre os dados são um binário:
útil, inspecionável em parte, mas não um método que outro laboratório possa testar. A distinção entre
pesos abertos e um método aberto é a mesma que este artigo faz entre um produto que pode ser usado e
um resultado que pode ser verificado.

## DeepSeek-R1: um modelo de fronteira no registro revisado por pares

Em setembro de 2025, a *Nature* publicou o artigo por trás do DeepSeek-R1, um modelo de raciocínio
treinado em grande parte com aprendizado por reforço [@guo2025deepseekr1]. O artigo relata que a
pontuação pass@1 no benchmark de matemática AIME 2024 subiu de 15,6% para 77,9% durante o treino do
modelo R1-Zero, e lista suas próprias limitações, entre elas a sensibilidade a prompts, a mistura de
idiomas e o reward hacking em tarefas difíceis de verificar [@guo2025deepseekr1]. Os autores afirmam
que "release DeepSeek-R1-Zero, DeepSeek-R1, data samples and distilled models to the public" (em
tradução livre: liberam ao público o DeepSeek-R1-Zero, o DeepSeek-R1, amostras de dados e modelos
destilados) [@guo2025deepseekr1].

**[ANÁLISE]** Duas coisas neste registro puxam em direções opostas, e ambas são evidência. A mesma
empresa é citada, na Seção [-@sec:espionage], em alegações de destilação a partir de modelos
fechados [@anthropic2026distillation; @csa2026distillation]. E a mesma empresa submeteu o seu método à
revisão por pares na revista mais visível da ciência e liberou os pesos. Seja qual for a verdade das
alegações, o segundo ato é o que um leitor pode verificar. A afirmação de um concorrente fechado
sobre um modelo não pode ser reproduzida por ninguém de fora; um método publicado com pesos liberados
pode.

## gpt-oss: o laboratório fechado libera pesos

Em 5 de agosto de 2025, a OpenAI liberou dois modelos de linguagem de pesos abertos, o gpt-oss-120b e
o gpt-oss-20b, sob a licença Apache 2.0 [@openai2025gptoss]. O maior tem 117 bilhões de parâmetros,
dos quais 5,1 bilhões ficam ativos para cada token; o menor tem 21 bilhões, com 3,6 bilhões ativos
[@openai2025gptoss]. O anúncio dá a razão nas palavras da própria empresa: "Open models complement our
hosted models, giving developers a wider range of tools to accelerate leading edge research" (em
tradução livre: modelos abertos complementam os nossos modelos hospedados, dando aos desenvolvedores
um leque maior de ferramentas para acelerar a pesquisa de ponta) [@openai2025gptoss].

**[ANÁLISE]** A liberação não faz da OpenAI um laboratório aberto, e a Open Source AI Definition
pediria mais do que pesos [@osi2024osaid]. Mas a direção é a evidência. Um laboratório que serve os
seus modelos de fronteira apenas por uma API, e que em 2026 foi processado por segredos (Seção
[-@sec:espionage]), concluiu que parte do seu valor era mais bem servida pela publicação do que pelo
segredo. Quando os donos dos artefatos fechados mais valiosos começam a abrir alguns deles, a tese de
que o segredo é o que os mantém valiosos deixa de ser a visão dos próprios donos.

## O que os três eventos têm em comum

**[ANÁLISE]** Nenhum dos três eventos é altruísmo, e não preciso que seja. Cada um é uma aposta de
que o valor vem de ser usado, estudado e citado, mais do que de ficar escondido. A definição diz o
que a abertura exige; o artigo na *Nature* mostra que um método de fronteira pode entrar no registro
científico; a liberação de pesos abertos mostra que até um laboratório conhecido por modelos
fechados vê retorno na publicação. O restante deste artigo pergunta o que isso significa para um
único pesquisador, cujo trabalho tem muito menos a esconder e muito mais a ganhar ao ser encontrado.