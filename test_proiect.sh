#!/bin/bash

# read DIR
DIR="/home/paul/repos/SLCheck/folder_test"
# citirea fiecarui element din fisierul dir
for file in $DIR/*; do
    if [ -L "$file" ]; then
        echo "${file##*/} is a symlink"
    elif [ -f "$file" ]; then
        echo "${file##*/} is a file"
    elif [ -d "$file" ]; then
        echo "${file##*/} is directory"
    fi
done