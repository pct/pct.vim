"=============================================================================
" Copyright (c) 2009-2010 Takeshi NISHIDA
"
"=============================================================================

if exists("b:current_syntax")
  finish
endif

runtime! syntax/diff.vim

syn match sfeCommitComment        "^#.*"
syn match sfeCommitSummary        "^# SCM:.*"        contains=sfeCommitComment
syn match sfeCommitSummary        "^# Root:.*"       contains=sfeCommitComment
syn match sfeCommitSummary        "^# Branch:.*"     contains=sfeCommitComment
syn match sfeCommitStatus         "^# \[[^]]*].*"    contains=sfeCommitComment
syn match sfeCommitStatusNew      "^# \[New].*"      contains=sfeCommitComment
syn match sfeCommitStatusMissing  "^# \[Missing].*"  contains=sfeCommitComment
syn match sfeCommitStatusModified "^# \[Modified].*" contains=sfeCommitComment
syn match sfeCommitDiffNormal     "^#|.*"            contains=sfeCommitComment
syn match sfeCommitDiffRemoved    "^#|-.*"           contains=sfeCommitComment
syn match sfeCommitDiffAdded      "^#|+.*"           contains=sfeCommitComment
syn match sfeCommitDiffFile       "^#|diff.*"        contains=sfeCommitComment
syn match sfeCommitDiffFile       "^#|+++ .*"        contains=sfeCommitComment
syn match sfeCommitDiffFile       "^#|--- .*"        contains=sfeCommitComment
syn match sfeCommitDiffLine       "^#|@@.*"          contains=sfeCommitComment
syn match sfeCommitComment        "^#[ |]"           contained

" 
hi def link sfeCommitComment        Comment
hi def link sfeCommitSummary        Title
hi def link sfeCommitStatus         Constant
hi def link sfeCommitStatusNew      Identifier
hi def link sfeCommitStatusMissing  Special
hi def link sfeCommitStatusModified PreProc
hi def link sfeCommitDiffNormal     Normal
hi def link sfeCommitDiffFile       diffFile
hi def link sfeCommitDiffRemoved    diffRemoved
hi def link sfeCommitDiffAdded      diffAdded
hi def link sfeCommitDiffLine       diffLine

let b:current_syntax = "sfe-commit"

"=============================================================================
" vim: set fdm=marker:

