#!/bin/sh

git submodule init
git submodule update

cd .vim/bundle 

for i in `ls`
do cd $i; git pull; hg pull; hg up; cd -
done
