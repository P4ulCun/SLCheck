#!/bin/bash

PATH=$1
FLAG=$2
declare -i CNT_BRKN_SYM=0

function rec_search(){
    DIR=$1
    for file in $DIR/*; do
    # verific pentru fiecare item ce tip de fila este
    if [ -L "$file" ]; then
        echo "${file##*/} is a symlink"
        if [ "$FLAG" == "-follow-symlink" ]; then
            # verific mai intai daca am mai trecut prin acest link
            if [[ "${file%/*}" != *"${file##*/}"* ]]; then
            # if ul e ca sa nu dea loop infinit
                if [[ -L "$file" ]] && [[ ! -a "$file" ]]; then
                    echo "$file is a broken symlink"
                    CNT_BRKN_SYM+=1
                else
                echo "follow the symlink: $file"
                rec_search $file
                fi
            fi
        fi
    elif [ -f "$file" ]; then
        echo "${file##*/} is a file"
    elif [ -d "$file" ]; then
        echo "${file##*/} is directory"
        rec_search $file
    fi
    done
}

rec_search $PATH
echo $CNT_BRKN_SYM