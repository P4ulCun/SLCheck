#!/bin/bash

# read DIR
PATH=$1
# citirea fiecarui element din fisierul dir
function rec_search(){
    DIR=$1
    for file in $DIR/*; do
    if [ -L "$file" ]; then
        echo "${file##*/} is a symlink"
    elif [ -f "$file" ]; then
        echo "${file##*/} is a file"
    elif [ -d "$file" ]; then
        echo "${file##*/} is directory"
        rec_search $file
    fi
    done
}

rec_search $PATH