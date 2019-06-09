let plugin_cmdex_disable = 1

let $LANG='ja_JP.UTF-8'
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,sjis
set encoding=utf-8
set fileformats=unix,dos,mac

if &compatible
  set nocompatible
endif

" dein.vim {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  let &runtimepath.= ',' . s:dein_repo_dir
endif

call dein#begin(s:dein_dir)

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/denite.nvim')
call dein#add('Shougo/deoplete.nvim.git', {
\  'hook_source': 'let g:deoplete#enable_at_startup = 1
\                  " Completion by tab key
\                  inoremap <expr><tab> pumvisible() ? "\<C-n>" :
\                  neosnippet#expandable_or_jumpable() ?
\                  "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"'
\})
if !has('nvim')
  call dein#add('roxma/nvim-yarp.git')
  call dein#add('roxma/vim-hug-neovim-rpc.git')
endif
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neosnippet', {
\  'hook_source': 'imap <C-k> <Plug>(neosnippet_expand_or_jump)
\                  smap <C-k> <Plug>(neosnippet_expand_or_jump)
\                  xmap <C-k> <Plug>(neosnippet_expand_target)
\                  if has("conceal")
\                    set conceallevel=2 concealcursor=niv
\                  endif',
\  'on_i': 1,
\  'on_ft': ['snippet'],
\  'depends': ['neosnippet-snippets'],
\})
call dein#add('Shougo/neomru.vim')
call dein#add('w0rp/ale')
call dein#add('Shougo/vimshell.git')
call dein#add('thinca/vim-quickrun.git')
call dein#add('thinca/vim-ref.git')
call dein#add('mattn/emmet-vim')
call dein#add('yuratomo/w3m.vim.git', {
\  'on_cmd': ['W3m', 'W3mTab', 'W3mSplit', 'W3mVSplit']
\})
call dein#add('itchyny/lightline.vim.git')
call dein#add('maximbaz/lightline-ale')
call dein#add('tpope/vim-surround.git')
call dein#add('scrooloose/nerdcommenter.git')
call dein#add('thinca/vim-prettyprint.git')
call dein#add('kannokanno/previm.git')
" Syntax
call dein#add('othree/html5.vim.git', {
\  'on_ft': ['html']
\})
call dein#add('hail2u/vim-css3-syntax.git', {
\  'on_ft': ['css']
\})
call dein#add('pangloss/vim-javascript', {
\  'on_ft': ['javascript']
\})
call dein#add('MaxMEllon/vim-jsx-pretty', {
\  'on_ft': ['javascript', 'jsx']
\})
call dein#add('elixir-lang/vim-elixir', {
\  'on_ft': ['elixir']
\})
call dein#add('leafgarland/typescript-vim', {
\  'on_ft': ['typescript']
\})
call dein#add('posva/vim-vue', {
\  'on_ft': ['vue']
\  })
call dein#add('othree/csscomplete.vim', {
\  'on_ft': ['css', 'sass', 'scss', 'less']
\})
" Color scheme
call dein#add('joshdick/onedark.vim')

"call dein#add('Shougo/vimproc.vim', {'build': 'make'})
"call dein#add('carlitux/deoplete-ternjs', {
"  \ 'build': 'npm i -g tern'
"  \ })
"call dein#add('Shougo/unite.vim')
"call dein#add('mattn/webapi-vim.git')
"call dein#add('tyru/open-browser.vim.git')
"call dein#add('tyru/restart.vim.git')
"call dein#add('chrisbra/SudoEdit.vim.git')
"call dein#add('mattn/vdbi-vim.git')
"call dein#add('thinca/vim-localrc.git')
"call dein#add('kchmck/vim-coffee-script.git', {
"  \ 'lazy': 1,
"  \ 'on_ft': ['coffee']
"  \ })
"call dein#add('sheerun/vim-polyglot')

call dein#end()

syntax on
filetype plugin indent on

if len(dein#check_clean())
  call map(dein#check_clean(), 'delete(v:val, "rf")')
endif

if dein#check_install()
  call dein#install()
endif
"}}}

" colorscheme {{{
colorscheme onedark
let g:onedark_terminal_italics = 1
"}}}

" lightline {{{
set noshowmode
let g:lightline = {}
let g:lightline['colorschime'] = 'onedark'
let g:lightline.component_expand = {
\  'linter_checking': 'lightline#ale#checking',
\  'linter_warnings': 'lightline#ale#warnings',
\  'linter_errors': 'lightline#ale#errors',
\  'linter_ok': 'lightline#ale#ok',
\}
let g:lightline.component_type = {
\  'linter_checking': 'left',
\  'linter_warnings': 'warning',
\  'linter_errors': 'error',
\  'linter_ok': 'left',
\}
let g:lightline.active = {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'readonly', 'filename', 'modified' ],
\             [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
\ }
"}}}

" pythoncomplete {{{
autocmd FileType python set completeopt-=preview
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }}}

" deoplete {{{
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000

let g:deoplete#sources#ternjs#tern_bin = '/usr/local/bin/tern'
let g:deoplete#sources#ternjs#timeout = 1
let g:deoplete#sources#ternjs#guess = 0
let g:deoplete#sources#ternjs#omit_object_prototype = 0
let g:deoplete#sources#ternjs#include_keywords = 1
" }}}

" neosnippet {{{
let g:neosnippet#enable_completed_snippet = 1
" }}}

" denite {{{
nmap ,u [denite]

call denite#custom#option('default', 'prompt', '>')
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#map('normal', '<C-l>', '<CR>')
call denite#custom#map('normal', '<C-h>', '<denite:move_up_path>', 'noremap')
call denite#custom#map('normal', '<C-q>', '<Esc>')

augroup denite
  au! denite
  " Open window splitted horizontal
  au Filetype denite nnoremap <silent><buffer> <expr> <C-j> denite#do_action('below')
  au FileType denite inoremap <silent><buffer> <expr> <C-j> denite#do_action('below')
  " Open window splitted vertical
  au FileType denite nnoremap <silent><buffer> <expr> <C-v> denite#do_action('right')
  au FileType denite inoremap <silent><buffer> <expr> <C-v> denite#do_action('right')
  au BufEnter denite <ESC>
augroup end

" Buffer
nnoremap <silent> [denite]b :<C-u>Denite buffer -mode=normal -direction=top<CR>
" File
nnoremap <silent> [denite]f :<C-u>DeniteBufferDir -buffer-name=files -mode=normal -direction=top file<CR>
" Buffer, Recently used file
nnoremap <silent> [denite]u :<C-u>Denite buffer file_mru -mode=normal -direction=top<CR>
" }}}

" Restart.vim {{{
command!
\ RestartWithSession
\ let g:restart_sessionoptions = 'blank,curdir,folds,help,localoptions,tabpages'
\ | Restart
" }}}

" W3m.vim {{{
augroup w3m
  au! w3m
  au FileType w3m nmap <silent><buffer> H <Plug>(w3m-back)
  au FileType w3m nmap <silent><buffer> L <Plug>(w3m-forward)
  au FileType w3m nmap <silent><buffer> t <Plug>(w3m-shift-click)
  au FileType w3m nmap <silent><buffer> <Leader><Leader> :<C-u>call w3m#Reload()<CR>
  au FileType w3m nmap <silent><buffer> q :<C-u>call unite#start(['w3m'])<CR>
  au FileType w3m nmap <silent><buffer> ,o :<C-u>call w3m#ShowExternalBrowser()<CR>
  au FileType w3m setlocal bufhidden=wipe
  au FileType w3m setlocal nolist nocursorline
  au FileType w3m nmap <silent><buffer> T <Plug>(w3m-shift-click)<C-w>T
augroup end

command! W3mOpenUrl
\ execute 'W3mTab ' . s:get_url_on_cursor()

let g:w3m#lang = 'ja_JP'

" }}}

" VimShell {{{
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
"let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
let g:vimshell_enable_smart_case = 1
if has("win32") || has("win64")
  let g:vimshell_prompt = $USERNAME."% "
else
  let g:vimshell_prompt = $USER."% "
endif

command! TabVimShell tabe | VimShell
command! TabVimShellBufferDir call s:tab_vimshell_buffer_dir(expand('%:p:h'))

function! s:tab_vimshell_buffer_dir(dir)
    tabe
    execute ':VimShell ' . a:dir
endfunction

" }}}

" OpenBrowser {{{
command! OpenBrowserWithBelowUrl
\ execute 'OpenBrowser ' . s:get_url_on_cursor()

"}}}

" QuickRun {{{
let g:quickrun_config = {}
let g:quickrun_config['_'] = {
\ 'hook/time/enable' : '1',
\ 'runmode' : 'async:remote:vimproc'
\ }
"}}}

" ALE {{{
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_lint_on_text_changed = 0

let g:ale_linters = {
\   'scss': ['stylelint'],
\}
let g:ale_fixers = {
\  'javascript': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint'],
\  'vue': ['eslint', 'prettier'],
\  'scss': ['stylelint', 'prettier'],
\  'css': ['stylelint', 'prettier'],
\  'html': ['prettier'],
\}

let g:ale_typescript_tslint_executable = 'eslint'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%%/code%]'
"}}}

" Emmet.vim {{{
let g:user_emmet_settings = {
\  'html' : {
\    'indentation' : ' '
\  }
\}
"}}}

" Previm {{{
let g:previm_open_cmd = 'open -a Google\ Chrome'
let g:quickrun_config['markdown'] = {
\  'runner': 'vimscript',
\  'exec': ':PrevimOpen',
\  'outputter': 'null'
\ }
"}}}

" Set option {{{
set autoindent
set number
set incsearch
set ignorecase
set smartcase
set title
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nobackup
set noswapfile
set nowritebackup
set noundofile
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<
set display=uhex
set autoread
set formatoptions=lmoq
set laststatus=2

set backspace=indent,eol,start

set foldmethod=marker

" Use system clipboard
set clipboard=unnamed

set wildmode=longest:full,full

set hlsearch
"}}}

" GeneralKeyMapping {{{
" Paste from clipboard
imap <C-K> <ESC>"*pa
imap <C-v> <ESC>"*pa

" Tab control
nnoremap <silent> ,tn :<C-u>tabnew<CR>
nnoremap <silent> ,th :<C-u>tabclose<CR>

" Insert new line below the line
noremap <CR> o<ESC>

" To the first non-blank character of the line
nnoremap <C-h> ^
" To the end of the line
nnoremap <C-l> $

noremap * *N

nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>
"}}}

" FileType {{{
" html
au FileType html nmap j gj
au FileType html nmap k gk
au FileType html nmap <down> gj
au FileType html nmap <up> gk
au FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" css
au FileType css,sass,scss,less setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" php
au FileType php nmap j gj
au FileType php nmap k gk
au FileType php nmap <down> gj
au FileType php nmap <up> gk

" vimscript
au FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2

" help
au Filetype help nnoremap <buffer> q :<C-u>close<CR>

" ruby
au FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" markdown
au BufNewFile,BufRead,BufEnter *.md set filetype=markdown

" Coffee Script
au FileType coffee setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" JavaScript
au FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" typescript
au FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Elixir
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex set filetype=eelixir

" Vim
au FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" TypeScript
autocmd BufRead,BufNewFile *.ts set filetype=typescript
"}}}

" Function {{{
function! s:get_url_on_line(line) "{{{
  let mx = '\<\(http\|https\)\>://\a[a-zA-Z0-9_-]*\(\.[a-zA-Z0-9][a-zA-Z0-9_-]*\)*\(:\d+\)\{0,1}\(/[a-zA-Z0-9_/.\-+%#?&=;@$,!''*~]*\)\{0,1}'
  let pos1 = getpos('.')
  let pos2 = copy(pos1)
  let cpos = pos1[2]
  let [mpos, mlen, spos] = [0, 0, 0]
  while 1
    let mpos = match(a:line, mx, spos)
    if mpos == -1
      throw 'don't match'
    endif
    let mlen = len(matchstr(a:line[(mpos == 0 ? 0 : mpos-1):], mx))
    if mpos <= cpos && cpos <= mpos + mlen
      break
    endif
    let spos = mpos + mlen
  endwhile
  let pos1[2] = mpos + 1
  let pos2[2] = mpos + mlen
  return [pos1, pos2]
endfunction "}}}

function! s:get_url_on_cursor() "{{{
  try
  let line = getline('.')
  let [head_pos, tail_pos] = s:get_url_on_line(line)
  if tail_pos[2] == len(line)
    let tail_pos[2] += 1
  endif
  return line[ head_pos[2] - 1 : tail_pos[2] - 1]
  catch
  return ''
  endtry
endfunction "}}}
"}}}
