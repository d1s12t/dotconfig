""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""==>>Auto load for the first time
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""==>>Basic Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin on
set number
set relativenumber
set cursorline
set mouse=a
set hidden
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set splitright
set splitbelow
set showcmd
set wildmenu
set ignorecase
set smartcase
set shortmess+=c
set completeopt=longest,noinsert,menuone,noselect,preview
set linebreak
set wrap
set whichwrap=b,s,<,>,[,]
set backspace=indent,eol,start
set textwidth=0
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif

" Compile function
noremap run :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc
 
 " add "Basic Settings" before this line



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""==>>Terminal Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" add "Terminal Settings" before this line


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""==>>Basic Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quickly return normal mode
inoremap jk <ESC>
" find and replace
noremap \s :%s//g<left><left>

" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "
noremap ; :

" Save & quit
noremap Q :q!<CR>
noremap S :w!<CR>

" Quickly edit vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
noremap re :source $MYVIMRC<CR>

" Clipboard mappings
nnoremap Y y$
vnoremap Y "+y

" Indentation
nnoremap < <<
nnoremap > >>

" stop search highlight
noremap <LEADER><CR> :nohlsearch<CR>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap <LEADER>sl :set splitright<CR>:vsplit<CR>
noremap <LEADER>sh :set nosplitright<CR>:vsplit<CR>
noremap <LEADER>sk :set nosplitbelow<CR>:split<CR>
noremap <LEADER>sj :set splitbelow<CR>:split<CR>

" moving the cursor around windows
noremap <LEADER>h <C-w>h
noremap <LEADER>j <C-w>j
noremap <LEADER>k <C-w>k
noremap <LEADER>l <C-w>l

" tab management
noremap tn :tabe<CR>
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>

" Cursor movement

" all mode
noremap <C-h> <Left>
noremap <C-j> <Down>
noremap <C-k> <Up>
noremap <C-l> <Right>

" insert mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-a> <ESC>^i
inoremap <C-e> <ESC>$a

" normal mode
nnoremap <silent> <C-a> ^
nnoremap <silent> <C-e> $
nnoremap <silent> H 5h
nnoremap <silent> J 5j
nnoremap <silent> K 5k
nnoremap <silent> L 5l

" command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <M-b> <S-Left>
cnoremap <M-w> <S-Right>

" add "Basic Mappings" before this line



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""==>>My Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open lazygit
noremap <c-g> :tabe<CR>:-tabmove<CR>:term lazygit<CR>

" InsertMap For Enter: 
inoremap <expr> <CR> InsertMapForEnter()
function! InsertMapForEnter()
    " 补全菜单
    if pumvisible()
        return "\<C-y>"
    " 自动缩进大括号 {}
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == '}'
        return "\<CR>\<Esc>O"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,2) == '</'
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
endfunction

" add "My Mappings" before this line



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""==>>Plug Install
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged'

" Pretty Dress
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'

" File navigation
Plug 'junegunn/fzf.vim'
" Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'kevinhwang91/rnvimr'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
" Plug 'honza/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree'

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }

" Markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'

" Editor Enhancement
"Plug 'Raimondi/delimitMate'
Plug 'mg979/vim-visual-multi'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'pechorin/any-jump.vim'
Plug 'lambdalisue/suda.vim'
Plug 'skywind3000/vim-terminal-help'

" Find & Replace
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }

" Other visual enhancement
Plug 'luochen1990/rainbow'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'mg979/vim-xtabline'

" add plug at before this line

" add "Plug Install" before this line

call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""==>>Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-bookmark settings
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '♥'
let g:bookmark_highlight_lines = 1

" Scheme settings
colorscheme gruvbox
set background=dark

" Fzf settings
command! -bang -nargs=* Rg
             \ call fzf#vim#grep(
             \ "rg --column --line-number --no-heading --color=always --smart-case --hidden -g '!**/.git/**' -- ".shellescape(<q-args>), 1, <bang>0)

" Coc settings
let g:coc_global_extensions = [
			\'coc-explorer',
			\'coc-emmet',
			\'coc-highlight',
			\'coc-pairs',
			\'coc-explorer',
			\'coc-snippets',
			\'coc-yank',
			\'coc-git']
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.config/nvim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" 使用<Tab>触发补全
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Coc-pairs settings
autocmd FileType vim let b:coc_pairs_disable = ['"']

inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ coc#refresh()
nmap <silent> gd <Plug>(coc-definition) " 跳转到定义
nmap <silent> gi <Plug>(coc-implementation) "跳转到实现
nmap <silent> gr <Plug>(coc-references) "跳转到引用
nmap <silent> gty <Plug>(coc-type-definition) " 跳转到类型定义
nmap <silent> gne <Plug>(coc-diagnostic-next) 
nmap <silent> gle <Plug>(coc-diagnostic-prev)

" coc-snippets
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-Tab>'
xmap <leader>x  <Plug>(coc-convert-snippet) "添加选中文本到snippets

" coc-explorer
nmap <space>ed :CocCommand explorer --preset .vim<CR>
nmap <space>ef :CocCommand explorer --preset floating<CR>
nmap <space>ec :CocCommand explorer --preset cocConfig<CR>
nmap <space>eb :CocCommand explorer --preset buffer<CR>
nnoremap <silent><nowait> <space>cla  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>cle  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>clc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>clo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>cls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Rnvimr settings
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 0
" let g:rnvimr_bw_enable = 1
highlight link RnvimrNormal CursorLine
nnoremap <silent> R :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]

" Vim-illuminate settings
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl

" Suda.vim
cnoreabbrev sudowrite w suda://%
cnoreabbrev sw w suda://%

" Xtabline settings
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap to :XTabCycleMode<CR>
noremap \p :echo expand('%:p')<CR>

" Vim-table-mode settings
autocmd FileType markdown TableModeEnable

" Tcommant_vim settings
nnoremap ci cl
let g:tcomment_textobject_inlinecomment = ''
nmap <LEADER>cn g>c
vmap <LEADER>cn g>
nmap <LEADER>cu g<c
vmap <LEADER>cu g<

" Any-jump settings
nnoremap gj :AnyJump<CR>
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9


" Vim-markdown-toc
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'
" let g:vmt_auto_update_on_save = 1
" let g:vmt_dont_insert_fence = 1

" vim-instant-markdow
let g:instant_markdown_browser = "chromium --new-window"
let g:instant_markdown_port = 8888
let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
let g:instant_markdown_autostart =0
"let g:instant_markdown_slow = 1
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1

" Rainbow settings
let g:rainbow_active = 1

" Undotree settings
noremap L :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24

" Bullets settings
let g:bullets_enabled_file_types = [
			\ 'markdown',
			\ 'text',
			\ 'gitcommit',
			\ 'scratch'
			\]
let g:VM_mouse_mappings = 1
nmap   <C-LeftMouse>         <Plug>(VM-Mouse-Cursor)
nmap   <C-RightMouse>        <Plug>(VM-Mouse-Word)
nmap   <M-C-RightMouse>      <Plug>(VM-Mouse-Column)

" add "Plugin settings" before this line



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""==>>Plugin Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-bookmarks Mappings

" 在当前行添加/删除书签
nmap <Leader><Leader> <Plug>BookmarkToggle 
" 在当前行添加/编辑/删除注释
nmap <Leader>ba <Plug>BookmarkAnnotate
" 显示所有书签'
nmap <Leader>bl <Plug>BookmarkShowAll
" 下一个书签
nmap <Leader>bj <Plug>BookmarkNext
" 上一个书签
nmap <Leader>bk <Plug>BookmarkPrev
" 清除缓冲区中的书签
nmap <Leader>bcc <Plug>BookmarkClear
" 清除所有缓冲区中的书签
nmap <Leader>bca <Plug>BookmarkClearAll
" 在当前行上移书签
nmap <Leader>bmj <Plug>BookmarkMoveUp
" 在当前行下移书签
" nmap <Leader>bmk <Plug>BookmarkMoveDown
" 将当前书签移动到另一行
" nmap <Leader>bmn <Plug>BookmarkMoveToLine

" add "Plugin Mappings" before this line