<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Introdução {#sec:intro}

Em 1949, seis escritores que haviam deixado o movimento comunista publicaram suas razões em um livro
chamado *The God That Failed*. O título deste artigo toma a expressão emprestada para uma fé menor e
menos trágica: a crença de que manter em segredo o código-fonte, os modelos e os métodos é o que os
mantém valiosos. Chamo essa crença de *código fechado* em sentido amplo. Ela abrange o software
proprietário, o código de pesquisa não publicado, os pesos de modelos por trás de uma API e os scripts
por trás de uma tese que só o seu autor viu.

Essa fé tem dois artigos. O primeiro diz que o segredo protege o dono: o que ninguém consegue ler,
ninguém consegue copiar. O segundo diz que o segredo não custa nada a mais ninguém: o mundo perde pouco
quando um laboratório, uma empresa ou um estudante guarda o próprio trabalho para si. Eu argumento que
os dois artigos fracassaram, e que o fracasso se tornou evidente entre 2024 e 2026.

O primeiro artigo fracassou porque a engenharia reversa deixou de ser rara. A engenharia reversa
sempre foi lícita e comum [@samuelson2002law]. O que mudou foi o seu custo. Modelos de linguagem hoje
transformam binários compilados em código-fonte que compila e passa nos testes [@tan2024llm4decompile].
Alguns milhares de consultas a uma API recuperam partes de um modelo de linguagem em produção
[@carlini2024stealing]. Dezenas de milhares de contas conseguem destilar o comportamento de um modelo
de fronteira no de um concorrente [@anthropic2026distillation; @reuters2026deepseek]. E quando uma das
empresas mais valiosas do mundo processou um dos laboratórios mais valiosos por segredos comerciais em
julho de 2026, sua petição tratava de pessoas, laptops e recrutamento, e não de código-fonte que
tivesse permanecido em segredo e a salvo [@perez2026allegations; @bridgecounsels2026apple].

O segundo artigo fracassou porque os custos do segredo recaem sobre a ciência. Um resultado que não
pode ser inspecionado não pode ser reproduzido [@ince2012case], e um código que não pode ser encontrado
não pode ser creditado [@smith2016software]. Toda uma economia funciona hoje sobre código que alguém
escolheu abrir: uma estimativa situa o custo de reconstruir o código aberto que as empresas usam em
cerca de 8,8 trilhões de dólares americanos [@hoffmann2024value].

Se qualquer pessoa pode fazer engenharia reversa de qualquer coisa, a pergunta útil deixa de ser
*como escondo meu trabalho?* e passa a ser *como garanto que meu trabalho seja creditado quando for
usado?* Minha resposta é a citação profissional: identificadores persistentes, metadados legíveis por
máquina e, cada vez mais, agentes que citam por padrão. Essa resposta tem um lado prático, por isso
descrevo também o pipeline aberto que produziu este artigo.

O artigo está organizado da seguinte forma. A Seção [-@sec:bazaar] revisita o Linux e o Git como
evidência de que a abertura escala. A Seção [-@sec:chemorx] é uma confissão sobre o meu trabalho de
conclusão de curso fechado. A Seção [-@sec:espionage] examina a ciência e a espionagem em 2026 e a
explosão da engenharia reversa assistida por IA. A Seção [-@sec:dead] reúne cinco linhas de evidência
de que o código fechado está morto como forma de proteção. A Seção [-@sec:securing] trata da ofuscação,
das cartas de John Nash sobre criptografia e de como proteger código-fonte em 2026. A Seção
[-@sec:citing] defende a citação profissional e estabelece regras para agentes. A Seção [-@sec:fabric]
descreve o Paper Fabric. A Seção [-@sec:related] lista meus trabalhos relacionados, e a Seção
[-@sec:limits] expõe os limites do meu argumento.

Uma nota sobre o método. Este é um artigo de posição, escrito no estilo *research* do padrão de
documentação Ouroboric: toda afirmação factual traz uma citação, e as passagens de interpretação vêm
marcadas com **[ANÁLISE]**. É um preprint v0 e não passou por revisão por pares.
