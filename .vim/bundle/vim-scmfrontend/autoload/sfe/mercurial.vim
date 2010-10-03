"=============================================================================
" Copyright (c) 2009-2010 Takeshi NISHIDA
"
"=============================================================================
" LOAD GUARD {{{1

if !l9#guardScriptLoading(expand('<sfile>:p'), 0, 0, [])
  finish
endif

" }}}1
"=============================================================================
" GLOBAL FUNCTIONS {{{1

" if a:cwd is not in repository, returns {}
function sfe#mercurial#createImplementor(cwd)
  let impl = copy(s:implementor)
  let impl.dirRoot =  sfe#findParentDirIncludingDir(a:cwd, '.hg')
  return (impl.dirRoot == '' ? {} : impl)
endfunction

"
function sfe#mercurial#isExecutable()
  return executable(s:implementor.getCommandName())
endfunction

" }}}1
"=============================================================================
" LOCAL FUNCTIONS/VARIABLES {{{1

"
function s:formatStatusLine(line)
  for [pattern, subst] in [
        \   ['^?\s\+', '[New]      '],
        \   ['^!\s\+', '[Missing]  '],
        \   ['^M\s\+', '[Modified] '],
        \   ['^A\s\+', '[Added]    '],
        \   ['^R\s\+', '[Removed]  '],
        \   ['^C\s\+', '[Clean]    '],
        \   ['^I\s\+', '[Ignored]  '],
        \ ]
    if a:line =~# pattern
      return substitute(a:line, pattern, subst, 'g')
    endif
  endfor
  return a:line
endfunction

"
function s:formatAnnotateLine(line, revNew)
  let strDst = '||'
  if a:line =~ '\<0\s\+\d\d\d\d-\d\d-\d\d:'
    let strDst = '|-'
  elseif matchstr(a:line, '\<\d\+\ze\s\+\d\d\d\d-\d\d-\d\d:') == a:revNew
    let strDst = '|+'
  endif
  return substitute(a:line, ': ', strDst, '')
endfunction

" }}}1
"=============================================================================
" implementor {{{1

let s:implementor = {}

"
function s:implementor.isValid()
  return 1
endfunction

"
function s:implementor.executeCommitFile(msg, file)
  call sfe#echoMessage(self.execute(['commit -v -m', sfe#escapeForShell(a:msg), sfe#escapeForShell(a:file)]))
endfunction

"
function s:implementor.executeCommitTracked(msg)
  call sfe#echoMessage(self.execute(['commit -v -m', sfe#escapeForShell(a:msg)]))
endfunction

"
function s:implementor.executeCommitAll(msg)
  call sfe#echoMessage(self.execute(['commit -v -m', sfe#escapeForShell(a:msg), '-A']))
endfunction

"
function s:implementor.executeRecordFile(msg, file)
  call self.executeByShell(['record -v -m', sfe#escapeForShell(a:msg), sfe#escapeForShell(a:file)])
endfunction

"
function s:implementor.executeRecordAll(msg)
  call self.executeByShell(['record -v -m', sfe#escapeForShell(a:msg), '-A'])
endfunction

"
function s:implementor.executeCheckout(revision)
  call sfe#echoMessage(self.execute(['update -v -r', sfe#escapeForShell(a:revision)]))
endfunction

"
function s:implementor.executeMerge(revision)
  call self.executeByShell(['merge -v -r', sfe#escapeForShell(a:revision)])
endfunction

"
function s:implementor.executeBranch(branch)
  call sfe#echoMessage(self.execute(['branch -v', sfe#escapeForShell(a:branch)]))
endfunction

"
"function s:implementor.executeBranchDelete(branch)
"endfunction

"
function s:implementor.executeRebase(branch)
  call sfe#echoMessage(self.execute(['rebase -v --keepbranches -b . -d', sfe#escapeForShell(a:branch)]))
endfunction


function s:implementor.executeStrip(revision)
  call sfe#echoMessage(self.execute(['strip -v', sfe#escapeForShell(a:revision)]))
endfunction

"
function s:implementor.executePull(location)
  let cmd = (g:sfe_hgPullIsFetch ? 'fetch' : 'pull')
  call self.executeByShell([cmd, sfe#escapeForShell(a:location)])
endfunction

"
function s:implementor.executePush(location)
  call self.executeByShell(['push', sfe#escapeForShell(a:location)])
endfunction

"
function s:implementor.getCommandHeading()
  return 'hg'
endfunction

"
function s:implementor.getCatFileLines(revision, file)
  return split(self.execute(['cat -r', sfe#escapeForShell(a:revision),
        \                    sfe#escapeForShell(a:file)]), "\n")
endfunction

"
function s:implementor.getTags()
  return map(split(self.execute(['tags']), "\n"), 'matchstr(v:val, ''^\S*'')')
endfunction

"
function s:implementor.getBranchCurrent()
  return matchstr(self.execute(['branch']), "^[^\n]*")
endfunction

"
function s:implementor.getBranches()
  return map(split(self.execute(['branches -a']), "\n"), 'matchstr(v:val, ''^\S*'')')
endfunction

"
function s:implementor.getDiffFileLines(revision, file)
  return split(self.execute(['diff -r', sfe#escapeForShell(a:revision),
        \                     sfe#escapeForShell(a:file)]), "\n")
endfunction

"
function s:implementor.getDiffAllLines(revision)
  return split(self.execute(['diff -r', sfe#escapeForShell(a:revision)]), "\n")
endfunction

"
function s:implementor.getLogFileLines(file)
  try
    return split(self.execute(['glog', g:sfe_hgLogOption,
          \                    sfe#escapeForShell(a:file)]), "\n")
  catch /^sfe:execute:.*/
    return ['(To show a revision graph, enable graphlog extension.)', ''] +
          \ split(self.execute(['log', g:sfe_hgLogOption,
          \                     sfe#escapeForShell(a:file)]), "\n")
  endtry
endfunction

"
function s:implementor.getLogAllLines()
  try
    return split(self.execute(['glog', g:sfe_hgLogOption]), "\n")
  catch /^sfe:execute:.*/
    return ['(To show a revision graph, enable graphlog extension.)', ''] +
          \ split(self.execute(['log', g:sfe_hgLogOption]), "\n")
  endtry
endfunction

"
function s:implementor.getAnnotateFileLines(revision, file)
  let revNormal = self.normalizeRevision(a:revision)
  " NOTE: -f option shows filename.
  let cmds = ['annotate -nudq -r', revNormal,
        \     sfe#escapeForShell(a:file)]
  return map(split(self.execute(cmds), "\n"),
        \    's:formatAnnotateLine(v:val, revNormal)')
endfunction

"
function s:implementor.getStatusesFile(file)
  let cmds = ['status', sfe#escapeForShell(a:file)]
  return map(split(self.execute(cmds), "\n"), 's:formatStatusLine(v:val)')
endfunction

"
function s:implementor.getStatusesTracked()
  return map(split(self.execute(['status -mar']), "\n"), 's:formatStatusLine(v:val)')
endfunction

"
function s:implementor.getStatusesAll()
  return map(split(self.execute(['status']), "\n"), 's:formatStatusLine(v:val)')
endfunction

"
function s:implementor.getGrepQuickFixes(pattern)
  try
    let pathPrefix = fnamemodify(self.dirRoot, ":p:.")
    let cmds = ['grep -n', sfe#escapeForShell(a:pattern)]
    return map(split(self.execute(cmds), "\n"),
          \    'sfe#makeQuickFixEntry(v:val, 0, 2, 3, pathPrefix)')
  catch /^sfe:execute:.*/
    " if matching lines are not found, shell status isn't zero.
    if len(split(v:exception, "\n")) > 2
      throw v:exception
    endif
    return []
  endtry
endfunction

"
function s:implementor.getLsModified()
  return map(split(self.execute(['status -mn']), "\n"),
        \    'fnamemodify(self.dirRoot, ":p") . v:val')
endfunction

"
function s:implementor.getLsAll()
  return split(self.execute(['locate -f']), "\n")
endfunction

"
function s:implementor.getScmName()
  return 'Mercurial'
endfunction

"
function s:implementor.getCommandName()
  return 'hg'
endfunction

"
function s:implementor.getRevisionParent()
  return '.'
endfunction

"
function s:implementor.getRevisions()
  return ['.', 'null',] + self.getTags() + self.getBranches()
endfunction

"
function s:implementor.normalizeRevision(revision)
  return self.execute(['log --template "{rev}" -r',
        \              sfe#escapeForShell(a:revision)])
endfunction

"
function s:implementor.getBranchDefault()
  return 'default'
endfunction

"
function s:implementor.getLocations()
  return copy(g:sfe_hgLocations) +
        \ map(split(self.execute(['paths']), "\n"),
        \     'matchstr(v:val, ''^[^[:space:]=]\+'')')
endfunction

" }}}1
"=============================================================================
" vim: set fdm=marker:
