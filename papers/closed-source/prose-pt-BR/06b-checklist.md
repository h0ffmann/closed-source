<!-- cite: main="Claude"; last="Matheus Hoffmann" -->
# O que fazer agora: uma lista de verificação para um pesquisador em 2026 {#sec:checklist}

O argumento deste artigo termina na prática, por isso fecho com uma lista que qualquer
pesquisador, grupo de pesquisa ou laboratório pequeno pode seguir em uma semana. Cada item nomeia a
seção onde está a sua razão. Nada disso exige a permissão de ninguém.

## Publicar

1. **Publique o método junto com o resultado.** Coloque o código, a configuração e o ambiente que
   produziram um resultado num repositório público, sob uma licença que permita o reuso
   (Seções [-@sec:dead] e [-@sec:openweights]).
2. **Registre o ambiente, não só o código.** Fixe as versões de cada ferramenta, por exemplo com um
   arquivo de lock ou um flake do Nix, para que o código continue rodando quando as suas
   dependências mudarem; código publicado que não roda é só meio aberto (Seção [-@sec:dead]).
3. **Mantenha em segredo só o que precisa ser secreto.** Chaves, credenciais, dados pessoais e
   material sob acordo ficam privados e cifrados; o método, não (Seções [-@sec:securing] e
   [-@sec:limits]).

## Proteger

4. **Assine o que publica.** Assine commits e tags, guarde a chave de assinatura num token de
   hardware e ative a autenticação de dois fatores na forja (Seção [-@sec:securing]).
5. **Nomeie artefatos pelo seu hash.** Cite código por um hash de conteúdo, como um commit ou um
   SWHID, além de um DOI (Seções [-@sec:securing] e [-@sec:citing]).
6. **Não conte com a ofuscação.** Se um produto precisa ser distribuído como binário, a ofuscação pode
   aumentar o custo de um atacante; ela não consegue manter um método em segredo, e também custa ao
   dono (Seção [-@sec:securing]).

## Citar

7. **Gere identificadores.** Arquive cada versão e obtenha um DOI de conceito e um DOI de versão;
   acrescente um `CITATION.cff` para que a citação possa ser gerada em vez de digitada (Seção
   [-@sec:citing]).
8. **Cite no ponto de uso e propague.** Coloque a citação de cada elemento emprestado onde ele é
   usado, e liste as obras citadas como identificadores relacionados no registro do arquivo (Seção
   [-@sec:citing]).
9. **Verifique cada referência.** Busque cada fonte antes de citá-la e guarde um registro da
   verificação; nunca deixe um agente citar o que não buscou (Seções [-@sec:citing] e
   [-@sec:fabric]).

## Configurar os agentes

10. **Escreva as regras.** Dê a cada agente que trabalha no repositório um `AGENTS.md` com as três
    regras da Seção [-@sec:citing], e faça o build falhar quando uma regra for quebrada.
11. **Marque o que é interpretação.** Peça aos agentes que separem fatos de análise e que deixem uma
    marca onde só a experiência do próprio autor pode preencher uma lacuna, em vez de inventá-la
    (Seção [-@sec:fabric]).
12. **Estude os outros licitamente, e diga isso.** Quando um agente estudar outro produto, fique no que
    você possui licitamente, prefira a sala limpa e cite o que foi estudado (Seções [-@sec:law] e
    [-@sec:espionage]).

**[ANÁLISE]** A lista é curta de propósito. Cada item custa minutos ou horas, uma vez. Cada um protege
algo que o segredo não consegue proteger: que o trabalho possa ser verificado, que ele seja do autor e
que o autor receba crédito quando ele for usado. No mundo que a explosão do REA criou, essas são as
únicas proteções que ainda funcionam.
