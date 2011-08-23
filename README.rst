=======
pct.vim
=======

Requirements
-------------
#. git
#. mercurial hg
#. ctags (exuberant-ctags), and please change the ctags path from your .vimrc(please install pct.vim first)::

    let g:easytags_cmd = '/usr/local/bin/ctags'

#. links # for :Man <php_function>.php
#. curl  # for more.vim, insert chinese words from '中文假文產生器'
#. check and install what you need if you develop in these languages::

    c, cpp     : Check syntax via splint
    html       : Check syntax via tidy
    javascript : Check syntax via jsl or gjslint
    java       : Check syntax via jlint or javaCheckstyle
    lua        : Parse file (luac -p)
    php        : Check syntax (php -l)
    phpp       : Parse a file (php -f) (alternative php checker)
    python     : Check file with pyflakes
    pylint     : Use the pylint compiler plugin (alternative python checker)
    ruby       : Check syntax (ruby -c; no auto-checks)
    tex, latex : Parse file (chktex -q -v0; no auto-checks)
    xml, docbk : Check syntax via xmllint

One Step Install (Do you trust me?)
------------------------------------
command::

    $ wget --no-check-certificate https://github.com/pct/pct.vim/raw/master/install.sh -O - | sh

The origin .vim and .vimrc will be renamed to .vim.yours and .vimrc.yours

The manual way to install pct.vim
----------------------------------
1. clone to your home directory::

    $ git clone git://github.com/pct/pct.vim.git

2. update submodule in pct.vim::

    $ cd pct.vim; ./update_submodule.sh; cd -

3. link .vimrc and .vim from pct.vim::

    $ ln -s pct.vim/.vimrc
    $ ln -s pct.vim/.vim

4. add command-t support::

    $ cd ~/pct.vim/.vim/bundle/Command-T/ruby/command-t/; ruby extconf.rb; make; sudo make install; cd -

How to update
-------------
::

    $ cd pct.vim
    $ git pull; ./update_submodule.sh

FAQ
---

#. Cannot found ctags? Just find your ctags path and add the example setting bellow to your .vimrc::

    let g:easytags_cmd = '/usr/local/bin/ctags' 

#. Vim goes very slow::

    Please `rm ~/.vimtags` and then check again, but you will lose your previous easytags settings.

#. I want to use command-t, but always something wrong::

    1. Please make sure your vim had build for ruby support 
    2. cd ~/pct.vim/.vim/bundle/Command-T/ruby/command-t/; ruby extconf.rb; make; sudo make install 

Create your own vim environment
--------------------------------

1. use pct.vim for basement

2. use my "Vimpyre" project to add other useful vim scripts: https://github.com/pct/vimpyre


Vim scripts in bundle (and simple  howto)
-----------------------------------------
#. checksyntax https://github.com/tomtom/checksyntax_vim ::

    :CheckSyntax

    c, cpp     : Check syntax via splint
    html       : Check syntax via tidy
    javascript : Check syntax via jsl or gjslint
    java       : Check syntax via jlint or javaCheckstyle
    lua        : Parse file (luac -p)
    php        : Check syntax (php -l)
    phpp       : Parse a file (php -f) (alternative php checker)
    python     : Check file with pyflakes
    pylint     : Use the pylint compiler plugin (alternative python checker)
    ruby       : Check syntax (ruby -c; no auto-checks)
    tex, latex : Parse file (chktex -q -v0; no auto-checks)
    xml, docbk : Check syntax via xmllint

#. Align https://github.com/vim-scripts/Align ::

    :5,10Align =
        Align on '=' signs

    :'<,'>Align = + - \* /
        Align on any of the five separator characters shown.
        Note that visual block mode was used to fire off Align.

    :AlignCtrl =lp1P1I
        which means:
        = all separators are equivalent
        l fields will be left-justified
        p1 pad one space before each separator
        P1 pad one space after each separator
        I  preserve and apply the first line's leading white space to all
           Align'd lines

    :help align
        Gives help for Align

#. Engspchk https://github.com/vim-scripts/Engspchk ::

    \ec

#. OOP-javascript-indentation.git https://github.com/vim-scripts/OOP-javascript-indentation 
#. PIV https://github.com/vim-scripts/PIV ::

    Updated Syntax
    Better Fold Support
    PHP Doc Gen
    Better Completion
    Better indenting w/automatic formatting

#. bufexplorer https://github.com/vim-scripts/bufexplorer.zip ::

    \be (normal open)  or
    \bs (force horizontal split open)  or
    \bv (force vertical split open)

#. calendar.vim https://github.com/vim-scripts/calendar.vim--Matsumoto ::

    :Calendar

#. cocoa.vim https://github.com/vim-scripts/cocoa.vim
#. css-pretty https://github.com/vim-scripts/Css-Pretty
#. fugitive.vim https://github.com/vim-scripts/fugitive.vim ::

    git commands

    :Git
    :Gstatus
    :Gcommit
    :Gblame
    :Gmove
    :Ggrep
    :Gremove
    :Glog
    :Gread
    :Gwrite

#. gundo.vim https://github.com/sjl/gundo.vim ::

    Gundo.vim is Vim plugin to visualize your Vim undo tree.

#. html5.vim https://github.com/othree/html5.vim ::

    HTML5 omnicomplete funtion and syntax for Vim. Based on the default htmlcomplete.vim.

#. man-page-view https://github.com/vim-scripts/ManPageView ::

    :Man topic
    :Man topic booknumber
    :Man booknumber topic
    :Man topic(booknumber)

    INFO
        :Man info.i

    PERL (requires the perldoc program)
        :Man printf.pl
        :Man cos.pl
        :Man sprintf.pl

    PHP (requires the links program)
        :Man printf.php

    PYTHON (requires pydoc)
        :Man pprint.py


#. matchit https://github.com/vim-scripts/matchit.zip 
#. more.vim https://github.com/c9s/more.vim ::

    snipMate.vim : [count]more<Tab>，其中 [count] 是可选的数值。
    命令 :AppendMoreText[ count]，其中 [ count] 是可选的数值。
    命令 :MoreText[ count]，同上。
    插入模式快速鍵：`more，在光标后插入假文。
    普通模式快捷键：`more，在下一行插入 [count] 行假文。
    普通模式快捷键：<leader>more，同上。
    簡單的說，在輸入模式時，輸入 `more 即可隨心所欲自動插入假文； 如果安装有 snipMate.vim，还可以使用 [count]more<Tab> 插入 count 行。

    而輸入 :MoreText[ count] 命令可在下一行插入 count 行假文。

#. neocomplcache https://github.com/Shougo/neocomplcache ::

    Ultimate auto-completion system for Vim

#. nerdtree https://github.com/scrooloose/nerdtree ::

    :NERDTree [<start-directory> | <bookmark>]
    :NERDTreeFromBookmark <bookmark>             
    :NERDTreeToggle [<start-directory> | <bookmark>] 
    :NERDTreeMirror                                 
    :NERDTreeClose                                 
    :NERDTreeFind                                 
    :Bookmark <name>
    :BookmarkToRoot <bookmark>
    :RevealBookmark <bookmark>
    :OpenBookmark <bookmark>
    :ClearBookmarks [<bookmarks>]
    :ClearAllBookmarks
    :ReadBookmarks

#. nginx.vim https://github.com/vim-scripts/nginx.vim ::

    nginx syntax

#. pydiction https://github.com/vim-scripts/Pydiction ::

    Tab-complete your Python code 

#. ragtag https://github.com/vim-scripts/ragtag.vim ::

    A set of mappings for HTML, XML, PHP, ASP, eRuby, JSP, and more (formerly allml) 

#. snipmate.vim https://github.com/msanders/snipmate.vim ::

    Just use <Tab> to complete your code

#. supertab https://github.com/ervandew/supertab ::

    Supertab is a plugin which allows you to perform all your insert completion (|ins-completion|) using the tab key.

#. taglist.vim https://github.com/vim-scripts/taglist.vim ::

    :TlistAddFiles {file(s)} [file(s) ...]
    :TlistAddFilesRecursive {directory} [ {pattern} ]
    :TlistClose     Close the taglist window. 
    :TlistDebug [filename]
    :TlistLock
    :TlistMessages
    :TlistOpen      Open and jump to the taglist window. 
    :TlistSessionSave {filename}
    :TlistSessionLoad {filename}
    :TlistShowPrototype [filename] [linenumber]
    :TlistShowTag [filename] [linenumber]
    :TlistHighlightTag
    :TlistToggle    Open or close (toggle) the taglist window. 
    :TlistUndebug
    :TlistUnlock
    :TlistUpdate    Update the tags information for the current buffer. 

#. txt-browser https://github.com/vim-scripts/TxtBrowser ::

    *txtbrowser*    Plugin for browsing plain text 

#. vcscommand https://github.com/vim-scripts/vcscommand.vim ::

    :VCSAdd               
    :VCSAnnotate[!]       
    :VCSBlame[!]          
    :VCSCommit[!]         
    :VCSDelete            
    :VCSDiff              
    :VCSGotoOriginal      
    :VCSGotoOriginal!     
    :VCSInfo              
    :VCSLock              
    :VCSLog               
    :VCSRemove            
    :VCSRevert            
    :VCSReview            
    :VCSStatus            
    :VCSUnlock            
    :VCSUpdate            
    :VCSVimDiff           
    :CVSEdit              
    :CVSEditors           
    :CVSUnedit            
    :CVSWatch             
    :CVSWatchAdd          
    :CVSWatchOn           
    :CVSWatchOff          
    :CVSWatchRemove       
    :CVSWatchers          

#. vim-autocomplpop http://bitbucket.org/ns9tks/vim-autocomplpop ::

    Automatically opens popup menu for completions

#. vim-coffee-script https://github.com/vim-scripts/vim-coffee-script ::

    CoffeeScript support for vim

#. vim-easytags https://github.com/xolox/vim-easytags ::

    Automated tag generation and syntax highlighting in Vim

#. vim-easymotion https://github.com/Lokaltog/vim-easymotion ::

    EasyMotion provides a much simpler way to use some motions in vim

    \m

#. vim-fuzzyfinder https://bitbucket.org/ns9tks/vim-fuzzyfinder/ ::

    Fuzzy/Partial pattern explorer for buffer/file/MRU/command/bookmark/tag/etc.

#. vim-l9 https://bitbucket.org/ns9tks/vim-l9 

#. vim-peepopen https://github.com/shemerey/vim-peepopen ::

    see http://amix.dk/blog/post/19601 for intro, like command-T but Mac OSX Only.

#. vim-rails https://github.com/tpope/vim-rails ::

    :Rails new {directory}  The only global command.  Creates a new Rails
    :Rails!                 Show the version of rails.vim installed.  If rails.vim
    :Rcd [{directory}]      |:cd| to /path/to/railsapp/{directory}.
    :Rlcd [{directory}]     |:lcd| to /path/to/railsapp/{directory}.
    :Rdoc                   Browse to the Rails API, either in doc/api in the
    :Rdoc!                  Make the appropriate |:helptags| call and invoke
    :Redit {file}           Edit {file}, relative to the application root.  Append
    :Rlog [{logfile}]       Split window and open {logfile} ($RAILS_ENV or
    :Rpreview [{path}]      Creates a URL from http://localhost:3000/ and the
    :Rpreview! [{path}]     As with :Rpreview, except :OpenURL is never used.
    :Rtags                  Calls ctags -R on the current application root and
    :Rrefresh               Refreshes certain cached settings.  Most noticeably,
    :Rrefresh!              As above, and also reloads rails.vim.
    :OpenURL {url}          This is not a command provided by the plugin, but
    :Rfind [{file}]         Find {file}.  Very similar to :find, but things like
    :A                      These commands were picked to mimic Michael Sharpe's
    :AE                     a.vim.  Briefly, they edit the "alternate" file, in
    :AS                     either the same window (:A and :AE), a new split
    :AV                     window (:AS), a new vertically split window (:AV), a
    :AT                     new tab (:AT), or read it into the current buffer
    :AD                     (:AD).  A mapping for :A is [f .
    :R                      These are similar |rails-:A| and friends above, only
    :RE                     they jump to the "related" file rather than the
    :RS                     "alternate."  A mapping for :R is ]f .
    :RV                     
    :RT
    :RD
    :Rmodel, those variants would be :RSmodel, :RVmodel, :RTmodel, and :RDmodel.
    :Rcontroller                                    |rails-:Rcontroller|
    :Renvironment                                   |rails-:Renvironment|
    :Rfixtures                                      |rails-:Rfixtures|
    :Rfunctionaltest                                |rails-:Rfunctionaltest|
    :Rhelper                                        |rails-:Rhelper|
    :Rinitializer                                   |rails-:Rinitializer|
    :Rintegrationtest                               |rails-:Rintegrationtest|
    :Rjavascript                                    |rails-:Rjavascript|
    :Rlayout                                        |rails-:Rlayout|
    :Rlib                                           |rails-:Rlib|
    :Rlocale                                        |rails-:Rlocale|
    :Rmailer                                        |rails-:Rmailer|
    :Rmetal                                         |rails-:Rmetal|
    :Rmigration                                     |rails-:Rmigration|
    :Rmodel                                         |rails-:Rmodel|
    :Robserver                                      |rails-:Robserver|
    :Rplugin                                        |rails-:Rplugin|
    :Rspec                                          |rails-:Rspec|
    :Rstylesheet                                    |rails-:Rstylesheet|
    :Rtask                                          |rails-:Rtask|
    :Runittest                                      |rails-:Runittest|
    :Rview                                          |rails-:Rview|
    :Rcontroller [{name}]   Edit the specified or current controller.
    :Renvironment [{name}]  Edit the config/environments file specified.  With no
    :Rfixtures [{name}]     Edit the fixtures for the given or current model.  If
    :Rfunctionaltest [{name}]
    :Rhelper [{name}]       Edit the helper for the specified name or current
    :Rinitializer [{name}]  Edit the config/initializers file specified.  With no
    :Rintegrationtest [{name}]
    :Rjavascript [{name}]   Edit the JavaScript for the specified name or current
    :Rlayout [{name}]       Edit the specified layout.  Defaults to the layout for
    :Rlib [{name}]          Edit the library from the lib directory for the
    :Rlocale [{name}]       Edit the config/locale file specified, optionally
    :Rmailer [{name}]       Edit the mailer specified.  This looks in both
    :Rmetal [{name}]        Edit the app/metal file specified.  With no argument,
    :Rmigration [{pattern}] If {pattern} is a number, find the migration for that
    :Rmodel [{name}]        Edit the specified or current model.
    :Robserver [{name}]     Find the observer with a name like
    :Rplugin [{plugin}[/{path}]]
    :Rspec [{name}]         Edit the given spec.  With no argument, defaults to
    :Rstylesheet [{name}]   Edit the stylesheet for the specified name or current
    :Rtask [{name}]         Edit the .rake file from lib/tasks for the specified
    :Runittest [{name}]     Edit the unit test or model spec for the specified
    :Rview [[{controller}/]{view}]
    :Rnavcommand [options] {name} [{path} ...]
    :Rcommand               Obsolete alias for |:Rnavcommand|.
    :[range]Rake {targets}  Calls |:make!| {targets} (with 'makeprg' being rake,
    :[range]Rake! {targets} Called with a bang, :Rake will forgo opening the
    :Rscript {script} {options}
    :Rconsole {options}     Obsolete. Call |:Rscript| instead.
    :[range]Rrunner {code}  Executes {code} with script/runner.  Differs from
    :[range]Rp {code}       Like :Rrunner, but call the Ruby p method on the
    :[range]Rpp {code}      Like :Rp, but with pp (pretty print) or y (YAML
    :[range]Ry  {code}      output).
    :Rgenerate {options}    Calls script/generate {options}, and then edits the
    :Rdestroy {options}     Calls script/destroy {options}.
    :Rserver {options}      Launches script/server {options} in the background.
    :Rserver! {options}     Same as |:Rserver|, only first attempts to kill any
    :[range]Rextract [{controller}/]{name}  
    :[range]Rpartial [{controller}/]{name}  
    :Rinvert                In a migration, rewrite the self.up method into a
    :Rtree [{arg}]          If |NERDTree| is installed, open a tree for the
    :Rdbext [{environment}] This command is only provided when the |dbext| plugin
    :Rabbrev                List all Rails abbreviations.
    :Rabbrev {abbr} {expn} [{extra}]
    :Rabbrev! {abbr}        Remove an abbreviation.
    :Rset {option}[={value}]

#. vim-scmfrontend https://bitbucket.org/ns9tks/vim-scmfrontend ::

    :SfeCommand[!]                  (Default mapping: \s:)
    :SfeCommitFile[!]               (Default mapping: \sC)
    :SfeCommitTracked[!]            (Default mapping: \s<C-c>)
    :SfeCommitAll[!]                (Default mapping: \sc)
    :SfeRecordFile[!]               (Default mapping: \sE)
    :SfeRecordAll[!]                (Default mapping: \se)
    :SfeCheckout[!]                 (Default mapping: \so)
    :SfeMerge[!]                    (Default mapping: \sm)
    :SfeBranch[!]                   (Default mapping: \sb)
    :SfeBranchDelete[!]             (Default mapping: \sB)
    :SfeRebase[!]                   (Default mapping: \sr)
    :SfeStrip[!]                    (Default mapping: \st)
    :SfePull[!]                     (Default mapping: \s[)
    :SfePush[!]                     (Default mapping: \s])
    :SfeDiffFile[!]                 (Default mapping: \sD)
    :SfeDiffAll[!]                  (Default mapping: \sd)
    :SfeLogFile[!]                  (Default mapping: \sL)
    :SfeLogAll[!]                   (Default mapping: \sl)
    :SfeAnnotateFile[!]             (Default mapping: \sn)
    :SfeStatus[!]                   (Default mapping: \ss)
    :SfeGrep[!]                     (Default mapping: \sg)
    :SfeLoadModified[!]             (Default mapping: \s!)
    :SfeLoadAll[!]                  (Default mapping: \s<CR>)
    :SfeFindFile[!]                 (Default mapping: \sf)

#. vim-surround https://github.com/tpope/vim-surround ::

    surround.vim: quoting/parenthesizing made simple

#. vimwiki https://github.com/vim-scripts/vimwiki :: 

    Personal Wiki for Vim
    :Vimwiki2HTML -- Convert current wiki link to HTML
    :VimwikiAll2HTML -- Convert all your wiki links to HTML

#. xmledit https://github.com/sukima/xmledit ::

    A filetype plugin for VIM to help edit XML files

#. command-t https://github.com/vim-scripts/Command-T/ ::

    https://wincent.com/products/command-t

    \t
    \b

#. zencoding-vim https://github.com/mattn/zencoding-vim ::

    Tutorial of zencoding.vim

                                                        mattn <mattn.jp@gmail.com>

    1. Expand Abbreviation

      Type abbreviation as 'div>p#foo$*3>a' and type '<c-y>,'.
      ---------------------
      <div>
          <p id="foo1">
              <a href=""></a>
          </p>
          <p id="foo2">
              <a href=""></a>
          </p>
          <p id="foo3">
              <a href=""></a>
          </p>
      </div>
      ---------------------

    2. Wrap with Abbreviation

      Write as below.
      ---------------------
      test1
      test2
      test3
      ---------------------
      Then do visual select(line wize) and type '<c-y>,'.
      If you request 'Tag:', then type 'ul>li*'.
      ---------------------
      <ul>
          <li>test1</li>
          <li>test2</li>
          <li>test3</li>
      </ul>
      ---------------------

      If you type tag as 'blockquote', then you'll see as following.
      ---------------------
      <blockquote>
          test1
          test2
          test3
      </blockquote>
      ---------------------

    3. Balance Tag Inward

      type '<c-y>d' in insert mode.

    4. Balance Tag Outward

      type '<c-y>D' in insert mode.

    5. Go to Next Edit Point

      type '<c-y>n' in insert mode.

    6. Go to Previous Edit Point

      type '<c-y>N' in insert mode.

    7. Update <img> Size

      Move cursor to img tag.
      ---------------------
      <img src="foo.png" />
      ---------------------
      Type '<c-y>i' on img tag 
      ---------------------
      <img src="foo.png" width="32" height="48" />
      ---------------------

    8. Merge Lines

      select the lines included '<li>'
      ---------------------
      <ul>
        <li class="list1"></li>
        <li class="list2"></li>
        <li class="list3"></li>
      </ul>
      ---------------------
      and type 'J'
      ---------------------
      <ul>
        <li class="list1"></li><li class="list2"></li><li class="list3"></li>
      </ul>
      ---------------------

    9. Remove Tag

      Move cursor in block
      ---------------------
      <div class="foo">
        <a>cursor is here</a>
      </div>
      ---------------------
      Type '<c-y>k' in insert mode.
      ---------------------
      <div class="foo">
        
      </div>
      ---------------------

      And type '<c-y>j' in there again.
      ---------------------

      ---------------------

    10. Split/Join Tag

      Move cursor in block
      ---------------------
      <div class="foo">
        cursor is here
      </div>
      ---------------------
      Type '<c-y>j' in insert mode.
      ---------------------
      <div class="foo"/>
      ---------------------

      And type '<c-y>j' in there again.
      ---------------------
      <div class="foo">
      </div>
      ---------------------

    11. Toggle Comment

      Move cursor to block
      ---------------------
      <div>
        hello world
      </div>
      ---------------------
      Type '<c-y>/' in insert mode.
      ---------------------
      <!-- <div>
        hello world
      </div> -->
      ---------------------
      Type '<c-y>/' in there again.
      ---------------------
      <div>
        hello world
      </div>
      ---------------------

    12. Make anchor from URL

      Move cursor to URL
      ---------------------
      http://www.google.com/
      ---------------------
      Type '<c-y>a'
      ---------------------
      <a href="http://www.google.com/">Google</a>
      ---------------------

    13. Make quoted text from URL

      Move cursor to URL
      ---------------------
      http://github.com/
      ---------------------
      Type '<c-y>A'
      ---------------------
      <blockquote class="quote">
        <a href="http://github.com/">Secure source code hosting and collaborative development - GitHub</a><br />
        <p>How does it work? Get up and running in seconds by forking a project, pushing an existing repository...</p>
        <cite>http://github.com/</cite>
      </blockquote>
      ---------------------

    14. Installing zencoding.vim for language you using.

      # cd ~/.vim
      # unzip zencoding-vim.zip

      or if you install pathogen.vim:

      # cd ~/.vim/bundle # or make directory
      # unzip /path/to/zencoding-vim.zip

      if you get sources from repository:

      # cd ~/.vim/bundle # or make directory
      # git clone http://github.com/mattn/zencoding-vim.git

    15. Enable zencoding.vim for language you using.

      You can customize the behavior of language you using.

      ---------------------
      # cat >> ~/.vimrc
      let g:user_zen_settings = {
      \  'php' : {
      \    'extends' : 'html',
      \    'filters' : 'c',
      \  },
      \  'xml' : {
      \    'extends' : 'html',
      \  },
      \  'haml' : {
      \    'extends' : 'html',
      \  },
      \}
      ---------------------

