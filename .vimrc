let plugin_cmdex_disable = 1

let $LANG='ja_JP.UTF-8'
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,sjis
set encoding=utf-8
set fileformats=unix,dos,mac
set belloff=all
set cmdheight=2
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

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/denite.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('Shougo/neomru.vim')
  call dein#add('dense-analysis/ale')
  call dein#add('neoclide/coc.nvim', {
      \ 'merged': 0,
      \ 'rev': 'release',
      \ })
  call dein#add('Shougo/vimshell.git')
  call dein#add('thinca/vim-quickrun.git')
  call dein#add('thinca/vim-ref.git')
  call dein#add('mattn/emmet-vim')
  call dein#add('yuratomo/w3m.vim.git', {
      \ 'on_cmd': ['W3m', 'W3mTab', 'W3mSplit', 'W3mVSplit']
      \ })
  call dein#add('itchyny/lightline.vim.git')
  call dein#add('maximbaz/lightline-ale')
  call dein#add('tpope/vim-surround.git')
  call dein#add('scrooloose/nerdcommenter.git')
  call dein#add('thinca/vim-prettyprint.git')
  call dein#add('kannokanno/previm.git')
  call dein#add('airblade/vim-rooter.git')
  " Syntax
  call dein#add('othree/html5.vim.git', {
      \ 'on_ft': ['html']
      \ })
  call dein#add('hail2u/vim-css3-syntax.git', {
      \ 'on_ft': ['css']
      \ })
  call dein#add('pangloss/vim-javascript', {
      \ 'on_ft': ['javascript']
      \ })
  call dein#add('MaxMEllon/vim-jsx-pretty', {
      \ 'on_ft': ['javascript', 'jsx']
      \ })
  call dein#add('elixir-lang/vim-elixir', {
      \ 'on_ft': ['elixir']
      \ })
  call dein#add('leafgarland/typescript-vim', {
      \ 'on_ft': ['typescript']
      \ })
  call dein#add('posva/vim-vue', {
      \ 'on_ft': ['vue']
      \ })
  call dein#add('othree/csscomplete.vim', {
      \ 'on_ft': ['css', 'sass', 'scss', 'less']
      \ })
  " Color scheme
  call dein#add('joshdick/onedark.vim')

  call dein#end()
  call dein#save_state()
endif

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
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'component_expand': {
    \   'ale_checking': 'lightline#ale#checking',
    \   'ale_warnings': 'lightline#ale#warnings',
    \   'ale_errors': 'lightline#ale#errors',
    \   'ale_ok': 'lightline#ale#ok',
    \   'coc_warnings': 'CocWarnings',
    \   'coc_errors': 'CocErrors',
    \   'coc_ok': 'CocOk',
    \ },
    \ 'component_type': {
    \   'ale_checking': 'left',
    \   'ale_warnings': 'warning',
    \   'ale_errors': 'error',
    \   'ale_ok': 'left',
    \   'coc_warnings': 'warning',
    \   'coc_errors': 'error',
    \   'coc_ok': 'left',
    \ },
    \ 'active': {
    \   'left': [
    \     [ 'mode', 'paste' ],
    \     [ 'readonly', 'filename', 'modified' ],
    \     [ 'ale_checking', 'ale_errors', 'ale_warnings', 'ale_ok' ],
    \     [ 'coc_errors', 'coc_warnings', 'coc_ok' ],
    \ ]}
    \}

function! CocErrors() abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  let l:count = get(l:info, 'error', 0)
  return l:count <= 0 ? '' : printf('E: %d', l:count)
endfunction

function! CocWarnings() abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  let l:count = get(l:info, 'warning', 0)
  return l:count <= 0 ? '' : printf('W: %d', l:count)
endfunction

function! CocOk() abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  let l:error_count = get(info, 'error', 0)
  let l:warning_count = get(info, 'warning', 0)
  let l:count = l:error_count + l:warning_count
  return l:count <= 0 ? 'OK' : ''
endfunction
"}}}

" pythoncomplete {{{
augroup python
  au!
  autocmd FileType python set completeopt-=preview
augroup end
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" }}}

" denite {{{
nmap ,u [denite]

call denite#custom#option('default', 'prompt', '>')
call denite#custom#option('default', 'highlight_matched_char', 'IncSearch')
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

augroup denite_setting
  au!
  autocmd FileType denite call s:denite_my_settings()
  autocmd FileType denite-filter call s:denite_filter_my_settings()
  autocmd BufEnter denite <ESC>
augroup end

function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> t denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'

  nnoremap <silent><buffer><expr> <C-l> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <C-h> denite#do_map('move_up_path', 'noremap')
  nnoremap <silent><buffer><expr> <C-j> denite#do_map('do_action', 'split')
  inoremap <silent><buffer><expr> <C-j> denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
endfunction

function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <CR> <Plug>(denite_filter_quit)
  imap <silent><buffer> <ESC> <Plug>(denite_filter_quit)
endfunction

" Buffer
nnoremap <silent> [denite]b :<C-u>Denite buffer -direction=top<CR>
" File
nnoremap <silent> [denite]f :<C-u>DeniteBufferDir -buffer-name=files -direction=top file<CR>
" Buffer, Recently used file
nnoremap <silent> [denite]u :<C-u>Denite buffer file_mru -direction=top<CR>
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
nmap ,a [ale]

let g:ale_fix_on_save = 1
let g:ale_set_quickfix = 1
let g:ale_lint_on_text_changed = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = ">>"
let g:ale_sign_hint = "!!"
let g:ale_echo_msg_error_str = '✗'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%%/code%]'
let g:ale_disable_lsp = 1
let g:ale_ruby_rubocop_executable = 'bundle'

nmap <silent> [ale]k <Plug>(ale_previous_wrap)
nmap <silent> [ale]j <Plug>(ale_next_wrap)

let g:ale_linters = {
\  'scss': ['stylelint'],
\  'vue': ['stylelint', 'eslint'],
\  'rust': [],
\}

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint'],
\  'vue': ['stylelint', 'prettier', 'eslint'],
\  'scss': ['stylelint', 'prettier'],
\  'css': ['stylelint', 'prettier'],
\  'html': ['prettier'],
\  'json': ['prettier'],
\  'php': ['prettier'],
\  'ruby': ['rubocop'],
\  'rust': ['rustfmt'],
\}
"}}}

" CoC {{{
let s:colors=onedark#GetColors()
highlight link CocErrorSign NeomakeErrorSign
highlight link CocWarningSign NeomakeWarningSign
highlight link CocInfoSign NeomakeInfoSign
let g:coc_status_error_sign="✗"
let g:coc_status_warning_sign="⚠"

" if hidden is not set, TextEdit might fail.
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup coc
  autocmd!
  " Setup formatexpr specified filetype(s).
  "autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"}}}

" Rooter {{{
let g:rooter_change_directory_for_non_project_files = 'home'
let g:rooter_patterns = ['.git/']
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1
augroup rooter_settings
  autocmd!
  autocmd TabNew * nested :lcd ~
augroup end
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

" quickfix {{{
augroup quickfix
  au! quickfix
  au FileType qf nnoremap <silent><buffer> q :<C-u>cclose<CR>
augroup end
"}}}

" Set option {{{
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
augroup ft
  au!

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
  au FileType vim set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

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

  " TypeScript
  autocmd BufRead,BufNewFile *.ts set filetype=typescript

  " Vue
  autocmd FileType vuejs set filetype=vue
augroup end
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
