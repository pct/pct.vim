#!/bin/sh

git pull origin master
git submodule init
git submodule update

cd .vim/bundle 

for i in `ls`
do cd $i;
    if [ -e .git ]; then
        git checkout master; git pull; 
    fi;

    if [ -e .hg ]; then
        hg pull; hg up; 
    fi;
    
    cd -
done
