" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"
" ================ Plugins ======================
" vim-plug (https://github.com/junegunn/vim-plug)
"
call plug#begin('~/.vim/plugged')

Plug 'drewtempelmeyer/palenight.vim'
Plug 'itchyny/lightline.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'posva/vim-vue'
Plug 'keith/rspec.vim'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'chemzqm/vim-run'
Plug 'stephpy/vim-yaml'
Plug 'cakebaker/scss-syntax.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-fugitive'

call plug#end()

" ================ General Config ====================

set number                      "Line numbers are good
" set backspace=indent,eol,start  "Allow backspace in insert mode
" set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

"do/end ruby matching
runtime macros/matchit.vim

" ================ Appearence =======================
"
if (has("termguicolors"))
  set termguicolors
endif

let g:palenight_terminal_italics=1

set background=dark
silent! colorscheme palenight
set laststatus=2
let g:lightline = {}
let g:lightline.colorscheme = 'nord'

"
" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" PHP specific indent
autocmd Filetype php setlocal sw=4 sts=4 ts=4

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" Keep swap files in separate directory
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

"
" ================ FZF ======================
"
" map ; :Files<CR>
" map l :Buffers<CR>
"
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

"
" ================ Vue ======================
"
autocmd FileType vue syntax sync fromstart

"
" ================ test.vim ================
"

" make test commands execute using dispatch.vim
let test#strategy = "terminal"

" key mappings for running specs (\t \s \a \l)
nmap <silent> <Leader>s :TestNearest<CR>
nmap <silent> <Leader>t :TestFile<CR>
nmap <silent> <Leader>a :TestSuite<CR>
nmap <silent> <Leader>l :TestLast<CR>

" use docker command if there is a docker compose file in the root
if !empty(glob("docker-compose.yml"))
  let test#ruby#rspec#executable = 'docker-compose exec spring spring rspec'
endif

let g:markdown_fenced_languages = ['html', 'json', 'ruby', 'bash=sh', 'javascript', 'jsx=javascript', 'css', 'scss']

autocmd BufNewFile,BufRead .eslintrc set filetype=json
autocmd BufNewFile,BufRead .babelrc set filetype=json

imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_settings = { 'javascript.jsx': { 'extends': 'jsx' }, 'javascript': { 'extends': 'jsx' }, 'erb': { 'extends': 'html' } }

map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

set foldenable          " enable folding
set foldlevelstart=99   " open most folds by default
set foldmethod=syntax   " fold based on indent level
" space open/closes folds
nnoremap <space> za 

" ALE Linter
let g:ale_linters = { 'javascript': ['eslint'], 'ruby': ['rubocop'], 'php': ['phpcs'] }
let g:ale_linters_explicit = 1
let g:ale_php_phpcs_executable='./vendor/bin/phpcs'

if !empty(glob("docker-compose.yml"))
  let g:ale_ruby_rubocop_executable = 'bin/ale-rubocop'
  let g:ale_javascript_eslint_executable = 'bin/ale-eslint'
else
  let g:ale_ruby_rubocop_executable = 'bundle'
endif

" Auto Pairs
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutFastWrap = '<C-e>'

" Vim Run
let g:vim_run_command_map = {
  \'javascript': 'node',
  \'javascript.jsx': 'node',
  \'php': 'php',
  \'python': 'python',
  \'ruby': 'ruby'
  \}
