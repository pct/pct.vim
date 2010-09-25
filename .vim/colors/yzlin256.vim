" Vim color file
" Name:       yzlin256.vim
" Maintainer: Y.Z. Lin <yzlin1985@gmail.com>

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let colors_name = "yzlin256"

if has("gui_running")
    hi Normal         gui=NONE   guifg=#cfbfad   guibg=#000000

    hi IncSearch      gui=BOLD   guifg=#303030   guibg=#cd8b60
    hi Search         gui=NONE   guifg=#303030   guibg=#cd8b60
    hi ErrorMsg       gui=BOLD   guifg=#ffffff   guibg=#ce4e4e
    hi WarningMsg     gui=BOLD   guifg=#ffffff   guibg=#ce8e4e
    hi ModeMsg        gui=BOLD   guifg=#7e7eae   guibg=NONE
    hi MoreMsg        gui=BOLD   guifg=#7e7eae   guibg=NONE
    hi Question       gui=BOLD   guifg=#ffcd00   guibg=NONE

    hi StatusLine     gui=BOLD   guifg=#b9b9b9   guibg=#3e3e5e
    hi User1          gui=BOLD   guifg=#00ff8b   guibg=#3e3e5e
    hi User2          gui=BOLD   guifg=#7070a0   guibg=#3e3e5e
    hi StatusLineNC   gui=NONE   guifg=#b9b9b9   guibg=#3e3e5e
    hi VertSplit      gui=NONE   guifg=#b9b9b9   guibg=#3e3e5e

    hi WildMenu       gui=BOLD   guifg=#eeeeee   guibg=#6e6eaf

    hi MBENormal                 guifg=#cfbfad   guibg=#2e2e3f
    hi MBEChanged                guifg=#eeeeee   guibg=#2e2e3f
    hi MBEVisibleNormal          guifg=#cfcfcd   guibg=#4e4e8f
    hi MBEVisibleChanged         guifg=#eeeeee   guibg=#4e4e8f

    hi DiffText       gui=NONE   guifg=#ffffcd   guibg=#4a2a4a
    hi DiffChange     gui=NONE   guifg=#ffffcd   guibg=#306b8f
    hi DiffDelete     gui=NONE   guifg=#ffffcd   guibg=#6d3030
    hi DiffAdd        gui=NONE   guifg=#ffffcd   guibg=#306d30

    hi Cursor         gui=NONE   guifg=#404040   guibg=#8b8bff
    hi lCursor        gui=NONE   guifg=#404040   guibg=#8fff8b
    hi CursorIM       gui=NONE   guifg=#404040   guibg=#8b8bff

    hi Folded         gui=NONE   guifg=#cfcfcd   guibg=#4b208f
    hi FoldColumn     gui=NONE   guifg=#8b8bcd   guibg=#2e2e2e

    hi Directory      gui=NONE   guifg=#00ff8b   guibg=NONE
    hi LineNr         gui=NONE   guifg=#8b8bcd   guibg=#2e2e2e
    hi NonText        gui=BOLD   guifg=#8b8bcd   guibg=NONE
    hi SpecialKey     gui=BOLD   guifg=#ab60ed   guibg=NONE
    hi Title          gui=BOLD   guifg=#af4f4b   guibg=NONE
    hi Visual         gui=NONE   guifg=#eeeeee   guibg=#4e4e8f

    hi Comment        gui=NONE   guifg=#cd8b00   guibg=NONE
    hi Constant       gui=NONE   guifg=#ffcd8b   guibg=NONE
    hi String         gui=NONE   guifg=#ffcd8b   guibg=#404040
    hi Error          gui=NONE   guifg=#ffffff   guibg=#6e2e2e
    hi Identifier     gui=NONE   guifg=#ff8bff   guibg=NONE
    hi Ignore         gui=NONE
    hi Number         gui=NONE   guifg=#f0ad6d   guibg=NONE
    hi PreProc        gui=NONE   guifg=#409090   guibg=NONE
    hi Special        gui=NONE   guifg=#c080d0   guibg=NONE
    hi SpecialChar    gui=NONE   guifg=#c080d0   guibg=#404040
    hi Statement      gui=NONE   guifg=#808bed   guibg=NONE
    hi Todo           gui=BOLD   guifg=#303030   guibg=#d0a060
    hi Type           gui=NONE   guifg=#ff8bff   guibg=NONE
    hi Underlined     gui=BOLD   guifg=#df9f2d   guibg=NONE
    hi TaglistTagName gui=BOLD   guifg=#808bed   guibg=NONE

    hi perlSpecialMatch   gui=NONE guifg=#c080d0   guibg=#404040
    hi perlSpecialString  gui=NONE guifg=#c080d0   guibg=#404040

    hi cSpecialCharacter  gui=NONE guifg=#c080d0   guibg=#404040
    hi cFormat            gui=NONE guifg=#c080d0   guibg=#404040

    hi doxygenBrief                 gui=NONE guifg=#fdab60   guibg=NONE
    hi doxygenParam                 gui=NONE guifg=#fdd090   guibg=NONE
    hi doxygenPrev                  gui=NONE guifg=#fdd090   guibg=NONE
    hi doxygenSmallSpecial          gui=NONE guifg=#fdd090   guibg=NONE
    hi doxygenSpecial               gui=NONE guifg=#fdd090   guibg=NONE
    hi doxygenComment               gui=NONE guifg=#ad7b20   guibg=NONE
    hi doxygenSpecial               gui=NONE guifg=#fdab60   guibg=NONE
    hi doxygenSpecialMultilineDesc  gui=NONE guifg=#ad600b   guibg=NONE
    hi doxygenSpecialOnelineDesc    gui=NONE guifg=#ad600b   guibg=NONE

    if v:version >= 700
        hi Pmenu          gui=NONE   guifg=#eeeeee   guibg=#4e4e8f
        hi PmenuSel       gui=BOLD   guifg=#eeeeee   guibg=#2e2e3f
        hi PmenuSbar      gui=BOLD   guifg=#eeeeee   guibg=#6e6eaf
        hi PmenuThumb     gui=BOLD   guifg=#eeeeee   guibg=#6e6eaf

        hi SpellBad     gui=undercurl guisp=#cc6666
        hi SpellRare    gui=undercurl guisp=#cc66cc
        hi SpellLocal   gui=undercurl guisp=#cccc66
        hi SpellCap     gui=undercurl guisp=#66cccc

        hi MatchParen   gui=NONE      guifg=#404040   guibg=#8fff8b
    endif
else
    hi Normal           cterm=NONE      ctermfg=231     ctermbg=232

    hi IncSearch        cterm=BOLD      ctermfg=232     ctermbg=215
    hi Search           cterm=NONE      ctermfg=232     ctermbg=215
    hi ErrorMsg         cterm=BOLD      ctermfg=16      ctermbg=124
    hi WarningMsg       cterm=BOLD      ctermfg=16      ctermbg=202
    hi ModeMsg          cterm=BOLD      ctermfg=61      ctermbg=NONE
    hi MoreMsg          cterm=BOLD      ctermfg=61      ctermbg=NONE
    hi Question         cterm=BOLD      ctermfg=130     ctermbg=NONE

    hi StatusLine       cterm=BOLD      ctermfg=247     ctermbg=235
    hi User1            cterm=BOLD      ctermfg=46      ctermbg=235
    hi User2            cterm=BOLD      ctermfg=63      ctermbg=235
    hi StatusLineNC     cterm=NONE      ctermfg=244     ctermbg=235
    hi VertSplit        cterm=NONE      ctermfg=244     ctermbg=235

    hi WildMenu         cterm=BOLD      ctermfg=253     ctermbg=61

    hi MBENormal                        ctermfg=247     ctermbg=235
    hi MBEChanged                       ctermfg=253     ctermbg=235
    hi MBEVisibleNormal                 ctermfg=247     ctermbg=238
    hi MBEVisibleChanged                ctermfg=253     ctermbg=238

    hi DiffText         cterm=NONE      ctermfg=231     ctermbg=55
    hi DiffChange       cterm=NONE      ctermfg=231     ctermbg=17
    hi DiffDelete       cterm=NONE      ctermfg=231     ctermbg=52
    hi DiffAdd          cterm=NONE      ctermfg=231     ctermbg=22

    hi Folded           cterm=NONE      ctermfg=231     ctermbg=57
    hi FoldColumn       cterm=NONE      ctermfg=63      ctermbg=232

    hi Directory        cterm=NONE      ctermfg=46      ctermbg=NONE
    hi LineNr           cterm=NONE      ctermfg=240     ctermbg=232
    hi NonText          cterm=BOLD      ctermfg=63      ctermbg=NONE
    hi SpecialKey       cterm=BOLD      ctermfg=135     ctermbg=NONE
    hi Title            cterm=BOLD      ctermfg=124     ctermbg=NONE
    hi Visual           cterm=NONE      ctermfg=231     ctermbg=61

    hi Comment          cterm=NONE      ctermfg=240     ctermbg=NONE
    hi Constant         cterm=NONE      ctermfg=215     ctermbg=NONE
    hi String           cterm=NONE      ctermfg=215     ctermbg=235
    hi Error            cterm=NONE      ctermfg=231     ctermbg=52
    hi Identifier       cterm=NONE      ctermfg=131     ctermbg=NONE
    hi Ignore           cterm=NONE
    hi Number           cterm=NONE      ctermfg=203     ctermbg=NONE
    hi PreProc          cterm=NONE      ctermfg=35      ctermbg=NONE
    hi Special          cterm=NONE      ctermfg=135     ctermbg=NONE
    hi SpecialChar      cterm=NONE      ctermfg=135     ctermbg=235
    hi Statement        cterm=NONE      ctermfg=39      ctermbg=NONE
    hi Todo             cterm=BOLD      ctermfg=16      ctermbg=143
    hi Type             cterm=NONE      ctermfg=207     ctermbg=NONE
    hi Underlined       cterm=BOLD      ctermfg=227     ctermbg=NONE
    hi TaglistTagName   cterm=BOLD      ctermfg=63      ctermbg=NONE

    if v:version >= 700
        hi Pmenu        cterm=NONE      ctermfg=253     ctermbg=242
        hi PmenuSel     cterm=BOLD      ctermfg=253     ctermbg=4
        hi PmenuSbar    cterm=BOLD      ctermfg=253     ctermbg=63
        hi PmenuThumb   cterm=BOLD      ctermfg=253     ctermbg=63

        hi SpellBad     cterm=NONE      ctermfg=9       ctermbg=NONE
        hi SpellRare    cterm=NONE                      ctermbg=53
        hi SpellLocal   cterm=NONE                      ctermbg=58
        hi SpellCap     cterm=NONE                      ctermbg=23
        hi MatchParen   cterm=NONE      ctermfg=NONE    ctermbg=14
    endif
endif

if version >= 700 " Vim 7.x specific colors
  hi CursorLine     guifg=NONE        guibg=#121212     gui=NONE      ctermfg=NONE        ctermbg=234       cterm=BOLD
  hi CursorColumn   guifg=NONE        guibg=#121212     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=BOLD
  hi MatchParen     guifg=#f6f3e8     guibg=#857b6f     gui=BOLD      ctermfg=white       ctermbg=darkgray    cterm=NONE
  hi Search         guifg=NONE        guibg=NONE        gui=underline ctermfg=NONE        ctermbg=NONE        cterm=underline
endif
