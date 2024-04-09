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
let g:coc_force_debug = 1

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
  call dein#add('joshdick/onedark.vim', {
      \ 'rev': 'main',
      \ })

  call dein#add('peitalin/vim-jsx-typescript')
  call dein#add('github/copilot.vim')

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
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'component_expand': {
    \   'ale_checking': 'lightline#ale#checking',
    \   'ale_infos': 'lightline#ale#infos',
    \   'ale_warnings': 'lightline#ale#warnings',
    \   'ale_errors': 'lightline#ale#errors',
    \   'ale_ok': 'lightline#ale#ok',
    \ },
    \ 'component_type': {
    \   'ale_checking': 'left',
    \   'ale_infos': 'left',
    \   'ale_warnings': 'warning',
    \   'ale_errors': 'error',
    \   'ale_ok': 'left',
    \ },
    \ 'active': {
    \   'left': [
    \     [ 'mode', 'paste' ],
    \     [ 'readonly', 'filename', 'modified' ],
    \     [ 'ale_checking', 'ale_errors', 'ale_warnings', 'ale_infos', 'ale_ok' ],
    \     [ 'cocstatus', 'coccurrentfunction' ],
    \ ]},
    \ 'component_function': {
    \   'cocstatus': 'coc#status',
    \   'coccurrentfunction': 'CocCurrentFunction'
    \ },
    \}

augroup lightline#ale
    autocmd!
    autocmd User ALEJobStarted call lightline#update()
    autocmd User ALELintPost call lightline#update()
    autocmd User ALEFixPost call lightline#update()
augroup end
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
  imap <silent><buffer> <ESC> <Plug>(denite_filter_update)
  imap <silent><buffer> <CR> <ESC><CR>
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
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
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

nmap <silent> [ale]k <Plug>(ale_previous_wrap)
nmap <silent> [ale]j <Plug>(ale_next_wrap)

let g:ale_linters = {
\  'scss': ['stylelint'],
\  'vue': ['stylelint', 'eslint'],
\  'rust': [],
\  'go': ['golangci-lint'],
\}

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint'],
\  'typescriptreact': ['prettier', 'eslint'],
\  'vue': ['stylelint', 'prettier', 'eslint'],
\  'scss': ['stylelint', 'prettier'],
\  'css': ['stylelint', 'prettier'],
\  'html': ['prettier'],
\  'json': ['prettier'],
\  'php': ['prettier'],
\  'ruby': ['rubocop'],
\  'rust': ['rustfmt'],
\  'go': ['gofmt'],
\}
"}}}

" CoC {{{
let s:colors=onedark#GetColors()
highlight link CocErrorSign NeomakeErrorSign
highlight link CocWarningSign NeomakeWarningSign
highlight link CocInfoSign NeomakeInfoSign
let g:coc_status_error_sign="✗"
let g:coc_status_warning_sign="⚠"

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"}}}

" Rooter {{{
let g:rooter_change_directory_for_non_project_files = 'home'
let g:rooter_patterns = ['.git/']
let g:rooter_cd_cmd="lcd"
let g:rooter_silent_chdir = 1
augroup rooter_settings
  autocmd!
  autocmd BufEnter * nested if empty(expand('%:p')) | :lcd $HOME | endif
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

  " git commit
  autocmd FileType gitcommit :set formatoptions=q

  " go
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

  " java
  au FileType java setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
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
