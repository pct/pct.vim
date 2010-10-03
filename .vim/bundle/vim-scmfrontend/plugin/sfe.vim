"=============================================================================
" Copyright (c) 2009-2010 Takeshi NISHIDA
"
" GetLatestVimScripts: 2637 1 :AutoInstall: ScmFrontEnd
"=============================================================================
" LOAD GUARD: {{{1

try
  if !l9#guardScriptLoading(expand('<sfile>:p'), 702, 101, [])
    finish
  endif
catch /E117/
  echoerr '***** L9 library must be installed! *****'
  finish
endtry


" }}}1
"=============================================================================
" GLOBAL FUNCTION: {{{1

let s:statusReports = {}
"
function g:sfe_getStatus()
  return sfe#getStatusReport(sfe#getTargetDir())
endfunction

" }}}1
"=============================================================================
" LOCAL FUNCTION: {{{1

"
function s:initialize()
  "---------------------------------------------------------------------------
  let commandData = [
        \   ['Command'      , 0],
        \   ['CommitFile'   , 1],
        \   ['CommitTracked', 1],
        \   ['CommitAll'    , 1],
        \   ['RecordFile'   , 1],
        \   ['RecordAll'    , 1],
        \   ['Checkout'     , 1],
        \   ['Merge'        , 1],
        \   ['Branch'       , 1],
        \   ['BranchDelete' , 1],
        \   ['Rebase'       , 1],
        \   ['Strip'        , 1],
        \   ['Pull'         , 1],
        \   ['Push'         , 1],
        \   ['DiffFile'     , 0],
        \   ['DiffAll'      , 0],
        \   ['LogFile'      , 0],
        \   ['LogAll'       , 0],
        \   ['AnnotateFile' , 0],
        \   ['Status'       , 0],
        \   ['Grep'         , 0],
        \   ['LoadModified' , 0],
        \   ['LoadAll'      , 0],
        \   ['FindFile'     , 0],
        \ ]
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:sfe_availableScms',
        \ filter(['mercurial', 'git', 'bazaar'], 'sfe#{v:val}#isExecutable()'))
  call l9#defineVariableDefault('g:sfe_mapLeader', '\s')
  call l9#defineVariableDefault('g:sfe_mapLeaderAlternate', '\S')
  call l9#defineVariableDefault('g:sfe_mapKeyCommand', ':')
  call l9#defineVariableDefault('g:sfe_mapKeyCommitFile', 'C')
  call l9#defineVariableDefault('g:sfe_mapKeyCommitTracked', '<C-c>')
  call l9#defineVariableDefault('g:sfe_mapKeyCommitAll', 'c')
  call l9#defineVariableDefault('g:sfe_mapKeyRecordFile', 'E')
  call l9#defineVariableDefault('g:sfe_mapKeyRecordAll', 'e')
  call l9#defineVariableDefault('g:sfe_mapKeyCheckout', 'o')
  call l9#defineVariableDefault('g:sfe_mapKeyMerge', 'm')
  call l9#defineVariableDefault('g:sfe_mapKeyBranch', 'b')
  call l9#defineVariableDefault('g:sfe_mapKeyBranchDelete', 'B')
  call l9#defineVariableDefault('g:sfe_mapKeyRebase', 'r')
  call l9#defineVariableDefault('g:sfe_mapKeyStrip', 't')
  call l9#defineVariableDefault('g:sfe_mapKeyPull', '[')
  call l9#defineVariableDefault('g:sfe_mapKeyPush', ']')
  call l9#defineVariableDefault('g:sfe_mapKeyDiffFile', 'D')
  call l9#defineVariableDefault('g:sfe_mapKeyDiffAll', 'd')
  call l9#defineVariableDefault('g:sfe_mapKeyLogFile', 'L')
  call l9#defineVariableDefault('g:sfe_mapKeyLogAll', 'l')
  call l9#defineVariableDefault('g:sfe_mapKeyAnnotateFile', 'n')
  call l9#defineVariableDefault('g:sfe_mapKeyStatus', 's')
  call l9#defineVariableDefault('g:sfe_mapKeyGrep', 'g')
  call l9#defineVariableDefault('g:sfe_mapKeyLoadModified', '!')
  call l9#defineVariableDefault('g:sfe_mapKeyLoadAll', '<CR>')
  call l9#defineVariableDefault('g:sfe_mapKeyFindFile', 'f')
  call l9#defineVariableDefault('g:sfe_hgLocations', [
        \ 'http://bitbucket.org/<account>/${basename}',
        \ 'ssh://hg@bitbucket.org/<account>/${basename}',])
  call l9#defineVariableDefault('g:sfe_gitLocations', [
        \ 'git://github.com/<account>/${basename}.git', ])
  call l9#defineVariableDefault('g:sfe_bzrLocations', [])
  call l9#defineVariableDefault('g:sfe_hgPullIsFetch', 0)
  call l9#defineVariableDefault('g:sfe_hgLogOption', '-l1000 --style compact')
  call l9#defineVariableDefault('g:sfe_gitLogOption', '-1000 --all --graph --pretty=format:''%h (%ci) %s''')
  call l9#defineVariableDefault('g:sfe_bzrLogOption', '-l1000 --line')
  "---------------------------------------------------------------------------
  for [commandName, confirmingUnsaved] in commandData
    execute printf('command! -bang %s call sfe#launch(%s, len(<q-bang>), sfe#getTargetDir(), %d)',
          \        'Sfe' . commandName, string(commandName), confirmingUnsaved)
  endfor
  "---------------------------------------------------------------------------
  for [leader, bang] in [ [g:sfe_mapLeader, ''], [g:sfe_mapLeaderAlternate, '!'] ]
    execute printf('nnoremap <silent> %s      <Nop>', leader)
    execute printf('nnoremap <silent> %s<Esc> <Nop>', leader)
    for [commandName, confirmingUnsaved] in commandData
      execute printf('nnoremap <silent> %s :%s%s<CR>',
            \        leader . g:sfe_mapKey{commandName},
            \        'Sfe' . commandName,
            \        bang)
    endfor
  endfor
  "---------------------------------------------------------------------------
  augroup SfeGlobal
    autocmd!
    autocmd CursorHold   * call sfe#invalidateStatusReport(sfe#getTargetDir())
    autocmd CursorHoldI  * call sfe#invalidateStatusReport(sfe#getTargetDir())
    "autocmd BufWritePost * call sfe#invalidateStatusReport(sfe#getTargetDir())
  augroup END
  "---------------------------------------------------------------------------
endfunction

" }}}1
"=============================================================================
" INITIALIZATION: {{{1

call s:initialize()

" }}}1
"=============================================================================
" vim: set fdm=marker:
