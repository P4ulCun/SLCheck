#!/bin/bash

PATH=$1
FLAG=$2
# verific daca flagul este unul valid
if [ $FLAG != "" ] && [ $FLAG != "-follow-symlink" ]; then
    echo "Did you want to use the flag: -follow-symlink?"
    exit 1
fi

declare -i CNT_BRKN_SYM=0

function rec_search(){
    DIR=$1
    for file in $DIR/*; do
    # verific pentru fiecare item ce tip de file este
    if [ -L "$file" ]; then
    # verific daca file ul este un symlink
        # verific daca symlink ul este broken
        if [[ -L "$file" ]] && [[ ! -e "$file" ]]; then
        # if [ este symlink ] si [ file doesn't exist ]
            echo "${file##*/} is a broken symlink"
            CNT_BRKN_SYM+=1
            continue
        fi

        echo "${file##*/} is a symlink"

        # daca e un symlink valid verific daca flagul este activat
        if [ $FLAG == "-follow-symlink" ]; then
            # verific mai intai daca am mai trecut prin acest link
            if [[ "${file%/*}" != *"${file##*/}"* ]]; then
            # if ul e ca sa nu dea loop infinit
                echo "follow the symlink: $file"
                rec_search $file
            fi
        fi
    elif [ -f "$file" ]; then
    # verific daca file ul este un file
        echo "${file##*/} is a file"
    elif [ -d "$file" ]; then
    # verific daca file ul este un directory
        echo "${file##*/} is directory"
        rec_search $file
    fi
    done
}

# main
rec_search $PATH
echo 
echo "Numarul de broken symlinks este: $CNT_BRKN_SYM"