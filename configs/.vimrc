"" ##################
"" Configure settings
"" ##################
"" Indent using 2 spaces
set autoindent
set expandtab
set shiftround
set shiftwidth=2
set tabstop=2
"" Wrap text
set breakindent
set diffopt+=followwrap
let &showbreak='  '
"" Use system clipboard
set clipboard=unnamed
"" Width to wrap text on
set colorcolumn=100
set textwidth=100
"" Use UTF-8
set encoding=utf-8
"" Hide unsaved buffers to avoid save prompt
set hidden
"" Improve search experience
set hlsearch
set ignorecase
set incsearch
set shortmess-=S
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
"" Change leader
let mapleader=','
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
"" CTRL+h to cycle panes horizontally
nnoremap <silent> <c-h> <c-w>w
"" ENTER to clear highlighted search results
nnoremap <silent> <cr> :noh<cr><cr>
"" <leader>cc to close quickfix
nnoremap <silent> <leader>cc :ccl<cr>
"" <leader>cn to move to next quickfix location
nnoremap <silent> <leader>cn :cn<cr>
"" <leader>cp to move to previous quickfix location
nnoremap <silent> <leader>cp :cp<cr>
"" <leader>pd to disable Copilot
nnoremap <silent> <leader>pd :Copilot disable<cr>
"" <leader>pe to enable Copilot
nnoremap <silent> <leader>pe :Copilot enable<cr>
"" <leader>sa to save all buffers
nnoremap <silent> <leader>sa :wa<cr>
"" <leader>sc to save current buffer without autocommands
nnoremap <silent> <leader>sc :noa w<cr>

"" ############
"" Map commands
"" ############
"" :Replace to find and replace in all lines
:command -nargs=1 Replace :%s%<args>%g
"" :ReplaceQF to find and replace in all quickfix locations
:command -nargs=1 ReplaceQF :noa cfdo %s%<args>%g | up

"" #############
"" Setup plugins
"" #############
"" CoC
let g:coc_global_extensions=[
  \'coc-emoji',
  \'coc-eslint',
  \'coc-git',
  \'coc-go',
  \'coc-highlight',
  \'coc-json',
  \'coc-markdownlint',
  \'coc-pairs',
  \'coc-prettier',
  \'coc-sh',
  \'coc-snippets',
  \'coc-spell-checker',
  \'coc-styled-components',
  \'coc-stylelintplus',
  \'coc-tsserver',
  \'coc-yaml',
  \'coc-yank',
\]
""
"\'coc-clangd',
"\'coc-css',
"\'coc-docker',
"\'coc-html',
"\'coc-java',
"\'coc-jest',
"\'coc-pyright',
"\'coc-rust-analyzer',
"\'coc-svelte',
""
"" Vimspector
let g:vimspector_install_gadgets=[]
""
"\'CodeLLDB',
"\'debugger-for-chrome',
"\'debugpy',
"\'delve',
"\'vscode-java-debug',
"\'vscode-js-debug',
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
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'puremourning/vimspector'
call plug#end()
"" Install plugins (if missing)
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  au VimEnter * PlugInstall --sync | q
endif

"" #################
"" Configure plugins
"" #################
"" Airline
"" Hide mode
set noshowmode
"" Show diff in statusline
let g:airline#extensions#hunks#coc_git=1

"" Close Tag
"" Enable plugin
let g:closetag_filenames='*.jsx,*.tsx'

"" CoC
"" Set coc-settings.json directory
let g:coc_config_home='~/.vim/'
"" gd to jump to definition of code
nmap <silent> gd <plug>(coc-definition)
"" gh to show tooltip for code
nnoremap <silent> gh :call CocActionAsync('doHover')<cr>
"" gr to show references for code
nmap <silent> gr <plug>(coc-references)
"" ALT+. to open Code Actions
nmap <silent> ≥ <plug>(coc-codeaction)
"" ALT+m to show problems
nnoremap <silent> µ :CocList diagnostics<cr>
"" CTRL+d OR u to scroll popup window, downward or upward
nnoremap <silent><expr> <c-d> coc#float#has_scroll() ? coc#float#scroll(1) : '<c-d>'
nnoremap <silent><expr> <c-u> coc#float#has_scroll() ? coc#float#scroll(0) : '<c-u>'
inoremap <silent><expr> <c-d> coc#float#has_scroll() ? '<c-r>=coc#float#scroll(1)<cr>' : '<right>'
inoremap <silent><expr> <c-u> coc#float#has_scroll() ? '<c-r>=coc#float#scroll(0)<cr>' : '<left>'
"" ENTER to select auto-complete
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm() : '<c-g>u<cr><c-r>=coc#on_enter()<cr>'
"" F2 to rename symbol
nmap <silent> <f2> <plug>(coc-rename)
"" <leader>gu to copy GitHub URL of current line
nnoremap <silent> <leader>gu :CocCommand git.copyUrl<cr>
"" <leader>yh to show yank history
nnoremap <silent> <leader>yh :<c-u>CocList -A --normal yank<cr>

"" Copilot
"" Enable plugin
let g:copilot_filetypes={
  \'*':v:false,
  \'go':v:true,
  \'javascript':v:true,
  \'javascriptreact':v:true,
  \'json':v:true,
  \'jsonc':v:true,
  \'make':v:true,
  \'sh':v:true,
  \'typescript':v:true,
  \'typescriptreact':v:true,
  \'yaml':v:true,
\}

"" EasyMotion
"" SPACE to toggle EasyMotion
nmap <silent> <space> <plug>(easymotion-bd-w)

"" Fugitive
"" <leader>gb to show author of current line
nnoremap <silent> <leader>gb :G blame<cr>
"" <leader>gd to show diff of current file
nnoremap <silent> <leader>gd :Gdiffsplit<cr>
"" <leader>gm to open merge conflicts in quickfix
nnoremap <silent> <leader>gm :G mergetool<cr>

"" FZF
"" Include hidden files and respect .gitignore when searching for file
let $FZF_DEFAULT_COMMAND='rg -g "!.git/" --files --hidden'
"" Include hidden files and search only file content when searching in workspace
command! -bang -nargs=* Rg call fzf#vim#grep('rg -nSg "!.git/" --color=always --column --hidden --no-heading -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({ 'options': '-d : -n 4..' }), <bang>0)
"" ALT+f to search in workspace
nnoremap <silent> ƒ :Rg<cr>
"" ALT+p to search for file
nnoremap <silent> π :Files<cr>
"" <leader>fc to search for commit
nnoremap <silent> <leader>fc :Commits<cr>
"" <leader>fs to search for snippet for current filetype
nnoremap <silent> <leader>fs :Snippets<cr>

"" Goyo
"" Width to wrap text on (colorcolumn/textwidth plus 2)
let g:goyo_width=102
"" ALT+z to toggle Zen Mode
nnoremap <silent> Ω :Goyo<cr>

"" indentLine
"" Disable conceal for JSON and Markdown
let g:indentLine_fileTypeExclude=['json', 'jsonc', 'markdown']

"" NERDTree
"" Show hidden files
let g:NERDTreeIgnore=['\.git$']
let g:NERDTreeShowHidden=1
"" Fix menu: https://github.com/preservim/nerdtree/issues/1321/
let g:NERDTreeMinimalMenu=1
"" Resize window
let g:NERDTreeWinSize=45
"" ALT+r to reveal file in tree
nnoremap <silent> ® :NERDTreeFind<cr>
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
  highlight ColorColumn guibg=darkseagreen
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
"" Focus tree on toggle
let g:undotree_SetFocusWhenToggle=1
"" Shorten indicators
let g:undotree_ShortIndicators=1
"" F1 to toggle tree
nnoremap <silent> <f1> :UndotreeToggle<cr>

"" Vimspector
"" Enable mouse debugging
set mouse=a
"" Map keyboard
let g:vimspector_enable_mappings='HUMAN'
"" <leader>di to inspect symbol under cursor
nnoremap <silent> <leader>di <plug>VimspectorBalloonEval

"" ##################
"" Setup autocommands
"" ##################
augroup autocommands
  au!
"" CoC
"" Highlight symbol, and its references, when under cursor
  au CursorHold * call CocActionAsync('highlight')
"" Clean yank history on init
  au User CocNvimInit CocCommand yank.clean
"" Redraw statusline on status change (BUT FLASHES/HIDES CURSOR!)
  au User CocStatusChange redrawstatus

"" Copilot
"" Disable plugin for specific directories and files
  function DisableCopilot()
    let cwd=expand('%:p')
    let items=['/rodah/', '/shapeless/', 'Notes.md']
    for item in items
      if cwd =~ item
        let b:copilot_enabled=v:false
      endif
    endfor
  endfunction
  au BufEnter * call DisableCopilot()

"" Goyo
"" Restore theme on toggle
  au ColorScheme * call CustomizeTheme()
"" Customize Zen Mode
function EnterGoyo()
  set noshowcmd
  set scrolloff=999
  silent !tmux set status off
  silent !tmux resize-pane -Z
  Limelight
endfunction
au User GoyoEnter call EnterGoyo()
function LeaveGoyo()
  Limelight!
  silent !tmux resize-pane -Z
  silent !tmux set status on
  set scrolloff=10
  set showcmd
endfunction
au User GoyoLeave call LeaveGoyo()

"" NERDTree
"" Prevent buffers opening in tree
  au BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<c-w>w" | execute 'buffer'.buf | endif
"" Open and defocus tree on enter
  au VimEnter * NERDTree | wincmd p

"" Vim
"" Trim final newlines on save
  function TrimFinalNewlines()
    let cursor_position=getpos('.')
    silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', cursor_position)
  endfunction
  au BufWritePre * call TrimFinalNewlines()
"" Trim trailing whitespace on save
  au BufWritePre * %s/\s\+$//e
"" Prompt when current buffer has been edited outside of Vim (by Git, for example)
  au CursorHold,CursorHoldI * checktime
"" Highlight cursor in current buffer
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn cursorline
  au WinLeave * setlocal nocursorcolumn nocursorline
augroup END

"" ####################
"" Optimize performance
"" ####################
set lazyredraw
set synmaxcol=300
set ttyfast
let g:loaded_matchparen=1
