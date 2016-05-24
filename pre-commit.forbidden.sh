#!/bin/bash
# Script que detecta "expressões proibidas" baseado em expressões regulares.

# Forbidden é um mapa regex - mensagem, que é usado no laço abaixo.
declare -A forbidden=(
['\<\(é [ao]s\>\|\<são [ao]\)\>']='Possível erro de concordância de número.'
['\<\([Ii]rá\|[Ii]remos\|[Ii]rão\)\>']='Troque ex. "irá computar" por "computará".'
['\[p. [0-9]*\(\]\|,[^]]*]\)']='Existem números de página, em comandos "\cite", sem ties.
Considere substituir, por exemplo, "[p. 15]" por "[p.~15]".'
['\(^\|[^~]\)\\ref']='Considere adicionar espaços rígidos (~) antes de comandos "\ref".'
['\<nodo\>']='Use "nó" ou "vértice" em vez de "nodo" no contexto de grafos.'
['\<retorn']='Traduza "return" para "devolve" em vez de "retorna".'
['\<\(teorema\|lema\|corolário\|tabela\|figura\)~']='Capitalize: Teorema, Lema etc.'
)


message_written=0
forbidden_message=""
set_forbidden_message() {
    message_written=0
    forbidden_message="$@"
}
show_forbidden_message() {
    if ((message_written == 0)); then
        echo -n $(tput setaf 1)
        echo "$forbidden_message"
        echo -n $(tput sgr0)
        (( message_written = 1 ))
        (( error = 1 ))
    fi
}

for regex in "${!forbidden[@]}"; do
    set_forbidden_message "${forbidden[$regex]}"
    for file in $modified_files; do
        offending_lines=$(added_lines "$file" |
            grep --color=always "$regex"
        )
        if [ ! -z "$offending_lines" ]; then
            show_forbidden_message
            print_line "$file" "$offending_lines"
        fi
    done
done
