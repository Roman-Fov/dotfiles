"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc file
" Author: Roman Fov <roman.fov@gmail.com>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

 "Vim-plug installation
if empty(glob('~/.vim/autoload/plug.vim'))
	silent exec '!curl --create-dir -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
"!!!`git` executable not found. vim-plug requires git. (fedora20i386, debian wheezy)

if empty(glob('~/.fonts/DejaVu Sans Mono for Powerline.ttf'))

	silent exec '!curl --create-dir -fLo ~/.fonts/DejaVu\ Sans\ Mono\ for\ Powerline.ttf bit.ly/1HzA6eE'
endif


" Run Vim-plug
call plug#begin('~/.vim/plugged')

	" Higlighting enclosing tags
	Plug 'Valloric/MatchTagAlways', { 'for': ['html', 'xhtml', 'xml', 'jinja', 'php'] }
	let g:mta_filetypes = {
		\ 'html' : 1,
		\ 'xhtml' : 1,
		\ 'xml' : 1,
		\ 'jinja' : 1,
		\ 'php' : 1,
	\}

	" Start screen for Vim
	Plug 'mhinz/vim-startify'
	autocmd User Startified setlocal cursorline
	let g:startify_session_dir = '~/.vim/session'
	let g:startify_session_autoload = 1
	let g:startify_session_persistence = 1
	let g:startify_session_delete_buffers = 1
	let g:startify_enable_special = 0
	let g:startify_list_order = [
		\ ['   Sessions:'],
		\ 'sessions',
		\ ['   Bookmarks:'],
		\ 'bookmarks',
		\ ['   Recent']
	\ ]
	let g:startify_bookmarks = [ '~/.vimrc' ]
	let g:startify_custom_header = [
		\ '   U+262E \                         John Lennon',
		\ '   --------------------------------------------',
		\ '            \ I want you to make love, not war,',
		\ '             \ I know you’ve heard it before...',
		\ '',
	\ ]
	let g:startify_skiplist = [ 'COMMIT_EDITMSG' ]

	" Statusline for Vim
	Plug 'bling/vim-airline'
	set laststatus=2
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_powerline_fonts = 1
	let g:airline_theme='molokai'
	" @todo Install font!!!
	set guifont=DejaVu\ Sans\ Mono\ for\ Powerline

	Plug 'Yggdroot/indentLine'
	" Highlight tabs
	set list lcs=tab:\|\ " <- Here is a space
	" Highlight spaces
	let g:indentLine_enabled    = 1
	let g:indentLine_char = '¦'
	let g:indentLine_color_term = 239

	" Bufferlist
	Plug 'jlanzarotta/bufexplorer'
	let g:bufExplorerDisableDefaultKeyMapping=1
	let g:bufExplorerDefaultHelp=0
	let g:bufExplorerSplitRight=0
	let g:bufExplorerVertSize=40
	nnoremap <silent> <C-u> :BufExplorerVerticalSplit<CR>



	" Syntax highlighting
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'digitaltoad/vim-jade',      { 'for': 'jade' } " Jade
	Plug 'tpope/vim-haml',            { 'for': ['haml', 'scss', 'sass'] } " Haml
	Plug 'groenewege/vim-less',       { 'for': 'less' } " Less
	Plug 'slim-template/vim-slim',    { 'for': 'slim' } " Slim
	Plug 'othree/html5.vim',          { 'for': ['html', 'php'] } " HTML5
	Plug 'wavded/vim-stylus',         { 'for': 'stylus' } " Stylus
	Plug 'StanAngeloff/php.vim',      { 'for': 'php' } " PHP 5.3+
	Plug 'kchmck/vim-coffee-script',  { 'for': 'coffee' } " CoffeeScripte
	Plug 'hail2u/vim-css3-syntax',    { 'for': ['html', 'css'] } " CSS3
	Plug 'tpope/vim-markdown',        { 'for': 'markdown' } " Markdown
	Plug 'timcharper/textile.vim',    { 'for': 'textile' } " Textile
	augroup VimCSS3Syntax
		autocmd!
		autocmd FileType css setlocal iskeyword+=-
	augroup END

	Plug 'pangloss/vim-javascript',   { 'for': 'javascript' }
	let javascript_enable_domhtmlcss = 1

	Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }

	Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
	let g:used_javascript_libs = 'jquery'

	Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' } " i3wm config file

	" ??? Show tabs and spaces
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'ntpeters/vim-better-whitespace'
	nmap <F3> :ToggleWhitespace<CR>

	Plug 'mattn/emmet-vim', { 'for' : ['html','php','xhtml','css','sass','scss','less'] }
	au FileType html,php,css,sass,scss,less imap <expr>jk   emmet#expandAbbrIntelligent("\<tab>")
	au FileType html,php                    imap <C-\>      <CR><CR><Esc>ki<Tab>

	Plug 'henrik/vim-indexed-search'

	" Search in lang docs
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'Keithbsmiley/investigate.vim'
	nnoremap <F1> :call investigate#Investigate()<CR>

	"Plug 'scrooloose/syntastic'
	"let g:syntastic_auto_jump           = 1
	"let g:syntastic_error_symbol        = '✖'
	"let g:syntastic_warning_symbol      = '►'
	"let g:syntastic_javascript_checkers = ['jshint'   ] " sudo npm install -g jshint
	"let g:syntastic_html_checkers       = ['jshint'   ] " sudo npm install -g jshint
	"let g:syntastic_ruby_checkers       = ['rubylint' ] " gem install ruby-lint
	"let g:syntastic_haml_checkers       = ['haml-lint'] " gem install haml-lint
	"let g:syntastic_css_checkers        = ['csslint'  ] " sudo npm install -g csslint
	"let g:syntastic_css_csslint_args    = '--ignore=zero-units'

	" Colors highlighting
	Plug '/vim-css-color', { 'for': ['css', 'sass', 'scss', 'less', 'stylus'] }

	Plug 'scrooloose/nerdtree'
	" Close (when left only NT)
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
	" Toogle Nerdtree bar
	map <C-n> :NERDTreeToggle<CR>

	Plug 'majutsushi/tagbar'
	" Install exuberant-ctags
	let g:tagbar_left = 1
	let g:tagbar_width = 30
	let g:tagbar_autoclose = 1
	let g:tagbar_autofocus = 1
	let g:tagbar_indent = 1
	let g:tagbar_autopreview = 1
	nmap <C-m> :TagbarToggle<CR>

	Plug 'scrooloose/nerdcommenter'
	let mapleader = ","

	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'

	" Fuzzy finder for Vim
	Plug 'kien/ctrlp.vim'
	let g:NERDTreeChDirMode       = 2
	let g:ctrlp_working_path_mode = 'rw'


	Plug 'tpope/vim-fugitive'
	autocmd QuickFixCmdPost * Grep * CWindow

	Plug 'editorconfig/editorconfig-vim'

	" Color schemes
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	Plug 'tomasr/molokai'

call plug#end()


" Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" International keyboard switch (Ctrl-^ or Ctrl-a (insert & commandline))
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
imap <C-a> <C-^>
cmap <C-a> <C-^>



if has('gui_running')
	colorscheme molokai
else
	set background=dark
endif

if has('gui')
	set guioptions-=T
	set guioptions-=m
endif

" Tabs
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>
" use Alt-Left and Alt-Right to move current tab to left or right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
" CTRL-F4 is :tabclose
nnoremap <C-F4> :tabclose<CR>



    " Spell check

	"!!! :setlocal spell spelllang=ru_yo,en_us


    "setlocal spell spelllang=
    "setlocal nospell
    "function ChangeSpellLang()
    "    if &spelllang =~ "en_us"
    "        setlocal spell spelllang=ru
    "        echo "spelllang: ru"
    "    elseif &spelllang =~ "ru"
    "        setlocal spell spelllang=
    "        setlocal nospell
    "        echo "spelllang: off"
    "    else
    "        setlocal spell spelllang=en_us
    "        echo "spelllang: en"
    "    endif
    "endfunc
    " map spell on/off for English/Russian
    "map <F11> <Esc>:call ChangeSpellLang()<CR>



set nu
set nuw=4
" Relative line numbers
" autocmd InsertEnter * set nornu
" autocmd InsertLeave * set rnu



" Ignorecase search
set ic

" Highlight current line
set cursorline

" Hide the mouse when typing text
set mousehide






set splitbelow
set splitright


" Табы
set tabstop=4
set shiftwidth=4
set smarttab
set smartindent


" Autoreload .vimrc
augroup reload_vimrc
autocmd!
autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
