#!/bin/sh

NAME_PATH='.vim/bundle/vim-easytags'

mkdir -p $NAME_PATH
cd $NAME_PATH
axel http://peterodding.com/code/vim/downloads/easytags
tar xvf easytags
rm -rf easytags

