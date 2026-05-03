" Cherri language syntax highlighting
if exists("b:current_syntax")
  finish
endif



" ============================================================================
" Keywords - Control Flow
" ============================================================================
syntax keyword cherriKeywordControl if else repeat while for in break continue return
highlight link cherriKeywordControl Keyword

" Keywords - Definitions
syntax keyword cherriKeywordDef menu ask variables global local function import include const
highlight link cherriKeywordDef Define

" Keywords - Types
syntax keyword cherriType dict list text number true false null
highlight link cherriType Type

" ============================================================================
" Comments
" ============================================================================
syntax match cherriComment "//.*$" contains=cherriTodo
syntax region cherriComment start="/\*" end="\*/" contains=cherriTodo
syntax keyword cherriTodo contained TODO FIXME BUG NOTE HACK
highlight link cherriComment Comment
highlight link cherriTodo Todo

" ============================================================================
" Strings
" ============================================================================
syntax region cherriString start='"' end='"' skip='\\.' contains=cherriEscape
syntax region cherriString start="'" end="'" skip='\\.' contains=cherriEscape
syntax match cherriEscape '\\[\\\"'\''nrt]' contained
highlight link cherriString String
highlight link cherriEscape SpecialChar

" ============================================================================
" Numbers
" ============================================================================
syntax match cherriNumber "\v<\d+(\.\d+)?>"
syntax match cherriNumber "\v0[xX][0-9a-fA-F]+"
highlight link cherriNumber Number

" ============================================================================
" Actions & Built-ins
" ============================================================================
syntax match cherriAction "\v(ask|menu|choose|say|display|show|alert)" 
syntax match cherriBuiltin "\v(length|count|contains|append|remove|get|set|push|pop)"
highlight link cherriAction Function
highlight link cherriBuiltin Function

" ============================================================================
" Variables & Constants
" ============================================================================
syntax match cherriVariable "\v\@[a-zA-Z_][a-zA-Z0-9_]*"
syntax match cherriVariable "\v\$[a-zA-Z_][a-zA-Z0-9_]*"
syntax match cherriConstant "\v[A-Z_][A-Z0-9_]*" 
highlight link cherriVariable Identifier
highlight link cherriConstant Constant

" ============================================================================
" Operators
" ============================================================================
syntax match cherriOperator "\v(\+|-|\*|/|%|==|!=|<=|>=|<|>|&&|\|\|)"
highlight link cherriOperator Operator

" ============================================================================
" Blocks & Delimiters
" ============================================================================
syntax match cherriDelimiter "[{}()\[\]]"
highlight link cherriDelimiter Delimiter

" ============================================================================
" Special
" ============================================================================
syntax match cherriProperty "\v\.[a-zA-Z_][a-zA-Z0-9_]*"
syntax match cherriQuestion "\?"
highlight link cherriProperty Identifier
highlight link cherriQuestion Special

let b:current_syntax = "cherri"
