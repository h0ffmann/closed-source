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

Este repositório segue essa receita; a Seção [-@sec:fabric] dá os detalhes. O mesmo vale para os
trabalhos relacionados da Seção [-@sec:related], cada um dos quais tem um DOI de conceito.

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
