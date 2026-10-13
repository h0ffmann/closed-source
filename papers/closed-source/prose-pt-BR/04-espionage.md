<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Ciência e espionagem em 2026: a explosão da engenharia reversa {#sec:espionage}

Uso *engenharia reversa* (REA, na abreviação do meu projeto, de *reverse engineering, assisted*)
para qualquer processo que recupere o funcionamento de um artefato a partir do próprio artefato,
sem acesso aos seus documentos de projeto: descompilar um binário, inferir um modelo a partir de
suas saídas ou reconstruir um produto a partir de suas peças. Esta seção revisa quatro
acontecimentos. O primeiro é um processo judicial, e seus fatos são alegações; eu os relato como
tais.

## Apple v. OpenAI: segredos saem andando sobre duas pernas

Em 10 de julho de 2026, a Apple processou a OpenAI, a empresa de dispositivos io, que a OpenAI
havia adquirido, e dois ex-funcionários da Apple no Tribunal Distrital dos Estados Unidos para o
Distrito Norte da Califórnia (San Jose). As alegações são de apropriação indevida de segredo
comercial, com base no Defend Trade Secrets Act de 2016, e, contra as duas pessoas físicas, de
quebra de contrato [@bridgecounsels2026apple; @perez2026allegations]. Segundo a petição inicial,
tal como noticiada, um ex-engenheiro da Apple acessou sistemas da Apple por meio de uma falha de
autenticação a partir do computador corporativo da Apple de um colega; o diretor de hardware da
OpenAI, ex-executivo da Apple, pediu a candidatos a vagas que levassem peças, arquivos de projeto
e protótipos da Apple às entrevistas; e novos contratados receberam orientações sobre como evitar
o processo de desligamento da Apple. A Apple alega ainda que mais de 400 ex-funcionários da Apple
trabalham hoje na OpenAI [@perez2026allegations]. A OpenAI declarou publicamente que não tem "no
interest in other companies' trade secrets" (em tradução livre: nenhum interesse nos segredos
comerciais de outras empresas) [@perez2026allegations]. Em agosto, pediu a extinção da ação,
argumentando que a Apple permitia que funcionários usassem contas pessoais de nuvem para o
trabalho, não revogou acessos de forma adequada e não havia identificado quais segredos teriam
sido levados [@perez2026motion]. No momento em que escrevo, o pedido de extinção e um pedido de
liminar estavam pendentes, e nenhum tribunal havia decidido o mérito
[@bridgecounsels2026apple; @perez2026motion].

**[ANÁLISE]** Qualquer que seja o desfecho, a disputa é instrutiva por aquilo que ela *não*
trata. Ela não trata de código-fonte que um adversário deixou de ler por ser secreto. Todo
caminho alegado passa por pessoas: suas contas, seus dispositivos, suas conversas de recrutamento
e suas memórias. O sigilo, neste relato, era uma propriedade dos processos de uma organização, e
processos vazam. Note-se também que a defesa da OpenAI, tal como noticiada, sustenta em parte que
as próprias práticas da Apple não tratavam a informação como secreta. Um segredo que precisa ser
ativamente guardado em cada entrevista de desligamento é caro; o custo dessa guarda faz parte do
preço do código fechado.

*Nota de verificação.* Não consegui consultar os autos diretamente. Fontes secundárias dão o
número do processo como 5:26-cv-07078, com sufixos de juiz conflitantes (VKD e EJD), e o
intitulam tanto *Apple Inc. v. OpenAI* quanto *Apple Inc. v. Liu* [@bridgecounsels2026apple]. O
número precisa ser conferido no PACER antes que este artigo deixe a v0.

## Destilação: copiando capacidade pela porta da frente

A destilação de conhecimento, isto é, treinar um modelo menor para imitar as saídas de um maior,
é uma técnica padrão e legítima [@hinton2015distilling]. Em 2026, ela também se tornou o centro
de uma acusação de cópia industrial. Em fevereiro, segundo a Reuters, a OpenAI informou ao House
Select Committee on Strategic Competition between the United States and the Chinese Communist
Party, da Câmara dos Representantes dos EUA, que contas associadas a funcionários da DeepSeek
haviam desenvolvido métodos para contornar as restrições de acesso da OpenAI e "obtain outputs for
distillation in programmatic ways" (em tradução livre: obter saídas para destilação de forma
programática) [@reuters2026deepseek]. A DeepSeek não respondeu à Reuters.
Dez dias depois, a Anthropic relatou "industrial-scale campaigns by three AI laboratories" (em
tradução livre: campanhas em escala industrial de três laboratórios de IA), DeepSeek, Moonshot AI
e MiniMax, que usaram cerca de 24.000 contas fraudulentas e mais de 16 milhões de interações com
seus modelos Claude [@anthropic2026distillation].

**[ANÁLISE]** Trata-se de acusações feitas por partes interessadas, e não me cabe julgá-las. Sua
relevância aqui é estrutural. Um modelo servido por trás de uma API é código fechado no sentido
mais forte: seus pesos nunca saem dos servidores do provedor. Ainda assim, cada resposta que ele
dá é uma amostra do seu comportamento, e amostras suficientes ensinam a um modelo aluno boa parte
do que o professor sabe. A interface que vende o modelo é a interface que o vaza.

## Extração: lendo o modelo através de suas respostas

O trabalho acadêmico demonstrou o mesmo ponto com mais precisão e menos dramaticidade. Em 2016,
Tramèr e colegas mostraram que modelos de aprendizado de máquina servidos por APIs de predição
podem ser roubados por meio de consultas [@tramer2016stealing]. Em 2024, Carlini e colegas foram
além, contra modelos de linguagem em produção: seu ataque recuperou a matriz inteira de projeção
de *embeddings* dos modelos Ada e Babbage da OpenAI, por menos de vinte dólares americanos em
consultas, e confirmou pela primeira vez suas dimensões ocultas [@carlini2024stealing]. O artigo,
publicado na ICML 2024, termina com defesas e mitigações: a resposta de uma comunidade de
pesquisa a um vazamento descoberto é publicá-lo, para que possa ser corrigido.

## Descompilação: o fim do binário opaco

A engenharia reversa de software compilado é há muito tempo rotineira e, para fins como a
interoperabilidade, lícita [@samuelson2002law]. Em 2019, a National Security Agency dos EUA
liberou seu próprio framework de engenharia reversa, o Ghidra, como código aberto sob a licença
Apache-2.0 [@nsa2019ghidra]. Os modelos de linguagem então reduziram a barreira que restava, que
era a habilidade. O LLM4Decompile, uma família de modelos abertos treinados para descompilação,
produz código-fonte que recompila e passa nos testes originais; seus modelos de ponta a ponta
mais que dobram a taxa de reexecutabilidade do GPT-4o e do Ghidra nos benchmarks HumanEval e
ExeBench [@tan2024llm4decompile].

**[ANÁLISE]** Juntando esses quatro acontecimentos, a curva de custo da engenharia reversa
desabou em todos os eixos: para binários (descompilação), para modelos (extração e destilação) e
para organizações (pessoas que mudam de empregador). Chamo isso de *explosão da REA*. Ela não
torna todo artefato transparente da noite para o dia, nem torna lícita a cópia onde a lei a
proíbe. Ela torna, sim, o sigilo uma defesa fraca e cara, e torna a questão do crédito, quem fez
o quê primeiro e quem construiu sobre o trabalho de quem, mais importante do que a questão do
acesso.
