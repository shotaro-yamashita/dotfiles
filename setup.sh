#!/bin/sh

DIR="$(cd "$(dirname "${BASH_SOURCE:-${(%):-%N}}")"; pwd)"

FILES=()
FILES=("${FILES[@]}" .config)
FILES=("${FILES[@]}" .gitconfig)
FILES=("${FILES[@]}" .vimrc)

for file in ${FILES[@]}
do
  rm -rf $HOME/$file
  ln -s $DIR/$file $HOME/$file
done
