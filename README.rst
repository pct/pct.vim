=======
pct.vim
=======

----------
How to use
----------

1. clone to your home directory::

    $ git clone git://github.com/pct/pct.vim.git

2. update submodule in pct.vim::

    $ cd pct.vim; ./update_submodule.sh; cd -

3. link .vimrc and .vim from pct.vim::

    $ ln -s pct.vim/.vimrc
    $ ln -s pct.vim/.vim 

-------------
How to update
-------------
::

    $ cd pct.vim
    $ git pull; ./update_submodule.sh

---
FAQ
---

#. Cannot found ctags? Just find your ctags path and add the example setting bellow to your .vimrc::

    let g:easytags_cmd = '/usr/local/bin/ctags' 

#. Vim goes very slow::

    Please `rm ~/.vimtags` and then check again, but you will lose your previous easytags settings.

--------------------------------
Create your own vim environment
--------------------------------

1. use pct.vim for basement

2. use my "Vimpyre" project to add other useful vim scripts: https://github.com/pct/vimpyre

----------------------
vim scripts in bundle
----------------------

::

    Align
    Engspchk
    OOP-javascript-indentation.git
    PIV
    bufexplorer
    c.vim
    calendar.vim
    cocoa.vim
    css-pretty
    dbext.vim
    fugitive.vim
    gundo.vim
    html5.vim
    man-page-view
    matchit
    more.vim
    neocomplcache
    nerdtree_plugin
    nginx.vim
    pydiction
    ragtag
    snipmate.vim
    supertab
    taglist.vim
    txt-browser
    vcscommand
    vim-autocomplpop
    vim-coffee-script
    vim-easytags
    vim-easymotion
    vim-fuzzyfinder
    vim-l9
    vim-peepopen
    vim-rails
    vim-scmfrontend
    vim-surround
    vimwiki
    xmledit
    zencoding-vim

