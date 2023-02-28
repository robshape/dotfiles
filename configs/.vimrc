"" ##################
"" Configure settings
"" ##################
"" Indent using 2 spaces
set autoindent
set expandtab
set shiftround
set shiftwidth=2
set tabstop=2
"" Use system clipboard
set clipboard=unnamed
"" Width to wrap text on
set colorcolumn=100
set textwidth=100
"" Highlight cursor
set cursorline
"" Wrap text in diff mode
set diffopt+=followwrap
"" Hide unsaved buffers to avoid save prompt
set hidden
"" Improve search experience
set hlsearch
set ignorecase
set incsearch
set smartcase
"" Disable backups
set nobackup
set noswapfile
set nowritebackup
"" Show relative line numbers together with signs
set number
set relativenumber
set signcolumn=number
"" Number of lines to always show above and below the cursor
set scrolloff=10
"" Hide intro message
set shortmess+=I
"" Show shortcut/command while typing
set showcmd
"" Recognize <esc> immediately
set timeout timeoutlen=1000 ttimeout ttimeoutlen=100
"" Decrease delay for plugin updates
set updatetime=400
"" Show auto-complete for commands
set wildmenu

"" ############
"" Map keyboard
"" ############
"" ALT+c to delete all buffers, except current buffer, and clear yank history
nnoremap ç :w\|%bd\|e#\|bd#<cr>:CocCommand yank.clean<cr>
"" ALT+j OR k to move current line, down or up
nnoremap ∆ :m .+1<cr>==
nnoremap ˚ :m .-2<cr>==
"" ALT+q to quit without prompt
nnoremap œ :qa!<cr>
"" ALT+s to save current buffer
nnoremap ß :w<cr>
"" ALT+w to close current pane
nnoremap ∑ <c-w>q
"" CTRL+c to escape
inoremap <c-c> <esc>
"" CTRL+h to navigate panes
nnoremap <c-h> <c-w>w
"" ENTER to clear highlighted search results
nnoremap <cr> :noh<cr><cr>
"" TAB to navigate buffers
nnoremap <tab> :bn<cr>

"" #############
"" Setup plugins
"" #############
"" CoC
let g:coc_global_extensions=[
  \'coc-eslint',
  \'coc-highlight',
  \'coc-json',
  \'coc-markdownlint',
  \'coc-pairs',
  \'coc-prettier',
  \'coc-snippets',
  \'coc-spell-checker',
  \'coc-stylelintplus',
  \'coc-svelte',
  \'coc-tsserver',
  \'coc-yank',
  \]
"" vim-plug
call plug#begin('~/.vim/plugged/')
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdtree'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'rakr/vim-one'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
call plug#end()
"" Install plugins (if missing)
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall --sync | q
endif

"" #################
"" Configure plugins
"" #################
"" Airline
"" Show buffers in tab line
let g:airline#extensions#tabline#enabled=1

"" Close Tag
"" Enable plugin
let g:closetag_filenames='*.jsx,*.tsx'

"" CoC
"" Set coc-settings.json directory
let g:coc_config_home='~/.vim/'
"" gd to jump to definition of code
nmap gd <Plug>(coc-definition)
"" gh to show tooltip for code
nnoremap gh :call CocActionAsync('doHover')<cr>
"" gr to show references for code
nmap gr <Plug>(coc-references)
"" yh to show yank history
nnoremap yh :<c-u>CocList -A --normal yank<cr>
"" ALT+m to show problems
nnoremap µ :CocList diagnostics<cr>
"" ALT+r to open Refactorings/Code Actions
nmap ® <Plug>(coc-codeaction)
"" CTRL+SPACE to toggle auto-complete
inoremap <expr> <c-@> coc#refresh()
"" ENTER to select auto-complete
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<c-g>u\<cr>"
"" F2 to rename symbol
nmap <f2> <Plug>(coc-rename)

"" EasyMotion
"" SPACE to toggle EasyMotion
nmap <space> <Plug>(easymotion-bd-w)

"" FZF
"" Include hidden files and respect .gitignore when searching for file
let $FZF_DEFAULT_COMMAND='rg --files -g "!.git/" --hidden'
"" Include hidden files and search only file content when searching in workspace
command! -bang -nargs=* Rg call fzf#vim#grep('rg --color=always --column -g "!.git/" --hidden -n --no-heading -S -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({ 'options': '-d : -n 4..' }), <bang>0)
"" ALT+f to search in workspace
nnoremap ƒ :Rg<cr>
"" ALT+p to search for file
nnoremap π :Files<cr>

"" indentLine
"" Disable conceal for JSON and Markdown
let g:indentLine_fileTypeExclude=['json', 'jsonc', 'markdown']

"" NERDTree
"" Show hidden files
let g:NERDTreeIgnore=['\.git$']
let g:NERDTreeShowHidden=1
"" Fix menu: https://github.com/preservim/nerdtree/issues/1321
let g:NERDTreeMinimalMenu=1
"" Resize window
let g:NERDTreeWinSize=45
"" ALT+d to reveal file in tree
nnoremap ∂ :NERDTreeFind<cr>
"" ALT+t to toggle tree
nnoremap † :NERDTreeToggle<cr>

"" One
"" Enable theme
set termguicolors
let &t_8b="\<esc>[48;2;%lu;%lu;%lum"
let &t_8f="\<esc>[38;2;%lu;%lu;%lum"
colorscheme one
highlight CocInfoSign ctermfg=blue
highlight CocMenuSel ctermbg=black ctermfg=white
highlight link EasyMotionTarget2First Search
highlight link EasyMotionTarget2Second Search

"" Polyglot
"" Enable TypeScript syntax for Svelte
let g:vim_svelte_plugin_use_typescript=1

"" UltiSnips
"" Set snippets directory
let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips/']

"" ##################
"" Setup autocommands
"" ##################
augroup autocommands
  autocmd!
"" CoC
"" Highlight symbol, and its references, when under cursor
  autocmd CursorHold * call CocActionAsync('highlight')

"" NERDTree
"" Open tree on start
  autocmd VimEnter * NERDTree
"" Defocus tree on start
  autocmd VimEnter * wincmd w

"" Vim
"" Trim final newlines on save
  function TrimFinalNewlines()
    let cursor_position=getpos('.')
    silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', cursor_position)
  endfunction
  autocmd BufWritePre * call TrimFinalNewlines()
"" Trim trailing whitespace on save
  autocmd BufWritePre * %s/\s\+$//e
"" Prompt when current buffer has been edited outside of Vim (by Git, for example)
  autocmd CursorHold,CursorHoldI * checktime
augroup END

"" ####################
"" Optimize performance
"" ####################
set lazyredraw
set synmaxcol=300
set ttyfast
let g:loaded_matchparen=1
