#!/bin/sh

cd ~
git clone git://github.com/pct/pct.vim.git
mv .vimrc .vimrc.yours
mv .vim .vim.yours
cd pct.vim; ./update_submodule.sh; cd -
ln -s pct.vim/.vimrc
ln -s pct.vim/.vim
