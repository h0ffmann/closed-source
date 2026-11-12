<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Introdução {#sec:intro}

Em 1949, seis escritores que haviam deixado o movimento comunista publicaram suas razões em um livro
chamado *The God That Failed* [@crossman1949god]. O título deste artigo toma a expressão emprestada
para uma fé menor e menos trágica: a crença de que manter em segredo o código-fonte, os modelos e os
métodos é o que os mantém valiosos. Chamo essa crença de *código fechado* em sentido amplo. Ela
abrange o software proprietário, o código de pesquisa não publicado, os pesos de modelos por trás de
uma API e os scripts por trás de uma tese que só o seu autor viu.

Essa fé tem dois artigos. O primeiro diz que o segredo protege o dono: o que ninguém consegue ler,
ninguém consegue copiar. O segundo diz que o segredo não custa nada a mais ninguém: o mundo perde pouco
quando um laboratório, uma empresa ou um estudante guarda o próprio trabalho para si. Eu argumento que
os dois artigos fracassaram, e que o fracasso se tornou evidente entre 2024 e 2026.

O primeiro artigo fracassou porque a engenharia reversa deixou de ser rara. A engenharia reversa
sempre foi lícita e comum [@samuelson2002law]. O que mudou foi o seu custo. Modelos de linguagem hoje
transformam binários compilados em código-fonte que compila e passa nos testes [@tan2024llm4decompile].
Alguns milhares de consultas a uma API recuperam partes de um modelo de linguagem em produção
[@carlini2024stealing]. Dezenas de milhares de contas conseguem destilar o comportamento de um modelo
de fronteira no de um concorrente [@anthropic2026distillation; @reuters2026deepseek], e em setembro
de 2026 três agências dos EUA descreveram essas campanhas como "industrial scale" (escala industrial)
[@lakshmanan2026agencies]. E quando uma das empresas mais valiosas do mundo processou um dos
laboratórios mais valiosos por segredos comerciais em julho de 2026, sua petição tratava de pessoas,
laptops e recrutamento, e não de código-fonte que tivesse permanecido em segredo e a salvo
[@apple2026complaint; @perez2026allegations].

O primeiro artigo também fracassou na direção oposta: segredos vazam sem engenharia reversa
nenhuma. Em janeiro de 2026, um júri condenou um ex-engenheiro do Google por levar mais de duas mil
páginas de segredos comerciais de IA, enviando-as para uma conta pessoal na nuvem [@doj2026ding]. Em
março de 2026, um erro de empacotamento publicou o código-fonte completo de um agente de programação
comercial num registro público [@franzen2026claudecode]. O código fechado não é só fácil de ler de
fora; é difícil de manter fechado por dentro.

O segundo artigo fracassou porque os custos do segredo recaem sobre a ciência. Um resultado que não
pode ser inspecionado não pode ser reproduzido [@ince2012case], e um código que não pode ser encontrado
não pode ser creditado [@smith2016software]. Quando pesquisadores tentaram compilar o código por trás
de 601 artigos de sistemas de computação, só 27% dos artigos tinham código disponível publicamente
[@collberg2016repeatability]. Toda uma economia funciona hoje sobre código que alguém escolheu abrir:
uma estimativa situa o custo de reconstruir o código aberto que as empresas usam em cerca de 8,8
trilhões de dólares americanos [@hoffmann2024value].

Robert M. Pirsig escreveu o livro em que este se apoia. Em *Zen and the Art of Motorcycle
Maintenance* (*Zen e a arte da manutenção de motocicletas*), ele resume o problema da ciência numa
frase: "The number of rational hypotheses that can explain any given phenomenon is infinite" (em
tradução livre: o número de hipóteses racionais que podem explicar qualquer fenômeno dado é
infinito) [@pirsig1974zen, p. 107].

**[ANÁLISE]** Se as hipóteses não têm fim, a ciência não tem fim, e nenhum laboratório sozinho
consegue testá-las todas. Um método que só o dono pode abrir é um método que mais ninguém pode
testar. Por isso sustento que a abertura vem primeiro para a ciência, antes de vir para os
negócios.

Se qualquer pessoa pode fazer engenharia reversa de qualquer coisa, a pergunta útil deixa de ser
*como escondo meu trabalho?* e passa a ser *como garanto que meu trabalho seja creditado quando for
usado?* Minha resposta é a citação profissional: identificadores persistentes, metadados legíveis por
máquina e, cada vez mais, agentes que citam por padrão. A necessidade é urgente. Em janeiro de 2026,
uma auditoria dos artigos aceitos numa das maiores conferências de aprendizado de máquina encontrou
100 citações fabricadas que haviam passado pela revisão por pares [@gptzero2026neurips]. Essa
resposta tem um lado prático, por isso descrevo também o pipeline aberto que produziu este artigo.

## Contribuições

Este artigo faz cinco contribuições.

1. Reúne, num só lugar e com fontes, as evidências de 2024 a 12 de novembro de 2026 de que o segredo
   não protege mais código, modelos nem métodos (Seções [-@sec:espionage] e [-@sec:dead]).
2. Mostra que a lei dos Estados Unidos, da União Europeia e do Brasil já trata a engenharia reversa
   de um produto obtido licitamente como meio lícito, de modo que o código fechado nunca teve uma
   garantia legal contra ser compreendido (Seção [-@sec:law]).
3. Separa o que a criptografia pode proteger, integridade e identidade, do que ela não pode,
   legibilidade, e lista as ferramentas que protegem as primeiras em 2026 (Seção [-@sec:securing]).
4. Enuncia três regras de citação para agentes e as evidências de que elas são necessárias (Seção
   [-@sec:citing]).
5. Descreve o Paper Fabric, um pipeline aberto que aplica essas regras mecanicamente, e lista seus
   defeitos (Seções [-@sec:fabric] e [-@sec:limits]).

## Organização

A Seção [-@sec:bazaar] revisita o Linux e o Git como evidência de que a abertura escala, e olha com
honestidade para duas falhas do código aberto. A Seção [-@sec:openweights] examina como os próprios
laboratórios fechados começaram a publicar pesos e métodos. A Seção [-@sec:espionage] examina a
ciência e a espionagem em 2026 e a explosão da engenharia reversa assistida por IA. A Seção
[-@sec:dead] reúne sete linhas de evidência de que o código fechado está morto como forma de
proteção. A Seção [-@sec:law] lê a lei. A Seção [-@sec:securing] trata da ofuscação, das cartas de
John Nash sobre criptografia e de como proteger código-fonte em 2026. A Seção [-@sec:citing] defende
a citação profissional e estabelece regras para agentes. A Seção [-@sec:objections] responde a seis
objeções. A Seção [-@sec:fabric] descreve o Paper Fabric. A Seção [-@sec:related] lista meus
trabalhos relacionados, e a Seção [-@sec:limits] expõe os limites do meu argumento.

Uma nota sobre o método. Este é um artigo de posição, escrito no estilo *research* do padrão de
documentação Ouroboric: toda afirmação factual traz uma citação, e as passagens de interpretação vêm
marcadas com **[ANÁLISE]**. Alegações são relatadas como alegações, com a fonte e a situação do
processo. Cada fonte foi buscada antes de ser citada; as fontes sobre eventos posteriores a junho de
2026 foram buscadas em 12 de novembro de 2026. É um preprint v0 e não passou por revisão por pares.
