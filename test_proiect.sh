#!/bin/bash

PATH=$1
FLAG=$2

function rec_search(){
    DIR=$1
    for file in $DIR/*; do
    if [ -L "$file" ]; then
        echo "${file##*/} is a symlink"
        if [ "$FLAG" == "-follow-symlink" ]; then
            echo "follow the symlink: $file"
            rec_search $file
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