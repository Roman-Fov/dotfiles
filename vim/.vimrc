" ====================================================================
" My vim config.
" https://github.com/Roman-Fov/dotfiles
" ====================================================================

" ====================================================================
" Vim-plug installation (plugin manager)
" ====================================================================
if empty(glob('~/.vim/autoload/plug.vim'))
	silent exec '!curl --create-dir -fLo ~/.vim/autoload/plug.vim http://git.io/VgrSsw'
endif

" ====================================================================
" Install DejaVu Sans Mono with Powerline/Airline support
" ====================================================================
if empty(glob('~/.fonts/DejaVu Sans Mono for Powerline.ttf'))
	silent exec '!curl --create-dir -fLo ~/.fonts/DejaVu\ Sans\ Mono\ for\ Powerline.ttf http://git.io/bhtZ' " ???
endif

" Run Vim-plug
call plug#begin('~/.vim/plugged')

	" ================================================================
	" Color schemes
	" ================================================================
	Plug 'tomasr/molokai'
	Plug 'chriskempson/vim-tomorrow-theme'


	" ================================================================
	" Search
	" ================================================================
	" !install ack-grep
	" !install silversearcher-ag
	Plug 'mileszs/ack.vim'
	if executable('ag')
		let g:ackprg = 'ag --vimgrep'
	endif
	Plug 'haya14busa/incsearch.vim' | Plug 'haya14busa/incsearch-fuzzy.vim'
		let g:incsearch#auto_nohlsearch = 1
		map / <Plug>(incsearch-forward)
		map ? <Plug>(incsearch-backward)
		map g/ <Plug>(incsearch-stay)
		map z/ <Plug>(incsearch-fuzzy-/)
		map z? <Plug>(incsearch-fuzzy-?)
		map zg/ <Plug>(incsearch-fuzzy-stay)


	" ================================================================
	" VCS
	" ================================================================
	Plug 'airblade/vim-gitgutter'
		let g:gitgutter_enabled = 0
		map <F4> :GitGutterToggle<CR>
	Plug 'tpope/vim-fugitive'
		autocmd QuickFixCmdPost * Grep * CWindow


	" ================================================================
	" UI
	" ================================================================
	Plug 'mhinz/vim-startify'
		autocmd User Startified setlocal cursorline
		let g:startify_session_dir = '~/.vim/session'
		let g:startify_session_autoload = 1
		let g:startify_session_persistence = 1
		let g:startify_session_delete_buffers = 1
		let g:startify_enable_special = 0
		let g:startify_files_number = 5
		let g:startify_list_order = [
			\ ['   Sessions:'],
			\ 'sessions',
			\ ['   Bookmarks:'],
			\ 'bookmarks',
			\ ['   Recent'],
			\ 'files'
		\ ]
		let g:startify_bookmarks = [ '~/.vimrc' ]
		let g:startify_skiplist = [ 'COMMIT_EDITMSG' ]
	Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
		let g:airline#extensions#tabline#enabled = 1
		let g:airline_powerline_fonts = 1
		let g:airline_theme='molokai'

	
	" ================================================================
	" Nav
	" ================================================================
	Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } | Plug 'Xuyuanp/nerdtree-git-plugin'
		" Files to ignore
		let NERDTreeIgnore = [ '\.pyc$' ]
		" Close (when left only NT)
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
		" Toogle Nerdtree bar
		map <C-n> :NERDTreeToggle<CR>
	Plug 'easymotion/vim-easymotion'
		" <Leader>f{char} to move to {char}
		map  <Leader>f <Plug>(easymotion-bd-f)
		nmap <Leader>f <Plug>(easymotion-overwin-f)

		" s{char}{char} to move to {char}{char}
		nmap s <Plug>(easymotion-overwin-f2)

		" Move to line
		map <Leader>L <Plug>(easymotion-bd-jk)
		nmap <Leader>L <Plug>(easymotion-overwin-line)

		" Move to word
		map  <Leader>w <Plug>(easymotion-bd-w)
		nmap <Leader>w <Plug>(easymotion-overwin-w)
		let g:EasyMotion_smartcase = 1
		let g:EasyMotion_do_shade = 0
		hi link EasyMotionTarget Search

	" ================================================================
	" Code completion
	" ================================================================
	" Autoclose tags.
	Plug 'alvan/vim-closetag' " !for
	" Vim plugin, insert or delete brackets, parens, quotes in pair
	Plug 'jiangmiao/auto-pairs'
		let g:closetag_filenames = "*.html,*.xml,*.xsl,*.php"
	Plug 'mattn/emmet-vim', { 'for' : ['html','php','xhtml','css','sass','scss','less'] }
		au FileType html,php,css,sass,scss,less imap <expr>jk   emmet#expandAbbrIntelligent("\<tab>")
		au FileType html,php                    imap <C-\>      <CR><CR><Esc>ki<Tab>

	Plug 'Shougo/neocomplete.vim'
		" Use neocomplete.
		let g:neocomplete#enable_at_startup = 1
		" Use smartcase.
		let g:neocomplete#enable_smart_case = 1
		" Set minimum syntax keyword length.
		let g:neocomplete#sources#syntax#min_keyword_length = 3
		" Plugin key-mappings.
		inoremap <expr><C-g>     neocomplete#undo_completion()
		inoremap <expr><C-l>     neocomplete#complete_common_string()
		" <CR>: close popup and save indent.
		inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
		function! s:my_cr_function()
			return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
			" For no inserting <CR> key.
			"return pumvisible() ? "\<C-y>" : "\<CR>"
		endfunction
		" <TAB>: completion.
		inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
		" <C-h>, <BS>: close popup and delete backword char.
		inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
		inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
		" Fix vim freezes when deleting characters
		inoremap <expr><bs> pumvisible() ? "<ESC>:call neocomplete#close_popup()<CR>a<bs>" : "<bs>"
		" Enable omni completion.
		autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
		autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
		autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
		autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
		autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
		" Enable heavy omni completion.
		if !exists('g:neocomplete#sources#omni#input_patterns')
			let g:neocomplete#sources#omni#input_patterns = {}
		endif
		let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	Plug 'Shougo/neosnippet'
	Plug 'Shougo/neosnippet-snippets'


	" ================================================================
	" Other
	" ================================================================
	Plug 'editorconfig/editorconfig-vim'
	Plug 'vim-scripts/matchit.zip'
		filetype plugin on " ???
	Plug 'csscomb/vim-csscomb', { 'for': ['css', 'less', 'scss', 'sass'] }
		autocmd FileType css noremap <buffer> <leader>bc :CSScomb<CR>
		autocmd BufWritePre,FileWritePre *.css,*.less,*.scss,*.sass silent! :CSScomb
	" Show trailing whitespace characters (tabs & spaces)
	" Fix spaces :StripWhitespace
	Plug 'ntpeters/vim-better-whitespace'
	Plug 'tomtom/tcomment_vim'
	" Plug 'ryanoasis/vim-devicons' " ???
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'


	" ================================================================
	" Syntax highlighting
	" ================================================================
	Plug 'Valloric/MatchTagAlways' " !for
		let g:mta_filetypes = {
			\ 'xslt' : 1,
			\ 'html' : 1,
			\ 'xml' : 1,
			\ 'php' : 1,
			\}
	Plug 'Yggdroot/indentLine'
		" Highlight tabs
		set list lcs=tab:\|\ " <- Here is a space
		" Highlight spaces
		let g:indentLine_enabled = 1
		let g:indentLine_char = '¦'
		let g:indentLine_color_term = 239
	Plug 'hail2u/vim-css3-syntax', { 'for': ['html', 'php', 'css'] }
		augroup VimCSS3Syntax
			autocmd!
			autocmd FileType css setlocal iskeyword+=-
		augroup END
	Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }
	Plug 'wavded/vim-stylus',            { 'for': 'stylus' }
	Plug 'groenewege/vim-less',          { 'for': 'less' }
	Plug 'tpope/vim-markdown',           { 'for': 'markdown' } " ?
	Plug 'othree/html5.vim',             { 'for': ['html', 'php'] }
	Plug 'timcharper/textile.vim',       { 'for': 'textile' }
	Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
	Plug 'pangloss/vim-javascript',      { 'for': 'javascript' }
		let javascript_enable_domhtmlcss = 1
	" Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
	" 	let g:used_javascript_libs = 'jquery'


	" ================================================================
	" Lang support
	" ================================================================
	Plug 'fatih/vim-go',         { 'for': 'go' }
	Plug 'StanAngeloff/php.vim', { 'for': 'php' }


	" ================================================================
	" Syntastic!!!!!
	" ================================================================
	Plug 'scrooloose/syntastic'
		set statusline+=%#warningmsg#
		set statusline+=%{SyntasticStatuslineFlag()}
		set statusline+=%*

		let g:syntastic_always_populate_loc_list = 1
		let g:syntastic_auto_loc_list = 1
		let g:syntastic_check_on_open = 1
		let g:syntastic_check_on_wq = 0

		let g:syntastic_enable_signs=1
		let g:syntastic_auto_jump           = 1
		let g:syntastic_error_symbol        = '✖'
		let g:syntastic_warning_symbol      = '►'
		let g:syntastic_javascript_checkers = ['jshint'] " sudo npm install -g jshint
		"let g:syntastic_html_checkers       = ['jshint'   ] " sudo npm install -g jshint
		let g:syntastic_css_checkers        = ['csslint'] " sudo npm install -g csslint
		let g:syntastic_css_csslint_args    = '--ignore=zero-units'


	" Fuzzy finder for Vim
	Plug 'ctrlpvim/ctrlp.vim'
		let g:NERDTreeChDirMode       = 2
		let g:ctrlp_working_path_mode = 'rw'
		set wildignore+=*/.git/*,*/.svn/*,*/bower_components/*,*/node_modules/*
		nnoremap <silent> <C-u> :CtrlPBuffer<CR>
	"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	"Plug 'vim-ctrlspace/vim-ctrlspace'

call plug#end()


" ================================================================
" General settings
" ================================================================
if has('gui')
	set guioptions-=T
	set guioptions-=m
endif
if (exists('+colorcolumn'))
	set colorcolumn=100
endif
colorscheme Tomorrow-Night-Eighties


" ====================================================================
" Backups
" ====================================================================
set nobackup
set nowb
set noswapfile

" ====================================================================
" Tabs
" ====================================================================
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>
" use Alt-Left and Alt-Right to move current tab to left or right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
" CTRL-F4 is :tabclose
nnoremap <C-F4> :tabclose<CR>


" ====================================================================
" Fonts
" ====================================================================
" set guifont=Fira\ Mono\ 9
" set guifont=Droid\ Sans\ Mono\ 10
" set guifont=Hack\ 10
" set guifont=Roboto\ Mono\ 9
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set guifont=Iosevka\ 10


" ====================================================================
" Cmdline
" ====================================================================
set showcmd  " Show partial cmdline
set wildmenu " Enable comandline tab completion menu
if exists("&wildignorecase")
	set wildignorecase " Ignorecase cmdline tab completion
endif
set laststatus=2 " Displaying statusline always


" ====================================================================
" Search
" ====================================================================
" Start searching when you type the first character of the search string
set incsearch
" Ignorecase searching
set ignorecase smartcase
" Enable seach highlighting
set hlsearch
set wrapscan


" ====================================================================
" Editing
" ====================================================================
set tabstop=4
set shiftwidth=4
set smarttab
set splitbelow
set autoindent smartindent
set showmatch
" Put only one space after '.', '?', '!' with a join command
set nojoinspaces
set cursorline
set mousehide
" Number of lines to keep above and below the cursor
set scrolloff=4
set number
" Set width of the column used for numbering
set numberwidth=4


" ====================================================================
" Autofix commands
" ====================================================================
" Fix write and quit commands
cabbr W w
cabbr Q q
" Write with sudo trick (see: http://git.io/NIPR)
command! WW w !sudo tee %:p > /dev/null


" ====================================================================
" Keyboard layout
" ====================================================================
" International keyboard switch (Ctrl-^ or Ctrl-a (insert & commandline))
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
imap <C-a> <C-^>
cmap <C-a> <C-^>


" ====================================================================
" Other
" ====================================================================
" Autoreload files on change
set autoread
" Do not redraw while executing macros
set lazyredraw
" Vim hardcore mode
inoremap <Up>    <NOP>
noremap  <Up>    <NOP>
inoremap <Down>  <NOP>
noremap  <Down>  <NOP>
inoremap <Left>  <NOP>
noremap  <Left>  <NOP>
inoremap <Right> <NOP>
noremap  <Right> <NOP>


" ====================================================================
" Autoreload .vimrc
" ====================================================================
augroup reload_vimrc
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

