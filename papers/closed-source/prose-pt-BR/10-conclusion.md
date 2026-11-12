<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# Conclusão {#sec:conclusion}

O código fechado pedia aos pesquisadores que confiassem que o sigilo protegeria o seu trabalho.
Entre 2024 e 2026, essa confiança falhou publicamente: binários descompilados por modelos de
linguagem, modelos em produção lidos por meio das suas próprias respostas, capacidades copiadas pela
porta da frente, o código de um agente comercial publicado por uma etapa de build, um editor de
imagens profissional reconstruído em parte a partir do seu comportamento em semanas, e uma disputa
de segredo industrial entre duas das empresas mais valiosas da área travada em torno de laptops e
entrevistas de emprego. Linux e Git mostraram há muito tempo que a alternativa funciona em escala, e
os próprios laboratórios fechados começaram a publicar pesos e métodos.

A lei não prometeu outra coisa. Nos Estados Unidos, na União Europeia e no Brasil, estudar um
produto que se possui licitamente é um meio lícito; os meios impróprios, como o furto, o suborno e a
quebra de dever, não são. A criptografia também não prometeu outra coisa: desde Kerckhoffs, e nas
cartas de Nash, o método é público e só a chave é secreta. O que se pode proteger em 2026 é a
integridade e a identidade, com commits assinados, chaves em hardware e hashes de conteúdo que
também servem de citação.

O que resta é uma questão de boas maneiras, tornada urgente pelas máquinas. Se qualquer pessoa pode fazer engenharia reversa de
qualquer coisa, o caminho honesto é publicar o método, emitir um identificador e citar tudo o que se
usa, e exigir o mesmo dos agentes que agora fazem boa parte da leitura e da escrita. O Paper
Fabric é a minha tentativa de tornar esse caminho o padrão para o meu próprio trabalho. Seu código-fonte, sua configuração de
agentes e seus defeitos conhecidos são publicados junto com este artigo.

**[ANÁLISE]** Os escritores de 1949 não abandonaram a sua fé porque encontraram uma melhor. Eles a
abandonaram porque o que lhes foi prometido não batia com o que viam [@crossman1949god]. A fé no
código fechado falha do mesmo modo. Ela prometia que o que estava escondido continuaria escondido, e
entre 2024 e 2026 o registro mostra um binário lido por um modelo, um modelo lido pelas suas
respostas, um agente comercial publicado pelo seu próprio build, um aplicativo reconstruído em parte
a partir do seu comportamento e segredos levados pelas pessoas em quem se confiava. Ela prometia que
o custo do segredo não recaía sobre ninguém, e o registro mostra código que não se encontra, métodos
que não rodam e referências que não se verificam.

**[ANÁLISE]** A frase de Pirsig dá a razão pela qual a alternativa importa mais para a ciência. Se as
hipóteses que podem explicar um fenômeno não têm fim [@pirsig1974zen, p. 107], nenhum dono consegue
testá-las todas, e todo método que só o dono pode abrir é uma hipótese que o resto de nós não pode
testar. A abertura não é um presente que a ciência dá aos negócios. É a condição para que a ciência
possa continuar.

**[ANÁLISE]** O trabalho que resta é modesto e concreto. Publique o método. Assine-o. Dê a ele um
identificador e um hash. Cite aquilo em que ele se apoia, no ponto de uso, e faça os agentes que o
ajudam fazerem o mesmo, mecanicamente, com um build que falha quando não fazem. Faça isso, e a
pergunta de 2026, *alguém consegue fazer engenharia reversa do meu trabalho?*, tem uma resposta
tranquila: sim, e quando fizerem, saberão de quem ele é.

# Declarações {.unnumbered}

**Autoria.** A capa nomeia Mr. Nobody. Eu, Matheus Hoffmann, escrevi este artigo na primeira
pessoa, e os metadados de citação me nomeiam.

**Agradecimentos.** A ideia de uma fábrica autoaperfeiçoável deste artigo é de Bruno Valério.

**Uso de IA.** A estrutura, os rascunhos do texto, as verificações de referências, as ferramentas de build e a
configuração do repositório desta v0 foram produzidos por um agente de programação Claude (Anthropic) trabalhando em um
projeto Claude, sob a minha direção. Cada referência foi obtida e verificada pelo agente no
momento da redação; as verificações estão registradas no log de referências do repositório. A configuração do
agente está publicada no diretório `.claude/` do repositório. Sou responsável
pelo conteúdo.

**Conflitos de interesse.** Mantenho os projetos de código aberto citados na Seção [-@sec:related].
A Anthropic, cujos relatórios são citados na Seção [-@sec:espionage], também produz o modelo que
redigiu este artigo. Não declaro nenhum outro conflito de interesse.

**Disponibilidade.** Código-fonte, pipeline de build e configuração do agente:
<https://github.com/h0ffmann/closed-source>. Licença: texto CC BY 4.0; scripts de build AGPL-3.0-only;
template LaTeX MIT.

# Referências {.unnumbered}

::: {#refs}
:::
