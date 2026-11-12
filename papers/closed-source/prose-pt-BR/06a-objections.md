<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Objeções e respostas {#sec:objections}

Um artigo de posição deve ao leitor a defesa mais forte contra ele. Enuncio seis objeções como os
seus defensores as fariam, e respondo a cada uma. As respostas são interpretação, marcadas como tal;
os fatos em que se apoiam estão citados em seções anteriores.

## Objeção 1: o segredo ainda funciona para a maioria das empresas na maior parte do tempo

*A maior parte do software nunca passa por engenharia reversa, porque ninguém se importa o bastante.
Os casos deste artigo são as exceções: as empresas mais valiosas e os modelos mais valiosos.*

**[ANÁLISE]** A objeção é verdadeira quanto à atenção e falsa quanto ao custo. O segredo resistiu para
a maior parte do software porque a engenharia reversa era cara, e só alvos valiosos compensavam o
custo. A evidência da Seção [-@sec:espionage] é que o custo caiu para todos ao mesmo tempo. Uma
ferramenta aberta que opera Ghidra, IDA e um navegador a partir de um prompt [@morluto2026rea] não se
importa se o alvo é famoso. Quando o custo de ler cai para o preço de um prompt, o conjunto de alvos
que "worth it" (valem a pena) cresce até incluir quase tudo. A exceção vira a regra.

## Objeção 2: pesos abertos e métodos abertos são perigosos

*Um modelo cujos pesos são públicos pode ser ajustado para remover as suas salvaguardas. Um método
publicado pode ser usado por um atacante. Para alguns artefatos, o segredo é uma medida de
segurança, não um modelo de negócio.*

**[ANÁLISE]** Esta é a objeção mais forte, e não a descarto. O meu argumento na Seção [-@sec:limits]
já exclui detalhes sensíveis de segurança, dados pessoais e material sob embargo. Duas respostas
estreitam o resto. Primeiro, a objeção supõe que o segredo resiste, e a evidência é que, para modelos
servidos em escala, ele não resiste: a destilação pela API é alegada em escala industrial pelos
provedores e por três agências dos EUA [@anthropic2026distillation; @csa2026distillation]. Uma medida
de segurança que vaza para os adversários mais determinados enquanto amarra pesquisadores honestos
protege o lado errado. Segundo, o ataque descrito no relatório de espionagem de 2025 usou um agente
fechado e hospedado, não um aberto [@anthropic2025espionage]. O fechamento não impediu o mau uso; a
detecção e a publicação do mau uso fizeram o trabalho. A defesa de reter uma capacidade perigosa
específica pode ser boa. É uma defesa sobre essa capacidade, feita às claras, não uma defesa geral
do código fechado.

## Objeção 3: sem segredo, não há incentivo para investir

*Se um rival consegue reconstruir um produto em semanas, ninguém vai passar anos construindo-o.
Segredos comerciais existem porque financiam a inovação.*

**[ANÁLISE]** A objeção confunde a proteção do investimento com a proteção da legibilidade. Patentes,
direitos autorais, contratos e a vantagem de tempo de quem chega primeiro protegem o investimento sem
exigir que o produto fique sem ser lido; a defesa de Samuelson e Scotchmer da engenharia reversa
lícita se apoia justamente na vantagem de tempo que ela deixa [@samuelson2002law]. Os laboratórios
com os maiores investimentos liberaram pesos e métodos em 2025 porque viram retorno em serem usados e
citados [@openai2025gptoss; @guo2025deepseekr1]. E o código aberto de que as empresas já dependem,
avaliado em cerca de 8,8 trilhões de dólares americanos para ser substituído [@hoffmann2024value], foi
construído sem o incentivo que a objeção diz ser necessário. Para a ciência, a objeção nem se coloca:
o retorno de um pesquisador é a citação, e a citação exige ser lido.

## Objeção 4: a citação é uma cortesia vazia que as máquinas vão ignorar

*Os agentes já copiam sem dar crédito. Pedir que citem é pedir desculpas a uma enchente.*

**[ANÁLISE]** Os agentes fazem o que os seus operadores e a sua configuração exigem. Um agente que
trabalha sob um `AGENTS.md` com uma regra contra referências inventadas, num build que falha diante de
uma entrada não verificada, cita porque não consegue terminar de outro jeito. Isso não é uma
esperança; é como este artigo foi feito (Seção [-@sec:fabric]). A evidência de referências
fabricadas em artigos revisados por pares [@gptzero2026neurips; @ansari2026compound] é um argumento
para tornar a verificação mecânica, não para desistir dela. E a lei de ao menos um país já liga um
uso permitido de software à identificação da sua fonte [@brasil1998software].

## Objeção 5: reconstruções em sala limpa prejudicam quem construiu o original

*Uma equipe passou décadas num aplicativo profissional. Um agente reconstrói o seu comportamento em
semanas e o distribui de graça. Diga a lei o que disser, isso é injusto com os autores originais.*

**[ANÁLISE]** A objeção merece uma resposta direta, porque os projetos Craft da Seção
[-@sec:espionage] a tornam concreta. Primeiro, as reconstruções estão, pelo seu próprio relato,
longe da paridade: o PhotoCraft afirma que "it is not yet a Photoshop replacement for daily
professional work" (ainda não substitui o Photoshop no trabalho profissional diário)
[@storytold2026photocraft]. As décadas de trabalho aparecem nessa distância. Segundo, a lei sempre
deixou um concorrente estudar um produto e construir um rival que se comporte do mesmo modo; o que
ela proíbe é copiar expressão protegida e tomar segredos por meios impróprios (Seção [-@sec:law]).
Terceiro, e este é o ponto do artigo, a resposta justa é o crédito, não o segredo. Uma reconstrução
que nomeia o que estudou, com versão e identificador, dá aos autores originais um registro público
da sua influência, coisa que o segredo nunca lhes deu. Uma reconstrução que esconde as suas fontes é
o problema, e o remédio são as regras de citação da Seção [-@sec:citing], aplicadas aos agentes e às
pessoas que os dirigem.

## Objeção 6: o autor tem interesse na abertura

*O autor constrói ferramentas abertas e cita os próprios projetos. É claro que ele argumenta que a
abertura vence.*

**[ANÁLISE]** O interesse é real e declarado (Seção [-@sec:limits] e as Declarações). A resposta é o
próprio método do artigo: cada afirmação factual traz uma fonte buscada, o log de referências
registra cada verificação, e o código-fonte do artigo, o seu build e a configuração dos seus agentes
são públicos. Um leitor que duvida do meu motivo pode verificar as minhas evidências sem confiar em
mim. Essa é a diferença entre um argumento aberto e um fechado, e é toda a minha defesa.
