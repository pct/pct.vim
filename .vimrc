" 按 F5 自動以 !python 來執行現行 script
autocmd BufRead,BufNewFile *.py map <F5> :% w !python<CR>
autocmd BufRead,BufNewFile *.py map <F6> :% w !nosetests<CR>
autocmd BufRead,BufNewFile *.py map <F7> :% w !pyflakes<CR>
autocmd BufRead,BufNewFile *.php map <F5> :% w !php<CR>
autocmd BufRead,BufNewFile *.php map <F6> :% w !php -l<CR>

set guifont=Droid\ Sans\ Mono\ 12
let g:use_zen_complete_tag = 1
let g:user_zen_expandabbr_key = '<c-e>'
let python_highlight_all = 1
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'

call pathogen#runtime_append_all_bundles()

let g:user_zen_settings = {
\  'lang' : 'ja',
\  'html' : {
\    'filters' : 'html',
\    'indentation' : ' '
\  },
\  'perl' : {
\    'indentation' : '  ',
\    'aliases' : {
\      'req' : "require '|'"
\    },
\    'snippets' : {
\      'use' : "use strict\nuse warnings\n\n",
\      'w' : "warn \"${cursor}\";",
\    },
\  },
\  'php' : {
\    'extends' : 'html',
\    'filters' : 'html,c',
\  },
\  'css' : {
\    'filters' : 'fc',
\  },
\  'javascript' : {
\    'snippets' : {
\      'jq' : "$(function() {\n\t${cursor}${child}\n});",
\      'jq:each' : "$.each(arr, function(index, item)\n\t${child}\n});",
\      'fn' : "(function() {\n\t${cursor}\n})();",
\      'tm' : "setTimeout(function() {\n\t${cursor}\n}, 100);",
\    },
\  },
\ 'java' : {
\  'indentation' : '    ',
\  'snippets' : {
\   'main': "public static void main(String[] args) {\n\t|\n}",
\   'println': "System.out.println(\"|\");",
\   'class': "public class | {\n}\n",
\  },
\ },
\}

if version >= 703
  set conceallevel=1
  set concealcursor=nc
  set colorcolumn=+1
  set cinoptions+=L0
  set undofile
  set undodir=~/.vim/undofiles
  if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
  endif
endif

" ==== neocomplcache start ====
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
    
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
set completeopt+=longest
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_disable_auto_complete = 1
inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
" ==== neocomplcache end ====

"let g:acp_behaviorSnipmateLength=1

colorscheme yzlin256
set t_Co=256
set ffs=unix,dos ff=unix

set softtabstop=4
set ttymouse=xterm


" For language complete
autocmd FileType php set dictionary+=~/.vim/dict/php.list
autocmd FileType php set complete+=k

autocmd FileType javascript set dictionary+=~/.vim/dict/jquery.list
autocmd FileType javascript set complete+=k

autocmd FileType python set dictionary+=~/.vim/bundle/pydiction/complete-dict
autocmd FileType python set complete+=k

"設定背景顏色為黑色
set background=dark
"colors darkblue

" 關閉 vi 兼容模式
set nocompatible
" Set mouse
set mouse=a
" 打開語法效果
syntax on
" 依檔名打開語法效果
filetype on
" Open auto write file
set autowrite
" 顯示行號
set number
" Show command line
set showcmd
" 設定tab顯示符號 空白顯示符號
"set lcs=tab:>-,trail:-
" 顯示製表位(^I)和行尾標誌($)
"set list
" 顯示現在的模式
set showmode
" 自動設定標題
set title
set tabstop=4
" show the cursor position all the time
set ruler
" 自動縮排
set autoindent
" 聰明的縮排
set smartindent
" 用空白來當作tab
set expandtab
"沒有備份檔案
set nobackup
" 自動縮排為以二空格為基準
set shiftwidth=4
set smarttab
set fdm=indent
set fdc=4
" 設定自動換行
set wrap
" 尋找時，符合字串會反白表示
set hlsearch
" 加強式尋找功能，在鍵入 patern 時會立即反應移動至目前鍵入之 patern 上
set incsearch
" 底下的command status line為兩行
set cmdheight=2
" 總是顯示資訊
set laststatus=2
" Line highlight 設此是游標整行會標註顏色
set cursorline
" Column highlight 設此是遊標整列會標註顏色
"set cursorcolumn

" 設定狀態列訊息
highlight User1 ctermfg=red
highlight User2 term=underline cterm=underline ctermfg=green
highlight User3 term=underline cterm=underline ctermfg=yellow
"highlight User4 term=underline cterm=underline ctermfg=white
highlight User5 ctermfg=cyan
highlight User6 ctermfg=white

" %1* -> User1's highlight, %2*->User2's highlight
" =   -> Separation point between left and right aligned items.
" <   -> Where to truncate line if too long.  Default is at the start.
set statusline=%4*%<\ %1*[%F]
set statusline+=%4*\ %5*[%{&encoding}, " encoding
set statusline+=%{&fileformat}]%m " file format
set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>

" 設定檔案編碼清單
"set fencs=utf-8,big5,bgk,euc-jp,utf-16le
set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,iso8859-1,euc-jp,utf-16le
" 設定編碼 內部編碼 Terminal編碼
set fenc=utf-8 enc=utf-8 tenc=utf-8
" Syntax Fold
set foldmethod=syntax
" 方便中文重排設定
set formatoptions=mtcql
" 將註解由深藍色變綠色
hi Comment ctermfg=Green

" fn maping
" Save all buffer files
nmap <F1> :wall<CR>
map <F2> :NERDTreeToggle<CR>
" Most Recently Used (MRU) files
map <s-F2> :MRU<CR>
" Tag list
map <F3> :TlistToggle<CR>
" Update file
map <F4> :up<CR>
" Clear last used search pattern
nmap <F5> :let @/=""<CR>
" AutoComple Open or close
imap <F5> <ESC>:AutoComplPopDisable<CR>
imap <s-F5> <ESC>:AutoComplPopEnable<CR>
" vim menu
source $VIMRUNTIME/menu.vim
set wildmenu
set cpo-=<
set wcm=<C-Z>
map <F6> :emenu <C-Z>

"  Buffer Explorer / Browser key
"  '\be' (normal open)  or
"  '\bs' (force horizontal split open)  or
"  '\bv' (force vertical split open) 

"map <C-v> "*p
"map <C-c> "*y
"map <C-y> :! do-you-commit
 
" Comment Mode 也可用bash的key binding
 cmap   <c-a>   <home>
 cmap   <c-e>   <end>
 cnoremap   <c-b>   <left>
 cnoremap   <c-d>   <del>
 cnoremap   <c-f>   <right>
 cnoremap   <c-n>   <down>
 cnoremap   <c-p>   <up>

 cnoremap   <esc><c-b>  <s-left>
 cnoremap   <esc><c-f>  <s-right>
 
" tab config
map tn :tabnext<CR>
map tp :tabprev<CR>
map te :tabnew 
map tc :tabclose<CR>
 
" Normal Mode時,可用tab及shift-Tab做縮排
nmap <tab> v>
nmap <s-tab> v<
" Visual/Select Mode時，也行
vmap <tab> >gv
vmap <s-tab> <gv

" taglist config let Tlist_Use_Right_Window=1 let Tlist_File_Fold_Auto_Close=1 " clever tab completion fun! KeywordComplete() let left = strpart(getline('.'), col('.') - 2, 1) if left =~ "^$" return "\<Tab>" elseif left =~ ' $' return "\<Tab>" else return "\<C-N>" endfun inoremap <silent> <Tab> <C-R>=KeywordComplete()
 
fun! OmniComplete()
    let left = strpart(getline('.'), col('.') - 2, 1)
    if left =~ "^$"
        return ""
    elseif left =~ ' $'
        return ""
    else
        return "\<C-x>\<C-o>"
endfun
inoremap <silent> <S-Tab> <C-R>=OmniComplete()
 
" turn on Omni completion
autocmd FileType c set ofu=ccomplete#Complete
autocmd FileType php set ofu=phpcomplete#CompletePHP
autocmd FileType python set ofu=pythoncomplete#Complete
autocmd FileType javascript set ofu=javascriptcomplete#CompleteJS
autocmd FileType html set ofu=htmlcomplete#CompleteTags
autocmd FileType css set ofu=csscomplete#CompleteCSS
autocmd FileType xml set ofu=xmlcomplete#CompleteTags
 
" c autotidy by indent
autocmd FileType c :set equalprg=indent

" 設定 modeline
" vim: ts=2:

" === orig settings ===
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
