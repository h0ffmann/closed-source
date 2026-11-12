<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# A resposta ética: citação profissional {#sec:citing}

Se qualquer pessoa pode ler o seu trabalho, a proteção que resta é a norma de que quem o usa diz
que o usou. Essa norma é antiga na ciência; é jovem no software, e mal está formada para agentes.

## Citação para pessoas

Os *Software citation principles* da FORCE11 estabelecem o que significa citar software
adequadamente: software é um produto legítimo de pesquisa e deve ser citado como tal; as citações
devem dar crédito, ser únicas e persistentes, ser acessíveis e ser específicas à versão usada
[@smith2016software]. Os princípios FAIR pedem que os produtos de pesquisa sejam localizáveis,
acessíveis, interoperáveis e reutilizáveis [@wilkinson2016fair], e o FAIR4RS os adapta ao software
de pesquisa [@barker2022fair4rs].

Na prática, isso exige três coisas em todo repositório. A primeira é um identificador persistente:
um DOI emitido por um arquivo como o Zenodo, com um DOI de *conceito* que sempre aponta para a
versão mais recente e um DOI de *versão* para cada release. A segunda são metadados legíveis por
máquina, para que uma citação possa ser gerada em vez de digitada: `CITATION.cff` para o "Cite this repository" do GitHub, e `.zenodo.json` para o arquivo. A terceira é um processo de release em que
cada versão publicada recebe seu próprio identificador, para que o leitor possa citar exatamente o
que usou.

Um quarto elemento já é padrão. Um DOI nomeia uma versão que alguém escolheu arquivar; um Software
Hash Identifier nomeia qualquer artefato de código-fonte pelo seu conteúdo, e desde abril de 2025 é a
norma internacional ISO/IEC 18670 [@swh2026swhid]. Os dois fazem trabalhos diferentes. O DOI carrega
os metadados do crédito, autores, título e versão, e o SWHID prova que o código que o leitor tem em
mãos é o código que foi citado. Uma citação que traz os dois pode ser verificada por qualquer pessoa,
sem confiar no arquivo.

Este repositório segue essa receita; a Seção [-@sec:fabric] dá os detalhes. O mesmo vale para os
trabalhos relacionados da Seção [-@sec:related], cada um dos quais tem um DOI de conceito.

## O que a política pública já pede

A política pública andou na mesma direção. Em novembro de 2021, os 193 Estados-membros da UNESCO
adotaram uma Recomendação sobre Ciência Aberta que, segundo o Software Sustainability Institute,
reconhece "the role of software, source code and software infrastructure as key parts of Open
Science" (o papel do software, do código-fonte e da infraestrutura de software como partes centrais
da Ciência Aberta); foi a primeira recomendação da UNESCO do gênero a incluir software de código
aberto [@ssi2021unesco]. Em agosto de 2022, o Escritório de Política Científica e Tecnológica da Casa
Branca, num memorando assinado por Alondra Nelson, determinou que as agências federais dos EUA
tornassem as publicações das pesquisas que financiam livremente disponíveis "immediately on
publication, with no embargo" (imediatamente após a publicação, sem embargo), e estendeu o princípio
aos dados científicos por trás dessas publicações, com implementação prevista até o fim de 2025
[@casrai2022nelson].

**[ANÁLISE]** Nenhum dos dois textos é uma lei que obrigue um pesquisador a publicar código, e não
afirmo isso. Eles mostram onde o público que paga pela pesquisa colocou a sua expectativa. Um método
fechado financiado com dinheiro público é hoje uma exceção que precisa de justificativa, não um padrão
que dispensa justificativa.

## As evidências de que a citação está falhando

A necessidade não é hipotética. Em janeiro de 2026, a GPTZero relatou ter examinado 4.841 artigos
aceitos na NeurIPS 2025, uma das maiores conferências de aprendizado de máquina, e confirmado 100
citações alucinadas neles: referências com autores inventados, DOIs que não existem ou veículos que
não conferem [@gptzero2026neurips]. Uma taxonomia posterior das mesmas 100 citações as encontrou em 53
artigos publicados, "approx. 1% of all accepted papers" (cerca de um por cento de todos os artigos
aceitos), cada um deles revisado por três a cinco especialistas [@ansari2026compound].

**[ANÁLISE]** Uma referência fabricada é a imagem espelhada de um empréstimo sem crédito. Uma dá
crédito a um trabalho que não existe; a outra nega crédito a um trabalho que existe. Ambas passam
pela revisão por pares porque os revisores leem o argumento, não a procedência, e ambas crescem com
as ferramentas que escrevem texto. Se um dos veículos mais seletivos do aprendizado de máquina, o
campo que constrói essas ferramentas, deixa passar cerca de um artigo em cem com fontes inventadas,
a verificação não pode ficar a cargo dos revisores. Ela precisa fazer parte de como o texto é feito.

## Citação para agentes: tomar emprestado, citar, propagar

Agentes de programação e de pesquisa escrevem hoje uma grande parte do código e do texto novos,
inclusive a redação deste artigo (ver a declaração de uso de IA). Agentes leem muito mais do que
qualquer pessoa e copiam com fluência. Se não citam, a explosão de REA se torna uma máquina de
lavagem: código e ideias entram com autores e saem sem eles. Por isso, proponho três regras para
agentes, que o `AGENTS.md` do Paper Fabric torna obrigatórias para qualquer agente que trabalhe em
seus repositórios.

1. **Tome emprestado apenas o que a licença permite.** Antes de reutilizar código, texto, figuras
   ou dados, leia a licença e registre-a. Reutilização que a licença não permite não é empréstimo.
   Na dúvida, descreva a ideia e cite-a em vez de copiar sua expressão.
2. **Cite no ponto de uso, com um identificador persistente.** Todo elemento tomado emprestado
   recebe uma citação onde é usado, e não apenas em uma lista final. Prefira um DOI; na falta dele,
   use uma URL com o hash de um commit ou um snapshot de arquivo. Nunca invente uma referência: um
   agente que não consegue obter e verificar uma fonte deve marcar a afirmação como não verificada.
3. **Propague o crédito adiante.** Quando a produção de um agente é ela mesma publicada, as
   citações viajam com ela: na bibliografia, nas referências do `CITATION.cff` e nos identificadores
   relacionados do registro no Zenodo (`cites`, `isDerivedFrom`, `isSupplementTo`). O crédito que
   para no primeiro salto se perde no segundo.

**[ANÁLISE]** As regras não pedem nada exótico. São o que faz um pós-graduando cuidadoso. A
diferença está na escala e na verificabilidade: uma pessoa que esquece uma citação esquece uma; um
agente que esquece esquece milhares, e um agente que inventa referências envenena o registro. A
proibição de referências inventadas da Regra 2 é, portanto, aplicada mecanicamente no Paper Fabric,
por meio de um log de referências que registra como cada entrada foi verificada.

## As mesmas regras, vistas na prática

**[ANÁLISE]** As regras não são só minhas. Os projetos em sala limpa da Seção [-@sec:espionage]
escrevem uma versão delas nos seus próprios repositórios. O Craft Anything orienta o seu agente a não
copiar logotipos, fotos ou textos a menos que o usuário confirme a propriedade ou a permissão, e
mantém os recursos emprestados sob as suas próprias licenças num arquivo de atribuição
[@storytold2026craftanything]. O REA afirma que o material de terceiros "retains its own licenses and
copyright notices" (mantém as suas próprias licenças e avisos de direitos autorais)
[@morluto2026rea]. São as regras 1 e 3 com outras palavras. O que falta aos projetos, e à maior parte
do campo, é a regra 2 no nível das ideias: uma citação, no ponto de uso, dos produtos e
especificações que foram estudados. Uma reconstrução em sala limpa que nomeia o que estudou, com
versão e identificador, seria ao mesmo tempo lícita e honesta. Uma que não o faz é lícita e calada.

## Um registro mínimo de citação

Para um repositório que quer ser citado por pessoas e por agentes, proponho o registro mínimo abaixo;
o repositório deste artigo tem cada item.

1. Um arquivo `CITATION.cff` na raiz, com autores, título, versão e o DOI de conceito.
2. Um arquivo `.zenodo.json` com os mesmos metadados e `related_identifiers` para cada obra citada
   (`cites`) ou da qual deriva (`isDerivedFrom`).
3. Um processo de lançamento em que cada tag gera um DOI de versão, e um registro dos lançamentos.
4. Um log de referências que registra, para cada entrada da bibliografia, o que foi buscado, quando e
   se conferiu.
5. Um `AGENTS.md` que declara as três regras acima como invariantes para todo agente.

Como exemplo, a parte de um arquivo `.zenodo.json` que propaga o crédito de uma reconstrução em sala
limpa poderia ser assim. Os identificadores são de obras citadas neste artigo; as relações são o
vocabulário que o Zenodo e o DataCite já aceitam.

```json
"related_identifiers": [
  { "relation": "cites", "scheme": "url",
    "identifier": "https://github.com/morluto/rea" },
  { "relation": "isDerivedFrom", "scheme": "doi",
    "identifier": "10.5210/fm.v3i2.578" },
  { "relation": "cites", "scheme": "doi",
    "identifier": "10.1145/2812803" }
]
```

Um registro assim é lido por máquinas. Depois de depositado, o DataCite guarda os vínculos, e
qualquer índice que leia o DataCite pode mostrar, para cada obra citada, quem construiu sobre ela.

**[ANÁLISE]** Nenhum dos cinco itens exige uma ferramenta nova ou uma norma nova. Cada um leva minutos
para ser acrescentado e poupa horas a cada leitor seguinte, humano ou máquina, que quiser saber de
onde o trabalho veio.
