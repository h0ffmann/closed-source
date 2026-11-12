<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Ciência e espionagem em 2026: a explosão da engenharia reversa {#sec:espionage}

Uso *engenharia reversa* para qualquer processo que recupera como um artefato funciona a partir do
próprio artefato, sem acesso aos seus documentos de projeto: descompilar um binário, inferir um
modelo a partir das suas saídas ou reconstruir um produto a partir das suas peças. Em versões
anteriores deste artigo, eu escrevia REA, na abreviação do meu projeto, para *reverse engineering,
assisted*. Em 2026, as mesmas três letras viraram o nome de uma ferramenta aberta, *Reverse Engineer
Anything*, cujo caso é contado abaixo. Esta seção examina oito desenvolvimentos. Vários deles são
processos ou acusações, e os seus fatos são alegações; eu os relato como tais.

## Apple v. OpenAI: segredos saem andando com duas pernas

Em 10 de julho de 2026, a Apple processou a OpenAI, a empresa de dispositivos io que a OpenAI havia
adquirido e dois ex-funcionários da Apple no Tribunal Distrital dos Estados Unidos para o Distrito
Norte da Califórnia, Divisão de San Jose, como *Apple Inc. v. Chang Liu et al.*, Case No.
5:26-cv-07078 [@apple2026complaint]. As seis acusações são de apropriação indevida de segredo
comercial sob o Defend Trade Secrets Act de 2016, contra cada um dos quatro réus, e de quebra de
contrato contra as duas pessoas físicas [@apple2026complaint]. Segundo a petição, tal como relatada,
um ex-engenheiro da Apple acessou sistemas da Apple por meio de uma falha de autenticação a partir
do computador corporativo de um colega; o diretor de hardware da OpenAI, um ex-executivo da Apple,
pediu a candidatos que levassem peças, arquivos de projeto e protótipos da Apple às entrevistas; e
novos contratados receberam orientação para contornar o processo de desligamento da Apple
[@perez2026allegations]. A própria petição contabiliza "over four hundred former Apple employees now
working at OpenAI" (em tradução livre: mais de quatrocentos ex-funcionários da Apple trabalhando
agora na OpenAI) [@apple2026complaint]. A OpenAI disse publicamente que não tem "no interest in
other companies' trade secrets" (nenhum interesse nos segredos comerciais de outras empresas)
[@perez2026allegations]. Em agosto, pediu o arquivamento, argumentando que a Apple deixava
funcionários usarem contas pessoais na nuvem para trabalho, não revogou acessos corretamente e não
identificou quais segredos foram levados [@perez2026motion].

O caso andou depressa no segundo semestre. Em 13 de outubro de 2026, o juiz Edward Davila concedeu à
Apple acesso acelerado aos registros de entrevistas da OpenAI com ex-funcionários da Apple e aprovou
depoimentos de três pessoas citadas no caso [@perez2026hiring]. Antes de uma audiência sobre o pedido
de liminar da Apple, a OpenAI disse que "has no need or desire for Apple's trade secrets" (não tem
necessidade nem desejo dos segredos comerciais da Apple) [@mekelburg2026court]. Nessa audiência,
segundo o relato, a OpenAI concordou em não usar as informações que a Apple diz terem sido levadas e
em coletar imagens forenses dos dispositivos de 14 funcionários, e o juiz disse que era "highly
likely" (altamente provável) que concedesse a liminar [@mendes2026agrees]. Em 28 de outubro, o
tribunal marcou o julgamento para 19 de julho de 2027 [@mendes2026trial]. Na data em que escrevo, 12
de novembro de 2026, não encontrei relato de que o tribunal tenha decidido o pedido de arquivamento
ou o mérito.

**[ANÁLISE]** Seja qual for o desfecho, a disputa é instrutiva pelo que ela *não* é. Não é sobre
código-fonte que um adversário deixou de ler porque era secreto. Todo caminho alegado passa por
pessoas: suas contas, seus dispositivos, suas conversas de recrutamento e suas memórias. O segredo,
nesse relato, era uma propriedade dos processos de uma organização, e processos vazam. Note também
que a defesa da OpenAI, tal como relatada, é em parte a de que as próprias práticas da Apple não
tratavam a informação como secreta. Um segredo que precisa ser guardado ativamente em cada
entrevista de desligamento é caro; o custo da guarda é parte do preço do código fechado.

*Nota de verificação.* Versões anteriores deste artigo não conseguiam confirmar o número do processo.
Ele agora é lido no próprio cabeçalho da petição [@apple2026complaint], e os relatos de outubro de
2026 nomeiam o juiz [@mekelburg2026court]. O andamento no PACER ainda não foi lido diretamente.

## Estados Unidos v. Ding: o segredo numa conta pessoal na nuvem

Um processo criminal sobre segredos de IA foi decidido mais cedo no ano. Em 29 de janeiro de 2026,
um júri federal em San Francisco condenou Linwei Ding, ex-engenheiro de software do Google, por sete
acusações de espionagem econômica e sete de furto de segredos comerciais [@doj2026ding]. Segundo o
Departamento de Justiça, ele "stole more than two thousand pages of confidential information
containing Google's AI trade secrets" (em tradução livre: furtou mais de duas mil páginas de
informação confidencial contendo segredos comerciais de IA do Google), sobre a infraestrutura de
supercomputação para IA da empresa, seus chips próprios e o software que os coordena. O método foi
simples: entre maio de 2022 e abril de 2023, aproximadamente, ele "uploaded them to his personal
Google Cloud account" (enviou-os para a sua conta pessoal no Google Cloud) [@doj2026ding]. Em 1 de
setembro de 2026, o juiz Vince Chhabria o condenou a pouco menos de um ano de prisão
[@debenedetti2026ding].

**[ANÁLISE]** Este é um caso provado, não uma alegação, e aponta na mesma direção do caso da Apple.
O segredo não caiu diante de um adversário engenhoso que leu o que estava escondido. Ele saiu pelo
botão de upload de alguém de dentro, ao longo de muitos meses, numa das empresas mais bem defendidas
do mundo.

## O vazamento do Claude Code: um segredo publicado por uma etapa de build

Em 31 de março de 2026, o código-fonte TypeScript completo do Claude Code, o agente de programação
comercial da Anthropic, tornou-se público. Um arquivo de source map de 59,8 MB, destinado à depuração
interna, havia sido incluído na versão 2.1.88 do seu pacote no registro público do npm; o código que
ele expôs tinha cerca de 512.000 linhas [@franzen2026claudecode]. A Anthropic disse: "This was a
release packaging issue caused by human error, not a security breach" (em tradução livre: foi um
problema de empacotamento da versão causado por erro humano, não uma violação de segurança)
[@franzen2026claudecode]. A empresa então enviou ao GitHub notificações de remoção que atingiram
cerca de 8.100 repositórios, inclusive forks legítimos do seu próprio repositório público do Claude
Code; disse que o alcance foi um acidente e retirou a maior parte das notificações, mantendo um
repositório e 96 forks que continham o código vazado [@fernholz2026takedown].

**[ANÁLISE]** Declaro de novo que a Anthropic faz o modelo que redigiu este artigo (ver as
Declarações). O ponto não é que uma empresa errou; toda empresa que distribui software vai errar. O
ponto é que a fronteira entre fechado e aberto era uma linha de configuração num build. Uma proteção
que uma linha desfaz, e à qual milhares de cópias sobrevivem em um dia, não é uma proteção sobre a
qual um pesquisador possa apoiar o valor do trabalho de uma vida.

## Destilação: copiando capacidade pela porta da frente

A destilação de conhecimento, treinar um modelo menor para imitar as saídas de um maior, é uma
técnica padrão e legítima [@hinton2015distilling]. Em 2026, ela também se tornou o centro de uma
acusação de cópia industrial. Em fevereiro, segundo a Reuters, a OpenAI disse ao Comitê Seleto da
Câmara dos EUA sobre a Competição Estratégica entre os Estados Unidos e o Partido Comunista Chinês
que contas associadas a funcionários da DeepSeek tinham desenvolvido métodos para contornar as
restrições de acesso da OpenAI e "obtain outputs for distillation in programmatic ways" (obter
saídas para destilação de forma programática) [@reuters2026deepseek]. A DeepSeek não respondeu à
Reuters. Dez dias depois, a Anthropic relatou "industrial-scale campaigns by three AI laboratories"
(campanhas em escala industrial de três laboratórios de IA), DeepSeek, Moonshot AI e MiniMax, usando
cerca de 24.000 contas fraudulentas e mais de 16 milhões de trocas com os seus modelos Claude
[@anthropic2026distillation].

Em setembro, a acusação ficou oficial. Em 8 de setembro de 2026, a NSA, a CISA e o FBI emitiram um
alerta conjunto, o AA26-251A, sobre campanhas de destilação de empresas de IA sediadas na China contra
empresas dos EUA [@csa2026distillation]. Segundo os relatos, ele nomeia DeepSeek, Moonshot AI,
Alibaba, MiniMax, StepFun e Z.AI, e descreve "aggressive, malicious, and targeted distillation
activities at an industrial scale" (atividades de destilação agressivas, maliciosas e direcionadas
em escala industrial) contra modelos da Anthropic, da OpenAI e do Google, com bilhões de tokens
extraídos em milhões de trocas desde pelo menos o fim de 2024 [@lakshmanan2026agencies]. As agências
avaliam, numa frase citada pela Cloud Security Alliance, que "this activity forms the critical core,
not merely a supplement" (essa atividade forma o núcleo crítico, não um mero complemento) da
estratégia de desenvolvimento das empresas citadas [@csa2026distillation]. Li o alerta por meio
desses dois relatos; não o busquei na CISA.

**[ANÁLISE]** São acusações, agora feitas por governos além de empresas interessadas, e eu não as
julgo. A relevância delas aqui é estrutural. Um modelo servido por trás de uma API é código fechado
no sentido mais forte: os pesos nunca saem dos servidores do provedor. Mas cada resposta que ele dá é
uma amostra do seu comportamento, e amostras suficientes ensinam a um modelo aluno muito do que o
professor sabe. A interface que vende o modelo é a interface que o vaza, e um alerta de governo não
consegue fechar essa interface sem fechar o negócio.

## Extração: lendo o modelo pelas suas respostas

O trabalho acadêmico mostrou o mesmo ponto com mais precisão e menos drama. Em 2016, Tramèr e colegas
mostraram que modelos de aprendizado de máquina servidos por APIs de predição podem ser roubados por
meio de consultas [@tramer2016stealing]. Em 2024, Carlini e colegas foram além, contra modelos de
linguagem em produção: o ataque deles recuperou a matriz inteira de projeção de embeddings dos
modelos Ada e Babbage da OpenAI, por menos de vinte dólares americanos em consultas, e confirmou pela
primeira vez as suas dimensões ocultas [@carlini2024stealing]. O artigo, publicado na ICML 2024,
termina com defesas e mitigações: a resposta de uma comunidade de pesquisa a um vazamento descoberto
é publicá-lo, para que possa ser corrigido.

## Descompilação: o fim do binário opaco

A engenharia reversa de software compilado é rotina há muito tempo e, para fins como a
interoperabilidade, lícita [@samuelson2002law]. Em 5 de março de 2019, na RSA Conference, a Agência
de Segurança Nacional dos EUA liberou o seu próprio framework de engenharia reversa, o Ghidra, como
código aberto [@uchill2019ghidra] sob a licença Apache-2.0 [@nsa2019ghidra]. Os modelos de linguagem
então baixaram a barreira que restava, a habilidade. O LLM4Decompile, uma família de modelos abertos
treinados para descompilação, produz código que recompila e passa nos testes originais; seus modelos
de ponta a ponta mais que dobram a taxa de reexecutabilidade do GPT-4o e do Ghidra nos benchmarks
HumanEval e ExeBench [@tan2024llm4decompile]. Seus autores depois construíram o Decompile-Bench, dois
milhões de pares de funções binário-fonte a partir de 450GB de binários, e relatam que o ajuste fino
nele melhora a reexecutabilidade em 20% [@tan2025decompilebench].

O trabalho mais recente acrescenta um alerta. Em setembro de 2026, Liu, Raff e Micinski testaram oito
descompiladores baseados em LLM em nove configurações e descobriram que uma saída que passa em todos
os testes distribuídos ainda pode se comportar de forma diferente do original: "4.9% overall" (no total), e cerca de 13% no pior sistema. Em 300 funções reais de bibliotecas e 287 funções ligadas
a vulnerabilidades conhecidas, o refinamento mais forte elevou a taxa de compilação do Ghidra de 75%
para 90%, enquanto a taxa de saídas equivalentes ao original caiu de 74% para 62%
[@liu2026recompile].

**[ANÁLISE]** O alerta corta numa direção interessante. Ele não diz que a descompilação falha; diz
que o código descompilado é bom o bastante para rodar e ainda não bom o bastante para merecer
confiança. Para o dono de um binário, isso não consola: o atacante precisa entender o programa, não
distribuí-lo. Para um cientista, é mais uma razão para publicar o código-fonte real, porque uma
reconstrução que roda mas difere em 5% dos casos é exatamente o tipo de erro silencioso que quebra a
reprodutibilidade.

## O caso REA: uma ferramenta aberta que faz engenharia reversa de qualquer coisa, e a suíte Craft

Os desenvolvimentos acima são artigos, processos e vazamentos. Em outubro de 2026, a explosão virou um
produto que qualquer pessoa pode instalar. O *REA: Reverse Engineer Anything* é um servidor de código
aberto, sob a licença MIT, que permite a um agente de programação operar ferramentas de engenharia
reversa sobre binários nativos, aplicativos JavaScript e Electron, assemblies .NET, pacotes Android e
sites, e devolver as suas conclusões com as evidências e os limites [@morluto2026rea]. Segundo os
relatos, ele começou em abril de 2026 e encapsula Ghidra, Hopper, IDA, JADX, Frida e Playwright
[@akita2026adobe; @jonas2026rebuilt]. Quando li o seu repositório em 12 de novembro de 2026, ele tinha
454.0k estrelas e 111.6k forks [@morluto2026rea]. O README limita o seu uso: "REA is for lawful
research, education, interoperability, software preservation" (o REA é para pesquisa lícita,
educação, interoperabilidade e preservação de software) e "You must legally obtain and be authorized
to use commercial tools" (você precisa obter legalmente as ferramentas comerciais e ter autorização
para usá-las) [@morluto2026rea].

Ao mesmo tempo, uma equipe de duas pessoas lançou uma família de aplicativos com o nome ArtCraft,
escritos em Rust com um agente de programação: o PhotoCraft, para edição de imagens, e outros para
arte vetorial, vídeo, bibliotecas de fotos, motion graphics, diagramação, planilhas e apresentações
[@jonas2026rebuilt; @akita2026adobe; @claburn2026blinding]. O README do PhotoCraft o chama de "an
open-source, clean-room reimplementation of Adobe Photoshop, rebuilt in pure Rust" (uma
reimplementação de código aberto, em sala limpa, do Adobe Photoshop, refeita em Rust puro) e afirma:
"Clean-room: implemented from public specs and observed behaviour only. No proprietary code,
shaders or assets" (sala limpa: implementado apenas a partir de especificações públicas e
comportamento observado; nenhum código, shader ou recurso proprietário) [@storytold2026photocraft].
Ele é honesto sobre o seu estado: "it is not yet a Photoshop replacement for daily professional
work" (ainda não substitui o Photoshop no trabalho profissional diário) [@storytold2026photocraft].
Segundo os relatos, o seu primeiro commit foi em 30 de setembro de 2026, e nos testes "134 of 135
real test files are saved back byte for byte" (quase todos os arquivos reais de teste são salvos de
volta byte a byte) [@jonas2026rebuilt]. A mesma equipe depois publicou o Craft Anything, uma
ferramenta em quatro etapas, estudar, construir, verificar e pronto, cujo modo padrão "clean room"
(sala limpa) lê apenas o que está visível, e cujo modo "Deep" (profundo) descompila e desmonta o
alvo [@storytold2026craftanything]. Ele orienta os usuários a trabalhar "on software you own or are
allowed to examine" (em software que você possui ou tem permissão para examinar) e diz que nunca
contorna DRM, logins ou anti-cheat [@storytold2026craftanything].

A primeira resposta defensiva veio em semanas. Em 10 de novembro de 2026, o *The Register* relatou
uma ferramenta chamada Blind LLM Agents, que renomeia identificadores, cifra strings, acrescenta
código-isca e verifica a integridade para que o código distribuído seja mais difícil de analisar por
um agente. Seu autor a testou contra o REA e disse: "We raise the cost — we don't claim it is
unbreakable" (em tradução livre: nós aumentamos o custo, não dizemos que é inquebrável)
[@claburn2026blinding].

**[ANÁLISE]** O caso REA é a tese deste artigo transformada em software. Nada nele é novo em
natureza: o Ghidra era aberto em 2019, e a engenharia reversa era lícita muito antes. O novo é que o
custo caiu para o preço de um prompt, e que a ferramenta e os seus produtos são eles próprios abertos,
licenciados e documentados. Três traços do caso importam para o que vem a seguir. Primeiro, a linha
da sala limpa, entre estudar o comportamento e copiar a expressão, é a mesma linha que a lei traça
(Seção [-@sec:law]); os projetos a escrevem nos seus próprios arquivos README. Segundo, a resposta
defensiva é de novo a ofuscação, com a mesma ressalva honesta que a Seção [-@sec:securing] encontra
no meu próprio exemplo. Terceiro, ninguém no caso consegue esconder nada; o que ainda podem escolher
é se dizem de onde veio o seu trabalho. Os projetos Craft nomeiam o que estudaram e mantêm um arquivo
de atribuição para o que tomaram emprestado. Esse é o comportamento que este artigo pede de todo
agente.

## Agentes como operadores

Mais um desenvolvimento mostra que a mesma capacidade serve tanto a atacantes quanto a construtores.
Em novembro de 2025, a Anthropic relatou o que chamou de "the first documented case of a large-scale
cyberattack executed without substantial human intervention" (o primeiro caso documentado de um
ciberataque em larga escala executado sem intervenção humana substancial): um grupo que ela avaliou
"with high confidence was a Chinese state-sponsored group" (com alta confiança, como um grupo
patrocinado pelo Estado chinês) usou o seu agente de programação contra "roughly thirty global
targets" (cerca de trinta alvos no mundo), e a IA executou "80-90% of the campaign" (a maior parte da
campanha) [@anthropic2025espionage].

**[ANÁLISE]** Um agente capaz de conduzir uma intrusão é capaz de ler um binário. A resposta do
defensor não pode ser torcer para que o código continue sem ser lido; precisa ser tornar a
integridade do código verificável e a sua autoria comprovável, e detectar o mau uso às claras.

## A explosão, em resumo

Table: A explosão do REA em catorze eventos datados, de 2016 a novembro de 2026. {#tbl:timeline}

| Data | Evento | Fonte |
|------------|----------------------------------------|--------------|
| 2016 | Modelos por trás de APIs de predição roubados por consultas | @tramer2016stealing |
| 5 mar. 2019 | A NSA libera o Ghidra como código aberto | @uchill2019ghidra |
| mar. 2024 | LLM4Decompile: de binários a código que recompila | @tan2024llm4decompile |
| jul. 2024 | Camada de embeddings de modelos em produção extraída por menos de 20 USD | @carlini2024stealing |
| ago. 2025 | A OpenAI libera modelos de pesos abertos sob Apache 2.0 | @openai2025gptoss |
| set. 2025 | Método do DeepSeek-R1 publicado na *Nature* | @guo2025deepseekr1 |
| nov. 2025 | Um agente executa a maior parte de uma campanha de espionagem | @anthropic2025espionage |
| 29 jan. 2026 | Júri condena ex-engenheiro do Google por furto de segredos de IA | @doj2026ding |
| 23 fev. 2026 | A Anthropic relata destilação por três laboratórios | @anthropic2026distillation |
| 31 mar. 2026 | Código do Claude Code publicado por um erro de empacotamento | @franzen2026claudecode |
| 10 jul. 2026 | A Apple processa a OpenAI e dois ex-funcionários | @apple2026complaint |
| 8 set. 2026 | Alerta de NSA, CISA e FBI sobre destilação em escala industrial | @csa2026distillation |
| out. 2026 | O REA e as reconstruções em sala limpa da Craft se espalham | @morluto2026rea |
| 10 nov. 2026 | Um ofuscador contra agentes: "We raise the cost" | @claburn2026blinding |

**[ANÁLISE]** Junte esses desenvolvimentos e a curva de custo da engenharia reversa desabou em todos
os eixos: para binários (descompilação e REA), para modelos (extração e destilação), para aplicativos
inteiros (reconstruções em sala limpa como o PhotoCraft) e para organizações (pessoas que trocam de
empregador, uploads e erros de empacotamento). Chamo isso de *explosão do REA*, em referência à
ferramenta que virou o seu emblema. Ela não torna todo artefato transparente da noite para o dia, e
não torna lícita a cópia onde a lei a proíbe. Mas torna o segredo uma defesa fraca e cara, e torna a
questão do crédito, quem fez o quê primeiro e quem construiu sobre quem, mais importante do que a
questão do acesso.
