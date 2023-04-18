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
"" Use UTF-8
set encoding=utf-8
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
"" ALT+c to delete all buffers, except current buffer, clear yank history, and restart CoC
nnoremap <silent> ç :w\|%bd\|e#\|bd#<cr>:CocCommand yank.clean<cr>:CocRestart<cr>
"" ALT+j OR k to move current line, down or up
nnoremap <silent> ∆ :m .+1<cr>==
nnoremap <silent> ˚ :m .-2<cr>==
"" ALT+q to quit without prompt
nnoremap <silent> œ :qa!<cr>
"" ALT+s to save current buffer
nnoremap <silent> ß :w<cr>
"" ALT+w to close current pane
nnoremap <silent> ∑ <c-w>q
"" CTRL+c to escape
inoremap <silent> <c-c> <esc>
"" CTRL+h to navigate panes
nnoremap <silent> <c-h> <c-w>w
"" ENTER to clear highlighted search results
nnoremap <silent> <cr> :noh<cr><cr>
"" TAB to navigate buffers
nnoremap <silent> <tab> :bn<cr>

"" ############
"" Map commands
"" ############
"" :Replace to find and replace in all lines
:command -nargs=1 Replace :%s/<args>/g
"" :ReplaceCF to find and replace in all quickfix files
:command -nargs=1 ReplaceCF :cfdo %s/<args>/g | up
"" :SaveNOA to save current buffer without autocommands
:command SaveNOA :noa w

"" #############
"" Setup plugins
"" #############
"" CoC
let g:coc_global_extensions=[
  \'coc-emoji',
  \'coc-eslint',
  \'coc-git',
  \'coc-highlight',
  \'coc-json',
  \'coc-markdownlint',
  \'coc-pairs',
  \'coc-prettier',
  \'coc-sh',
  \'coc-snippets',
  \'coc-spell-checker',
  \'coc-stylelintplus',
  \'coc-svelte',
  \'coc-tsserver',
  \'coc-yaml',
  \'coc-yank',
\]
""
"\'coc-clangd',
"\'coc-css',
"\'coc-docker',
"\'coc-go',
"\'coc-html',
"\'coc-java',
"\'coc-jest',
"\'coc-pyright',
"\'coc-rls',
"\'coc-styled-components',
""
"" vim-plug
call plug#begin('~/.vim/plugged/')
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'github/copilot.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/limelight.vim'
Plug 'preservim/nerdtree'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'mbbill/undotree'
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
"" Hide mode
set noshowmode
"" Show diff in statusline
let g:airline#extensions#hunks#coc_git=1
"" Show buffers in tabline
let g:airline#extensions#tabline#enabled=1

"" Close Tag
"" Enable plugin
let g:closetag_filenames='*.jsx,*.tsx'

"" CoC
"" Set coc-settings.json directory
let g:coc_config_home='~/.vim/'
"" gd to jump to definition of code
nmap <silent> gd <Plug>(coc-definition)
"" gh to show tooltip for code
nnoremap <silent> gh :call CocActionAsync('doHover')<cr>
"" gr to show references for code
nmap <silent> gr <Plug>(coc-references)
"" yh to show yank history
nnoremap <silent> yh :<c-u>CocList -A --normal yank<cr>
"" ALT+m to show problems
nnoremap <silent> µ :CocList diagnostics<cr>
"" ALT+r to open Refactorings/Code Actions
nmap <silent> ® <Plug>(coc-codeaction)
"" CTRL+d OR u to scroll floating window, downward or upward
nnoremap <silent><expr> <c-d> coc#float#has_scroll() ? coc#float#scroll(1) : '<c-d>'
nnoremap <silent><expr> <c-u> coc#float#has_scroll() ? coc#float#scroll(0) : '<c-u>'
inoremap <silent><expr> <c-d> coc#float#has_scroll() ? '<c-r>=coc#float#scroll(1)<cr>' : '<right>'
inoremap <silent><expr> <c-u> coc#float#has_scroll() ? '<c-r>=coc#float#scroll(0)<cr>' : '<left>'
"" ENTER to select auto-complete
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm() : '<c-g>u<cr><c-r>=coc#on_enter()<cr>'
"" F2 to rename symbol
nmap <silent> <f2> <Plug>(coc-rename)
"" :GitHubCopyURL to copy GitHub URL of current line
:command GitHubCopyURL :CocCommand git.copyUrl

"" Copilot
"" Enable plugin
let g:copilot_filetypes={
  \'*': v:false,
  \'javascript': v:true,
  \'javascriptreact': v:true,
  \'typescript': v:true,
  \'typescriptreact': v:true,
\}

"" EasyMotion
"" SPACE to toggle EasyMotion
nmap <silent> <space> <Plug>(easymotion-bd-w)

"" FZF
"" Include hidden files and respect .gitignore when searching for file
let $FZF_DEFAULT_COMMAND='rg --files -g "!.git/" --hidden'
"" Include hidden files and search only file content when searching in workspace
command! -bang -nargs=* Rg call fzf#vim#grep('rg --color=always --column -g "!.git/" --hidden -n --no-heading -S -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({ 'options': '-d : -n 4..' }), <bang>0)
"" ALT+f to search in workspace
nnoremap <silent> ƒ :Rg<cr>
"" ALT+p to search for file
nnoremap <silent> π :Files<cr>

"" Goyo
"" Width to wrap text on
let g:goyo_width=100
"" ALT+z to toggle Zen Mode
nnoremap <silent> Ω :Goyo<cr>

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
nnoremap <silent> ∂ :NERDTreeFind<cr>
"" ALT+t to toggle tree
nnoremap <silent> † :NERDTreeToggle<cr>

"" One
"" Enable theme
set termguicolors
let &t_8b="\<esc>[48;2;%lu;%lu;%lum"
let &t_8f="\<esc>[38;2;%lu;%lu;%lum"
colorscheme one
function CustomizeTheme()
  highlight CocInfoSign ctermfg=blue
  highlight CocMenuSel ctermbg=black ctermfg=white
  highlight link EasyMotionTarget2First Search
  highlight link EasyMotionTarget2Second Search
endfunction
call CustomizeTheme()

"" Polyglot
"" Enable TypeScript syntax for Svelte
let g:vim_svelte_plugin_use_typescript=1

"" UltiSnips
"" Set snippets directory
let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips/']

"" Undotree
"" Hide diff window
let g:undotree_DiffAutoOpen=0
"" Focus tree on start
let g:undotree_SetFocusWhenToggle=1
"" Shorten indicators
let g:undotree_ShortIndicators=1
"" F5 to toggle tree
nnoremap <silent> <f5> :UndotreeToggle<cr>

"" ##################
"" Setup autocommands
"" ##################
augroup autocommands
  autocmd!
"" CoC
"" Highlight symbol, and its references, when under cursor
  autocmd CursorHold * call CocActionAsync('highlight')

"" Copilot
"" Disable plugin for specific directories and files
  function DisableCopilot()
    let cwd=expand('%:p')
    let items=['/rodah/','/shapeless/','Notes.md']
    for item in items
      if cwd =~ item
        let b:copilot_enabled=v:false
      endif
    endfor
  endfunction
  autocmd BufEnter * call DisableCopilot()

"" Goyo
"" Restore theme on toggle
  autocmd ColorScheme * call CustomizeTheme()
"" Customize Zen Mode
function GoyoEnter()
  set noshowcmd
  set scrolloff=999
  silent !tmux set status off
  silent !tmux resize-pane -Z
  Limelight
endfunction
autocmd User GoyoEnter call GoyoEnter()
function GoyoLeave()
  Limelight!
  silent !tmux resize-pane -Z
  silent !tmux set status on
  set scrolloff=10
  set showcmd
endfunction
autocmd User GoyoLeave call GoyoLeave()

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
