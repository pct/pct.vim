pct.vim 
=======

https://github.com/pct/pct.vim

                pct (林錦賜) 
                @vim-taiwan, @TOSSUG

~~~~

* 大綱：

  - Vim - 換不掉的 **編輯器** (泣)
  - pct.vim - 只是一堆 vim **外掛**
  - vimpyre - vim **套件管理** 工具
  - Vim Game - 在 vim 裡玩 **遊戲**

~~~~

* 我的簡報沒有梗，請不要期待

~~~~

**現在正在用 pct.vim 簡報給各位看**

~~~~

* 自我介紹

~~~~

**pct**

~~~~

* pct (林錦賜, Daniel Lin)

  - 是個 Mac 上面的圖檔副檔名
  - 是我老婆 10 年前用的 BBS 暱稱
  - 是的，她的暱稱被我拿來用
  - 所以你當然可以叫我 Daniel

~~~~

**現職**

~~~~

* 現職 (某設計公司撞鐘人員)

  - 老婆從事 **平面設計**
  - 我改行做 **程式設計**
  - 我愛用 vim 寫 code

~~~~

* 所以，**某設計公司正用 vim 生產產品**

  - 其實只是餬口而已(小小聲)

~~~~

**Why Vim?**

~~~~


* Why Vim?

  - 是我 **想換都換不掉** 的編輯器

~~~~

**Why not Vim?**

~~~~

* Why not vim?

  - Not Fashion?(eclipse, netbean?) 
  - 被說成網管？
    If you really care about it
  - 人家說 emacs 是偽裝成編輯器的 OS
  - **不具有雲端功能，也沒有奈米科技**

~~~~

**pct.vim**

~~~~

* Why or Why NOT pct.vim?
  
  - 真理之蛇::

    while(True):
        print('你不需要 pct.vim Q_Q')

~~~~

* 拜託請不要現在離席(我會哭)

~~~~

* 講這麼久終於...
  把 You don't care 的部份講完(握拳)

~~~~

**pct.vim Requirements**

~~~~

* Requirements

  - git
  - mercurial hg (so, install python)
  - ctags (exuberant-ctags)
  - links # for :Man <php_function>.php
  - curl  # for more.vim, 中文假文產生器
  - ruby  # for command-t

~~~~

* One Step Install(Do You Trust me?):: 

  $ wget --no-check-certificate \
      https://github.com/pct/pct.vim/raw/master/install.sh -O - | sh

~~~~

* How to update::

  $ cd pct.vim
  $ git pull; ./update_submodule.sh

~~~~

**Vim scripts in pct.vim**

~~~~

* 套件很多，不會全部介紹

  - 以下都只有 demo，要看詳細教學請到
    https://github.com/pct/pct.vim

~~~~

* Live Demo::

  --- livedemo.orig
  +++ livedemo    
  @@ -1 +1 @@
  - 出草時間
  + 出包時間

~~~~

* checksyntax

  - demo: python 儲存
  - demo: php 儲存
  - demo: html 儲存

~~~~

* Align

  - **排版控都愛用**
  - 我們公司做的事就是排版
  - demo: 排版

~~~~

* Engspchk

  - 先說先贏之 - 我英文真的不好
  - demo: spell check

~~~~

* PIV 

  - demo: php code fold (auto)
  - demo: php doc gen (,pd)

~~~~

* bufexplorer 

  - demo: \be 一般
  - demo: \bs 水平
  - demo: \bv 垂直

~~~~

* calendar.vim 

  - demo 日曆功能::
    
    :Calendar
    :CalendarH

~~~~

* fugitive.vim 

  - **************
  - 已鎖碼，留待下一位講者介紹

~~~~

* gundo.vim 

  - demo::
  
    :GundoToggle
    :GundoRenderGraph

~~~~

* man-page-view

  - demo: perl (print)
  - demo: php (print)
  - demo: python (print)

~~~~

* matchit 

  - vim 內建 % 配對
  - demo: 增強後的配對
  - 找尋另一半尤其適用！

~~~~

* nerdtree

  - demo::

    :NERDTree

~~~~

* vim-easymotion

  - demo: \mF

~~~~

* vim-rails

  - demo::

    :Rails

~~~~

* vim-surround 

  - demo: 單引號、單括弧...
  - 自動打出結尾符號

~~~~

* vimwiki

  - demo: 略過

~~~~

* command-t 

  - demo: \t, \b

~~~~

* present.vim

  - 我從 presen.vim 改的
  - 他用 markdown, 我用 rst
  - demo: 這份簡報一直都在 demo 它:: 

    :StartPresent

~~~~

* VST 

  - Vim reStructured Text
  - demo 把這份簡報檔轉成 html::

    :Vsti html

~~~~

* zencoding-vim 

  - demo: zencoding

~~~~

**pct.vim FAQ**

~~~~

* Q1, 找不到 (ex)ctags

  - 在你的 .vimrc 增加這行
    (Linux 請改 path)::

    let g:easytags_cmd = '/usr/local/bin/ctags' 

~~~~

* Q2, pct.vim 用久了光開檔就很慢

  - 因為有用 easytags plugin, 會生成
    ~/.vimtags 檔案在檔案大於 1 MB 時，
    會很容易感受到 vim 變慢，
    直接刪除 ~/.vimtags 即可

~~~~

* Q3, command-t 報錯

  - 檢查 vim 安裝時有無 ruby support
  - 重新裝 command-t::
    
    $ cd ~/pct.vim/.vim/bundle/Command-T/ruby/command-t/
    $ ruby extconf.rb; make; sudo make install 

~~~~

**vimpyre**

~~~~

* vimpyre

  - vim
  - pythoh
  - git
  - pathogen

~~~~

* 因為名叫 vimpyre 

  - 所以會派出 bat 
    幫你去 github 抓東西回來剖析
  - 可惜不夠強大，現在還無法派出 batman
  - 也避免成為失敗的 man

~~~~

* vimpyre 安裝

  - python 的 pip or eazy_install::

    $ sudo pip install vimpyre

~~~~

* vimpyre 使用

  - init    # 裝必要環境
  - syncdb  # 從 github 抓外掛目錄
  - search  html5
  - install <script1> <script2>
  - remove  <script1> <script2>
  - update  <script1> <script2> 
  - browse  html5.vim 

~~~~

* vimpyre 進階使用

  - syncdb # 更新 vim scripts 目錄
  - update_all
  - remove_all
  - list_all
  - list_installed

~~~~

**Vim Games**

~~~~

* `vimpyre search game`

  - TeTrIs.vim => 俄羅斯方塊 \te
  - sokoban.vim => 倉庫番
  - Naught-n-crosses => 井字 OX 遊戲
  - Tower-of-Hanoi => 河內塔
  - Nibble => 貪食蛇
  - rubikscube.vim => 魔術方塊
  - Mastermind-board-game => 某桌遊
  - sudoku_game => 數獨

~~~~

* FAQ 時間

  - 因為我也是新手，
    所以答不出來是正常的
  - 歡迎大家提問 :)

~~~~

**簡報至此結束，謝謝大家**

  * Plurk: @pct
  * Github: @pct
  * FB: @daniel_freebsd.py
  
pct @vim-taiwan, @TOSSUG, 2011/10/11
