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

"
function sfe#launch(commandName, anotherScm, cwd, confirmingUnsaved)
  let impl = s:createImplementor(a:anotherScm, a:cwd, 1)
  if !impl.isValid() || !s:warnIfUnsavedBufferExist(a:confirmingUnsaved)
    return
  endif
  let methodName = tolower(a:commandName[0]) . a:commandName[1:]
  call impl[methodName]()
  call sfe#invalidateStatusReport(a:cwd)
endfunction

" gets target file path associated with current buffer
function sfe#getTargetFile()
  return (exists('b:sfe_targetFile') ? b:sfe_targetFile : expand('%:p'))
endfunction

"
function sfe#getTargetDir()
  let file = sfe#getTargetFile()
  return (file =~ '\S' ? fnamemodify(file, ':h') : fnamemodify(getcwd(), ':p:h'))
endfunction

"
let s:statusReports = {}

"
function sfe#getStatusReport(cwd)
  let dir = sfe#getTargetDir()
  if !exists('s:statusReports[a:cwd]')
    let impls = s:createAvailableImplementors(a:cwd)
    let s:statusReports[a:cwd] = join(map(impls, 'v:val.getStatusReport()'), ',')
  endif
  return s:statusReports[a:cwd]
endfunction

"
function sfe#invalidateStatusReport(cwd)
  if exists('s:statusReports[a:cwd]')
    unlet s:statusReports[a:cwd]
  endif
endfunction

" echoes and save in the message-history.
function sfe#echo(msg)
  call l9#echoHl('None', a:msg, '[sfe] ', 0)
endfunction

" echoes and save in the message-history.
function sfe#echoMessage(msg)
  call l9#echoHl('None', a:msg, '[sfe] ', 1)
endfunction

" echoes and save in the message-history.
function sfe#echoWarning(msg)
  call l9#echoHl('WarningMsg', a:msg, '[sfe] ', 1)
endfunction

" echoes and save in the message-history.
function sfe#echoError(msg)
  call l9#echoHl('ErrorMsg', a:msg, '[sfe] ', 1)
endfunction

" if not found, returns ''
function sfe#findParentDirIncludingDir(dirFrom, dirIncluded)
  let dir = fnamemodify(a:dirFrom, ':p') . '.'
  while dir != fnamemodify(dir, ':h')
    let dir = fnamemodify(dir, ':h')
    if isdirectory(fnamemodify(dir, ':p') . a:dirIncluded)
      return dir
    endif
  endwhile
  return ''
endfunction

"
function sfe#escapeForShell(str)
  return substitute(shellescape(a:str), "\\\\\n", "\n", "g")
endfunction

"
function sfe#makeQuickFixEntry(str, indexFile, indexLineNum, indexText, pathPrefix)
  let tokens = split(a:str, ':', 1)
  return  {
        \   'filename' : a:pathPrefix . tokens[a:indexFile],
        \   'lnum' : tokens[a:indexLineNum],
        \   'text' : join(tokens[a:indexText : ], ':'),
        \ }
endfunction

" }}}1
"=============================================================================
" LOCAL FUNCTIONS/VARIABLES {{{1

"
function s:formatCommitBufferLines(nameScm, dirRoot, nameBranch, linesStatus, linesDiff)
  let s:TEXT_FORMAT_WIDTH = 78
  return  [''] +
        \ [ repeat('#', s:TEXT_FORMAT_WIDTH) ] +
        \ [ '# SCM: ' . a:nameScm ] +
        \ [ '# Root: ' . a:dirRoot ] +
        \ [ '# Branch: ' . a:nameBranch ] +
        \ map(a:linesStatus, '"# " . v:val') +
        \ [ repeat('#', s:TEXT_FORMAT_WIDTH) ] +
        \ map(a:linesDiff, '"#|" . v:val')
endfunction

" associates target file with current buffer
function s:associateTargetFile(path)
  let b:sfe_targetFile = a:path
endfunction

"
function s:openFileInNewTabpage(file)
  let bufnr = bufnr('^' . a:file . '$')
  if bufnr > -1
    execute ':tab :' . bufnr . 'sbuffer'
  else
    execute ':tabedit ' . fnameescape(a:file)
  endif
endfunction

" 
function s:createAvailableImplementors(cwd)
  return filter(map(copy(g:sfe_availableScms),
        \           'extend(copy(s:implementorBase), sfe#{v:val}#createImplementor(a:cwd))'),
        \       'v:val.isValid()')
endfunction


" 
function s:createImplementor(anotherScm, cwd, echoingError)
  let impls = s:createAvailableImplementors(a:cwd)
  if !empty(impls)
    return impls[a:anotherScm ? -1 : 0]
  endif
  if a:echoingError
    call sfe#echoError('There is no available repository: ' . sfe#escapeForShell(a:cwd))
  endif
  return s:implementorBase
endfunction

"
function s:isModifiedBuffer(bufnr)
  return buflisted(a:bufnr) && getbufvar(a:bufnr, '&modified')
endfunction

"
function s:warnIfUnsavedBufferExist(confirming)
  if empty(filter(range(1, bufnr('$')), 's:isModifiedBuffer(v:val)'))
    return 1
  endif
  if !a:confirming
    call sfe#echoWarning('Unsaved buffers exist.')
    return 1
  endif
  return l9#inputHl('WarningMsg', "[sfe] Unsaved buffers exist. Continue? (Y/N) :") ==? 'Y'
endfunction

" }}}1
"=============================================================================
" s:implementorBase {{{1

let s:implementorBase = {}

"
function s:implementorBase.isValid()
  return 0
endfunction

"
function s:implementorBase.command()
  call sfe#echo('Command: ' . self.getRepositoryReport())
  let arg = l9#inputHl('Question', '[sfe] ' . self.getCommandHeading() . ' : ')
  if arg == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  try
    call self.executeByShell([arg])
    checktime
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('Command failed')
  endtry
endfunction

"
function s:implementorBase.commitFile()
  call sfe#echo('CommitFile: ' . self.getRepositoryReport())
  let fileTarget = sfe#getTargetFile()
  if !filereadable(fileTarget)
    call sfe#echoError('Cannot read the file: ' .
          \               sfe#escapeForShell(fileTarget))
    return
  endif
  let statuses = self.getStatusesFile(fileTarget)
  if empty(statuses)
    call sfe#echo('No changes.')
    return
  endif
  try
    let linesDiff = self.getDiffFileLines(self.getRevisionParent(), fileTarget)
  catch
    let linesDiff = []
  endtry
  let lines = s:formatCommitBufferLines(
        \ self.getScmName(), self.dirRoot,
        \ self.getBranchCurrent(), statuses, linesDiff)
  let fileTarget = sfe#getTargetFile()
  call l9#tempbuffer#openWritable(self.formatTempBufferName('CommitFile'),
        \                         'sfe-commit', lines, 0, 0, 0,
        \                         s:commitBufferLister.new(self, 'CommitFile'))
  call s:associateTargetFile(fileTarget)
endfunction


"
function s:implementorBase.commitTracked()
  call sfe#echo('CommitTracked: ' . self.getRepositoryReport())
  let statuses = self.getStatusesTracked()
  if empty(statuses)
    call sfe#echo('No changes.')
    return
  endif
  try
    let linesDiff = self.getDiffAllLines(self.getRevisionParent())
  catch
    let linesDiff = []
  endtry
  let lines = s:formatCommitBufferLines(
        \ self.getScmName(), self.dirRoot,
        \ self.getBranchCurrent(), statuses, linesDiff)
  let fileTarget = sfe#getTargetFile()
  call l9#tempbuffer#openWritable(self.formatTempBufferName('CommitTracked'),
        \                         'sfe-commit', lines, 0, 0, 0,
        \                         s:commitBufferLister.new(self, 'CommitTracked'))
  call s:associateTargetFile(fileTarget)
endfunction

"
function s:implementorBase.commitAll()
  call sfe#echo('CommitAll: ' . self.getRepositoryReport())
  let statuses = self.getStatusesAll()
  if empty(statuses)
    call sfe#echo('No changes.')
    return
  endif
  try
    let linesDiff = self.getDiffAllLines(self.getRevisionParent())
  catch
    let linesDiff = []
  endtry
  let lines = s:formatCommitBufferLines(
        \ self.getScmName(), self.dirRoot,
        \ self.getBranchCurrent(), statuses, linesDiff)
  let fileTarget = sfe#getTargetFile()
  call l9#tempbuffer#openWritable(self.formatTempBufferName('CommitAll'),
        \                         'sfe-commit', lines, 0, 0, 0,
        \                         s:commitBufferLister.new(self, 'CommitAll'))
  call s:associateTargetFile(fileTarget)
endfunction

"
function s:implementorBase.recordFile()
  call sfe#echo('RecordFile: ' . self.getRepositoryReport())
  let fileTarget = sfe#getTargetFile()
  if !filereadable(fileTarget)
    call sfe#echoError('Cannot read the file: ' .
          \               sfe#escapeForShell(fileTarget))
    return
  endif
  let statuses = self.getStatusesFile(fileTarget)
  if empty(statuses)
    call sfe#echo('No changes.')
    return
  endif
  try
    let linesDiff = self.getDiffFileLines(self.getRevisionParent(), fileTarget)
  catch
    let linesDiff = []
  endtry
  let lines = s:formatCommitBufferLines(
        \ self.getScmName(), self.dirRoot,
        \ self.getBranchCurrent(), statuses, linesDiff)
  let fileTarget = sfe#getTargetFile()
  call l9#tempbuffer#openWritable(self.formatTempBufferName('RecordFile'),
        \                         'sfe-commit', lines, 0, 0, 0,
        \                         s:recordBufferLister.new(self, 'RecordFile'))
  call s:associateTargetFile(fileTarget)
endfunction

"
function s:implementorBase.recordAll()
  call sfe#echo('RecordAll: ' . self.getRepositoryReport())
  let statuses = self.getStatusesAll()
  if empty(statuses)
    call sfe#echo('No changes.')
    return
  endif
  try
    let linesDiff = self.getDiffAllLines(self.getRevisionParent())
  catch
    let linesDiff = []
  endtry
  let lines = s:formatCommitBufferLines(
        \ self.getScmName(), self.dirRoot,
        \ self.getBranchCurrent(), statuses, linesDiff)
  let fileTarget = sfe#getTargetFile()
  call l9#tempbuffer#openWritable(self.formatTempBufferName('RecordAll'),
        \                         'sfe-commit', lines, 0, 0, 0,
        \                         s:recordBufferLister.new(self, 'RecordAll'))
  call s:associateTargetFile(fileTarget)
endfunction


"
function s:implementorBase.checkout()
  call sfe#echo('Checkout: ' . self.getRepositoryReport())
  if !exists('self.executeCheckout')
    call sfe#echoError('This command is not supported.')
    return
  endif
  let revision = l9#inputHl('Question', '[sfe] Revision to checkout: ',
        \                            self.getBranchDefault(),
        \                            self.getRevisions())
  if revision == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  try
    call self.executeCheckout(revision)
    call sfe#echoMessage('-- Checkout completed --')
    checktime
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('Checkout failed')
  endtry
endfunction

"
function s:implementorBase.merge()
  call sfe#echo('Merge: ' . self.getRepositoryReport())
  if !exists('self.executeMerge')
    call sfe#echoError('This command is not supported.')
    return
  endif
  let revision = l9#inputHl('Question', '[sfe] Merge with: ', '',
        \                            self.getBranchesNoncurrent())
  if revision == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  try
    call self.executeMerge(revision)
    call sfe#echoMessage('-- Merge completed --')
    checktime
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('Merge failed')
  endtry
endfunction

"
function s:implementorBase.branch()
  call sfe#echo('Branch: ' . self.getRepositoryReport())
  if !exists('self.executeBranch')
    call sfe#echoError('This command is not supported.')
    return
  endif
  let branch = l9#inputHl('Question', '[sfe] New branch name: ')
  if branch == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  try
    call self.executeBranch(branch)
    call sfe#echoMessage('-- Branch completed --')
    checktime
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('Branch failed')
  endtry
endfunction

"
function s:implementorBase.branchDelete()
  call sfe#echo('BranchDelete: ' . self.getRepositoryReport())
  if !exists('self.executeBranchDelete')
    call sfe#echoError('This command is not supported.')
    return
  endif
  let branch = l9#inputHl('Question', '[sfe] branch name to delete: ', '',
        \                          self.getBranchesNoncurrent())
  if branch == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  try
    call self.executeBranchDelete(branch)
    call sfe#echoMessage('-- BranchDelete completed --')
    checktime
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('BranchDelete failed')
  endtry
endfunction

"
function s:implementorBase.rebase()
  call sfe#echo('Rebase: ' . self.getRepositoryReport())
  if !exists('self.executeRebase')
    call sfe#echoError('This command is not supported.')
    return
  endif
  let branch = l9#inputHl('Question', '[sfe] Rebase current branch onto: ',
        \                          self.getBranchDefault(),
        \                          self.getRevisions())
  if branch == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  try
    call self.executeRebase(branch)
    call sfe#echoMessage('-- Rebase completed --')
    checktime
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('Rebase failed')
  endtry
endfunction

"
function s:implementorBase.strip()
  call sfe#echo('Strip: ' . self.getRepositoryReport())
  if !exists('self.executeStrip')
    call sfe#echoError('This command is not supported.')
    return
  endif
  let revision = l9#inputHl('Question', '[sfe] Revision to strip: ',
        \                          self.getRevisionParent(),
        \                          self.getRevisions())
  if revision == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  try
    call self.executeStrip(revision)
    call sfe#echoMessage('-- Strip completed --')
    checktime
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('Strip failed')
  endtry
endfunction

"
function s:implementorBase.pull()
  call sfe#echo('Pull: ' . self.getRepositoryReport())
  let locations = map(self.getLocations(), 'self.formatLocation(v:val)')
  let location = l9#inputHl('Question', '[sfe] Pull from: ', '', locations)
  if location == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  try
    call self.executePull(location)
    call sfe#echoMessage('-- Pull completed --')
    checktime
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('Pull failed')
  endtry
endfunction

"
function s:implementorBase.push()
  call sfe#echo('Push: ' . self.getRepositoryReport())
  let locations = map(self.getLocations(), 'self.formatLocation(v:val)')
  let location = l9#inputHl('Question', '[sfe] Push to: ', '', locations)
  if location == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  try
    call self.executePush(location)
    call sfe#echoMessage('-- Push completed --')
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('Push failed')
  endtry
endfunction

"
function s:implementorBase.diffFile()
  let fileTarget = sfe#getTargetFile()
  if !filereadable(fileTarget)
    call sfe#echoError('Cannot read the file: ' .
          \               sfe#escapeForShell(fileTarget))
    return
  endif
  call sfe#echo('DiffFile: ' . self.getRepositoryReport())
  let revision = l9#inputHl('Question', '[sfe] Compare with: ',
        \                            self.getRevisionParent(),
        \                            self.getRevisions())
  if revision == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  try
    let lines = self.getCatFileLines(revision, fileTarget)
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('DiffFile failed')
    return
  endtry
  call s:openFileInNewTabpage(fileTarget)
  setlocal nowrap
  call l9#tempbuffer#openReadOnly(self.formatTempBufferName('DiffFile'),
        \                         &l:filetype, lines, 0, 1, 0, {})
  call s:associateTargetFile(fileTarget)
  diffthis
  wincmd p
  diffthis
endfunction

"
function s:implementorBase.diffAll()
  call sfe#echo('DiffAll: ' . self.getRepositoryReport())
  let revision = l9#inputHl('Question', '[sfe] Compare with: ',
        \                            self.getRevisionParent(),
        \                            self.getRevisions())
  if revision == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  let lines = self.getDiffAllLines(revision)
  if len(lines) == 0
    call sfe#echo('No changes.')
    return
  endif
  let fileTarget = sfe#getTargetFile()
  call l9#tempbuffer#openReadOnly(self.formatTempBufferName('DiffAll'),
        \                         'diff', lines, 0, 0, 0, {})
  call s:associateTargetFile(fileTarget)
endfunction

"
function s:implementorBase.logFile()
  let fileTarget = sfe#getTargetFile()
  if !filereadable(fileTarget)
    call sfe#echoError('Cannot read the file: ' .
          \               sfe#escapeForShell(fileTarget))
    return
  endif
  let lines = self.getLogFileLines(fileTarget)
  let fileTarget = sfe#getTargetFile()
  call l9#tempbuffer#openReadOnly(self.formatTempBufferName('LogFile'),
        \                         'sfe-log', lines, 0, 0, 0, {})
  call s:associateTargetFile(fileTarget)
endfunction

"
function s:implementorBase.logAll()
  let lines = self.getLogAllLines()
  let fileTarget = sfe#getTargetFile()
  call l9#tempbuffer#openReadOnly(self.formatTempBufferName('LogAll'),
        \                         'sfe-log', lines, 0, 0, 0, {})
  call s:associateTargetFile(fileTarget)
endfunction

"
function s:implementorBase.annotateFile()
  let fileTarget = sfe#getTargetFile()
  if !filereadable(fileTarget)
    call sfe#echoError('Cannot read the file: ' .
          \               sfe#escapeForShell(fileTarget))
    return
  endif
  call sfe#echo('AnnotateFile: ' . self.getRepositoryReport())
  let revision = l9#inputHl('Question', '[sfe] Revision to annotate: ',
        \                            self.getRevisionParent(),
        \                            self.getRevisions())
  if revision == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  let lines = self.getAnnotateFileLines(revision, fileTarget)
  let fileTarget = sfe#getTargetFile()
  call l9#tempbuffer#openReadOnly(self.formatTempBufferName('AnnotateFile'),
        \                         'sfe-annotate', lines, 0, 0, 0, {})
  call s:associateTargetFile(fileTarget)
endfunction

"
function s:implementorBase.status()
  call sfe#echo(['Status: ' . self.getRepositoryReport()] +
        \          self.getStatusesAll())
endfunction

"
function s:implementorBase.grep()
  call sfe#echo('Grep: ' . self.getRepositoryReport())
  if !exists('self.getGrepQuickFixes')
    call sfe#echoError('This command is not supported.')
    return
  endif
  let pattern = l9#inputHl('Question', '[sfe] Search pattern: ')
  if pattern == ''
    call sfe#echoWarning('Canceled')
    return
  endif
  call setqflist(self.getGrepQuickFixes(pattern))
  cope
endfunction

"
function s:implementorBase.loadModified()
  let files = self.getLsModified()
  call l9#deleteAllBuffersExcept(files)
  call l9#loadFilesToBuffers(files)
endfunction

"
function s:implementorBase.loadAll()
  let files = self.getLsAll()
  call l9#deleteAllBuffersExcept(files)
  call l9#loadFilesToBuffers(files)
endfunction

"
function s:implementorBase.findFile()
  call fuf#givenfile#launch('', 0, '>sfe:FindFile>',
        \ map(self.getLsAll(), 'fnamemodify(v:val, ":~:.")'))
endfunction

" throws "sfe:execute\n..." if shell command had an error.
function s:implementorBase.execute(args)
  let error = 0
  let cmd = join([self.getCommandHeading()] + a:args, ' ')
  try
    cd `=self.dirRoot`
    let out = system(cmd)
  catch
    let error = 1
    let out = v:exception
  finally
    cd -
  endtry
  if error || v:shell_error
    throw printf("sfe:execute: Command error (%d)\n%s\n%s",
          \      v:shell_error, cmd, out)
  endif
  return out
endfunction

" throws "sfe:execute\n..." if shell command had an error.
function s:implementorBase.executeByShell(args)
  let cmd = join([self.getCommandHeading()] + a:args, ' ')
  try
    cd `=self.dirRoot`
    execute '!' . cmd
  finally
    cd -
  endtry
  if v:shell_error
    throw printf("sfe:execute: Command error (%d)\n%s", v:shell_error, cmd)
  endif
endfunction

"
function s:implementorBase.formatTempBufferName(cmd)
  return '[sfe-' . a:cmd . '-' . self.getScmName() . ']'
endfunction

"
function s:implementorBase.formatLocation(location)
  return substitute(a:location, '${basename}',
        \           fnamemodify(self.dirRoot, ':p:h:t'), 'g')
endfunction

"
function s:implementorBase.getBranchesNoncurrent()
  let branchCurrent = self.getBranchCurrent()
  return filter(self.getBranches(), 'v:val !=# branchCurrent')
endfunction

"
function s:implementorBase.getRepositoryReport()
  return printf('%s - %s - %s',
        \       self.getScmName(), self.dirRoot, self.getBranchCurrent())
endfunction

"
function s:implementorBase.getStatusReport()
  return self.getCommandName() . ':' . self.getBranchCurrent()
endfunction

" }}}1
"=============================================================================
" s:commitBufferLister {{{1

"
let s:commitBufferLister = {}

"
function s:commitBufferLister.new(impl, mode)
  let listener = copy(self)
  let listener.impl = a:impl
  let listener.mode = a:mode
  return listener
endfunction

"
function s:commitBufferLister.onWrite(lines)
  let msg = join(filter(a:lines, 'v:val !~ "^#"'), "\n")
  if msg !~ '\S'
    call sfe#echoWarning('Enter commit massage')
    return 0
  endif
  try
    if self.mode == 'CommitFile'
      call self.impl.executeCommitFile(msg, sfe#getTargetFile())
    elseif self.mode == 'CommitTracked'
      call self.impl.executeCommitTracked(msg)
    elseif self.mode == 'CommitAll'
      call self.impl.executeCommitAll(msg)
    else
    endif
    call sfe#echoMessage('-- Record completed --')
    call sfe#invalidateStatusReport(sfe#getTargetDir())
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('Record failed')
  endtry
  return 1
endfunction

"
function s:commitBufferLister.onClose(written)
  if !a:written
    call sfe#echoWarning('Commit canceled')
  endif
endfunction

" }}}1
"=============================================================================
" s:recordBufferLister {{{1

"
let s:recordBufferLister = {}

"
function s:recordBufferLister.new(impl, mode)
  let listener = copy(self)
  let listener.impl = a:impl
  let listener.mode = a:mode
  return listener
endfunction

"
function s:recordBufferLister.onWrite(lines)
  let msg = join(filter(a:lines, 'v:val !~ "^#"'), "\n")
  if msg !~ '\S'
    call sfe#echoWarning('Enter commit massage')
    return 0
  endif
  try
    if self.mode == 'RecordFile'
      call self.impl.executeRecordFile(msg, sfe#getTargetFile())
    elseif self.mode == 'RecordAll'
      call self.impl.executeRecordAll(msg)
    else
    endif
    call sfe#echoMessage('-- Record completed --')
    call sfe#invalidateStatusReport(sfe#getTargetDir())
  catch /^sfe:execute:.*/
    call sfe#echoMessage(split(v:exception, "\n")[1:])
    call sfe#echoError('Record failed')
  endtry
  return 1
endfunction

"
function s:recordBufferLister.onClose(written)
  if !a:written
    call sfe#echoWarning('Record canceled')
  endif
endfunction

" }}}1
"=============================================================================
" vim: set fdm=marker:
