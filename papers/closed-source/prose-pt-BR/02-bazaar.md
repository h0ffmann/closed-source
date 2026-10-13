<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# O bazar que deu certo: Linus Torvalds, o Linux e o Git {#sec:bazaar}

Em 25 de agosto de 1991, um estudante da Universidade de Helsinque publicou no grupo da Usenet
`comp.os.minix` que estava "doing a (free) operating system (just a hobby, won't be big and
professional like gnu)" (em tradução livre: fazendo um sistema operacional (livre) (só um hobby, não
vai ser grande e profissional como o gnu)) para clones AT 386 e 486, e perguntou o que as pessoas
gostariam de ver nele [@torvalds1991minix]. A versão 0.01 veio em 17 de setembro de 1991. No início de
1992, Torvalds passou o kernel para a GNU General Public License, e a versão 0.95, de março de 1992,
foi o primeiro lançamento sob essa licença [@wikipedia2026linuxhistory].

O hobby se tornou o kernel de sistema operacional mais amplamente implantado da história. Ele roda em
servidores, telefones, roteadores, carros e nos supercomputadores dos quais depende boa parte da
ciência computacional. Não preciso de um número de participação de mercado para defender o ponto; a
semana do próprio leitor quase certamente passou por várias máquinas Linux.

A primeira conquista de Torvalds não foi apenas técnica. O relato de Eric Raymond sobre o
desenvolvimento do Linux, *The Cathedral and the Bazaar*, identificou o método social por trás dele:
lançar cedo, lançar com frequência, tratar os usuários como codesenvolvedores e deixar que muitos olhos
encontrem os bugs que poucos encontrariam [@raymond1998cathedral]. Raymond contrapôs esse *bazar* à
*catedral* do desenvolvimento cuidadosamente guardado e planejado de forma centralizada. O Linux
mostrou que o bazar era capaz de construir o tipo mais difícil de software que existe.

A segunda conquista de Torvalds nasceu de um fracasso do código fechado. A partir de 2002, o kernel
usou o BitKeeper, um sistema de controle de versão proprietário oferecido sem custo. Em abril de 2005,
esse acesso gratuito acabou. Nenhum sistema livre atendia às necessidades do projeto, então Torvalds
escreveu o seu próprio. Ele começou em 3 de abril de 2005; em 7 de abril, o Git já gerenciava o seu
próprio código-fonte; o primeiro merge de múltiplos branches veio em 18 de abril; e em 26 de julho ele
passou a manutenção a Junio Hamano [@wikipedia2026git]. O primeiro commit do repositório do Git, ainda
legível hoje, tem o título "Initial revision of "git", the
information manager from hell" (em tradução livre: revisão inicial do git, o gerenciador de informação
do inferno) [@torvalds2005git].

**[ANÁLISE]** O episódio do BitKeeper é uma pequena parábola para este artigo. A comunidade do kernel
havia aceitado uma ferramenta fechada por conveniência. Quando o dono a retirou, a comunidade ficou
exposta; quando Torvalds a substituiu por uma aberta, a substituta se tornou o substrato de quase todo o
desenvolvimento de software, inclusive dos repositórios, pull requests e tags de lançamento por meio
dos quais este artigo é construído e arquivado. O Git também encarna, em seu modelo de dados, a ética
que defendo na Seção [-@sec:citing]: todo commit nomeia o seu autor e aponta, por hash criptográfico,
para a história exata sobre a qual se constrói. O Git é um grafo de citações para código.

Elogio Torvalds aqui sem reservas por esses dois presentes e por três décadas mantendo o primeiro.
Observo também o que o elogio não exige: que o estilo técnico de uma pessoa seja copiado, ou que o
código aberto seja livre de conflitos. A tese é mais estreita e mais forte. A abertura, na maior escala
já tentada, deu certo.
