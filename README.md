Hooks para código TeX em repositórios Git
=========================================

Este repositório contém um `pre-commit` hook para o Git
que verifica alguns erros de estilo em arquivos .tex.
A intensão é evitar a submissão de texto mal-escrito ao repositório.

Os scripts verificarão apenas linhas adicionadas ao repositório;
a premissa é de que texto que está no repositório
já passou por esta verificação,
portanto a decisão de mantê-lo não precisa ser tomada novamente.


Verificações feitas
-------------------
- Verificação ortográfica usando `aspell`
- Ausência de espaços rígidos dentro de comandos `\cite` e antes de comandos `\ref`
- Expressões "é as" e "são a"
- Uso do verbo "ir", como em "irá computar" (é melhor escrever "computará" neste caso)
- Existência de espaços em branco no final da linha
- Verbo "retornar" (a tradução correta de "return" é "devolver")
- Verbo "assumir" (a tradução correta de "assume" é "supor", ou "presumir")
- Termo "nodo" (no contexto de grafos, é melhor usar "nó" ou "vértice";
  "nodo" é usado principalmente em contextos médicos)
- Teorema/lema/corolário/tabela/figura escritos sem letra inicial maiúscula
  antes de espaços rígidos (que devem preceder comandos '\ref')


Instalação
----------

A ideia é que este repositório seja usado como submódulo
de outros repositórios TeX.
O script principal é `pre-commit`, na raiz deste repositório;
executar o script `setup.sh` a partir da raiz do repositório principal
criará um link simbólico dentro da pasta .git/hooks para o arquivo `pre-commit`.


Estrutura deste repositório
---------------------------

O script `pre-commit` invocará os demais scripts neste repositório.
A ideia é que cada tarefa seja executada por um arquivo.
