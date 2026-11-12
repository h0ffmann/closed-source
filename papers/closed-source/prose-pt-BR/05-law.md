<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# O que a lei já diz: engenharia reversa nos EUA, na UE e no Brasil {#sec:law}

Um leitor pode aceitar as evidências da Seção [-@sec:dead] e ainda responder que a lei vai restaurar
o que a tecnologia tirou. Esta seção lê três ordenamentos: o dos Estados Unidos, o da União Europeia
e o do Brasil, onde vivo e trabalho. Não sou advogado, e nada aqui é aconselhamento jurídico. Cito os
textos e digo o que eles claramente abrangem.

## Estados Unidos: engenharia reversa não é meio impróprio

O Defend Trade Secrets Act de 2016, com base no qual a Apple processou a OpenAI [@apple2026complaint],
alterou as definições do Economic Espionage Act federal. Ali, "improper means" (meios impróprios)
"includes theft, bribery, misrepresentation, breach or inducement of a breach of a duty to maintain
secrecy, or espionage through electronic or other means" (inclui furto, suborno, deturpação, quebra
ou indução à quebra de um dever de sigilo, ou espionagem por meios eletrônicos ou outros), e "does
not include reverse engineering, independent derivation, or any other lawful means of acquisition"
(não inclui engenharia reversa, derivação independente ou qualquer outro meio lícito de aquisição)
[@usc2016dtsa]. Samuelson e Scotchmer estudam o direito e a economia da mesma regra, e a consideram em
geral sensata quando a engenharia reversa é lenta e cara o bastante para deixar uma vantagem a quem
chegou primeiro [@samuelson2002law].

## União Europeia: observação, estudo, desmontagem ou teste

A Diretiva (UE) 2016/943 sobre segredos comerciais lista as formas lícitas de obtê-los. O artigo
3(1)(a) nomeia "independent discovery or creation" (descoberta ou criação independente), e o artigo
3(1)(b) nomeia "observation, study, disassembly or testing of a product or object that has been
made available to the public or that is lawfully in the possession of the acquirer of the
information who is free from any legally valid duty to limit the acquisition of the trade secret"
(observação, estudo, desmontagem ou teste de um produto ou objeto disponibilizado ao público ou que
esteja licitamente na posse de quem obtém a informação, livre de qualquer dever juridicamente válido
de limitar a obtenção do segredo comercial) [@eu2016tradesecrets]. Os Estados-membros tiveram de
incorporar a diretiva ao direito nacional.

## Brasil: o que não constitui ofensa ao titular de um programa

A lei brasileira de software, a Lei nº 9.609, de 19 de fevereiro de 1998, protege os programas de
computador como obras e depois lista, no seu artigo 6, atos que não constituem ofensa aos direitos
do titular [@brasil1998software]. Dois deles importam aqui. O inciso II permite "a citação parcial do
programa, para fins didáticos, desde que identificados o programa e o titular dos direitos
respectivos". O inciso III permite "a ocorrência de semelhança de programa a outro, preexistente,
quando se der por força das características funcionais de sua aplicação" [@brasil1998software].

## O que os três textos têm em comum

**[ANÁLISE]** Três sistemas jurídicos, escritos em décadas e línguas diferentes, traçam a mesma linha.
Estudar um produto que você possui licitamente é permitido; tomá-lo por furto, suborno ou quebra de
dever não é. Nenhum deles dá ao dono de um artefato fechado o direito de não ser compreendido. O texto
brasileiro vai um passo além e liga um uso permitido à citação: a citação parcial de um programa é
lícita quando o programa e o seu titular são identificados. Essa é a regra deste artigo, escrita numa
lei em 1998.

**[ANÁLISE]** A mesma linha atravessa os casos de 2026 da Seção [-@sec:espionage]. O processo da Apple
e a condenação de Ding tratam do lado impróprio da linha: dispositivos, uploads, recrutamento e
quebra de dever [@apple2026complaint; @doj2026ding]. Os projetos Craft se colocam do outro lado ao
chamar o seu trabalho de reimplementações em sala limpa a partir de "public specs and observed
behaviour only" (apenas especificações públicas e comportamento observado) [@storytold2026photocraft].
Se uma dada reconstrução fica desse lado é uma questão de fato para um tribunal, não para este
artigo. O que a lei não consegue é transformar o lado lícito num segredo protegido. Quando a
engenharia reversa é barata, a lei de segredos comerciais protege contra o furto, que sempre foi
errado, e não contra a compreensão, que sempre foi permitida.

**[ANÁLISE]** Dois limites mantêm esta leitura honesta. Primeiro, direitos autorais, patentes e
contratos continuam valendo: uma reconstrução em sala limpa pode copiar comportamento, mas não
expressão protegida, e uma licença pode proibir a engenharia reversa por contrato onde a lei local
admite essa cláusula. Segundo, um método lícito ainda pode ser usado para um fim ilícito, e a
licitude de uma ferramenta nada diz sobre cada uso dela. O ponto é mais estreito: a lei nunca
prometeu que um artefato fechado continuaria sem ser lido, e por isso o código fechado nunca teve a
garantia que a sua fé pressupunha.
