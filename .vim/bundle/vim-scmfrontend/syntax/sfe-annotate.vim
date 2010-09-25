"=============================================================================
" Copyright (c) 2009-2010 Takeshi NISHIDA
"
"=============================================================================

if exists("b:current_syntax")
  finish
endif

runtime! syntax/diff.vim

syn match sfeAnnotateInfo       "^[^|]*"
syn match sfeAnnotateSeparator  "|."
syn match sfeAnnotateLineNormal "||.*" contains=sfeAnnotateSeparator
syn match sfeAnnotateLineOld    "|-.*" contains=sfeAnnotateSeparator
syn match sfeAnnotateLineNew    "|+.*" contains=sfeAnnotateSeparator

" 
hi def link sfeAnnotateInfo       Statement
hi def link sfeAnnotateSeparator  Ignore
hi def link sfeAnnotateLineNormal Normal
hi def link sfeAnnotateLineOld    Special
hi def link sfeAnnotateLineNew    Identifier

let b:current_syntax = "sfe-annotate"

"=============================================================================
" vim: set fdm=marker:

