<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Uma confissão de código fechado: Chemo-RX {#sec:chemorx}

Esta seção é escrita em primeira pessoa por Matheus Hoffmann. As passagens marcadas com
**[RELATO DO AUTOR]** reservam lugar para as lembranças do próprio autor. Elas devem ser escritas pelo
autor antes que este artigo deixe a versão v0; nada nelas pode ser inventado por um agente.

Em 2018, comecei um trabalho de conclusão de curso de graduação na Escola Politécnica da Universidade
Federal do Rio de Janeiro, em associação com o laboratório LESS do Programa de Engenharia Biomédica. Seu
codinome era Chemo-RX. O objetivo era comparar métodos estatísticos para prever reações adversas à
quimioterapia em mulheres tratadas de câncer de mama, usando dados do Instituto Nacional de Câncer
(INCA). As reações consideradas eram astenia, mialgia, artralgia, mucosite, dor abdominal e diarreia, e
os preditores incluíam comorbidades, variáveis demográficas e polimorfismos de nucleotídeo único
[@hoffmann2018chemorx].

O vestígio público desse trabalho é um repositório no GitHub com oito commits entre 23 de março e
25 de abril de 2018 [@hoffmann2018chemorx]. Ele contém um README, uma proposta em formato OpenDocument
e um resumo de dados em R Markdown. O README tem três títulos que nunca foram preenchidos: "Proposal EN
link", "Final project EN link" e "Thesis full content" (em tradução livre: link da proposta em inglês,
link do projeto final em inglês e conteúdo completo da tese). Sob o último, diz apenas "contact
me" (em tradução livre: entre em contato). A lista de pendências da proposta ainda inclui
"Add INCA formal license/ethic regiment" (em tradução livre: adicionar a licença formal/regimento de ética do
INCA).

**[RELATO DO AUTOR: como o projeto começou, quem o orientou e o que a questão clínica significava
para as pessoas envolvidas.]**

**[RELATO DO AUTOR: por que o texto e o código da tese ficaram fechados. Foi uma instrução do
orientador, incerteza sobre o acordo de dados, trabalho inacabado ou simplesmente nunca ter chegado a
fazê-lo?]**

**[RELATO DO AUTOR: o que se perdeu. Por exemplo, resultados que não puderam ser reutilizados,
colaboradores que não puderam dar continuidade ao trabalho, ou a experiência de não conseguir mostrar
o trabalho depois.]**

**[ANÁLISE]** Dois tipos de fechamento se misturam naquele repositório, e a distinção importa para o
restante deste artigo. Os dados das pacientes não podiam ser publicados, e não deveriam ter sido:
prontuários clínicos são dados pessoais, e sua divulgação é regida por aprovação ética e por acordos de
dados, o que a própria lista de pendências reconhece. O *método* poderia ter sido publicado: o código
estatístico, o protocolo de comparação, as definições das variáveis e os resultados negativos. Os
princípios FAIR fazem exatamente essa distinção. Dados e software devem ser localizáveis e acessíveis
*sob condições bem definidas*, que podem incluir acesso restrito, e seus metadados devem permanecer
públicos mesmo quando os dados não o são [@wilkinson2016fair; @barker2022fair4rs]. Fechar o método
junto com os dados não protegeu nenhuma paciente. Apenas tornou o trabalho impossível de citar.

**[RELATO DO AUTOR: o que o autor passou a fazer de diferente desde então, levando aos projetos de
código aberto da Seção [-@sec:related].]**
