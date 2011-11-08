#!/bin/sh

cd ~
git clone git://github.com/pct/pct.vim.git
mv .vimrc .vimrc.yours
mv .vim .vim.yours
cd pct.vim; ./update.sh; cd -
cd ~/pct.vim/.vim/bundle/Command-T/ruby/command-t/; ruby extconf.rb; make; sudo make install; cd -
ln -s pct.vim/.vimrc
ln -s pct.vim/.vim
