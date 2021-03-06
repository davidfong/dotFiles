""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function keys summary
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <F2> fuzzyfinder to open files
" <F3> fuzzyfinder to open buffers
" <F4> toggle comment
" <F5> open REPL
" <F6> send selection to ConqueTerm
" <Ctrl-s> textwrap on a paragraph
" <F10> save and pdflatex

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Begin vundle settings
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tsaleh/vim-supertab'
Bundle 'Shougo/neocomplcache'
Bundle 'msanders/snipmate.vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'hallettj/jslint.vim'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'Javascript-Indentation'
Bundle 'opencl.vim--Wierzowiecki'
Bundle 'pyflakes.vim'
Bundle 'JavaScript-syntax'
Bundle 'MatlabFilesEdition'
Bundle 'Conque-Shell'
Bundle 'L9'
Bundle 'IndentAnything'
Bundle 'JSON.vim'
Bundle 'mlint.vim--Ibbotson'
Bundle 'The-NERD-Commenter'
" non github repos
Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'

" Bundle 'AutomaticLatexPlugin'
" Bundle 'Vim-R-plugin'
" Bundle 'LaTeX-Suite-aka-Vim-LaTeX'
" Bundle 'git://git.wincent.com/command-t'

filetype plugin indent on

" End vundle settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set modelines=0
set relativenumber
syntax on
set incsearch
set autoindent
set et
set sw=2
set expandtab
set smarttab
set hlsearch
set ignorecase
set smartcase  "case sensitive when uppercase present
set completeopt=menu
set cursorline
set scrolloff=3 " minimum lines to keep above and below cursor
set mouse+=a
set hidden              "allow buffers to hide without saving
set colorcolumn=81      "help enforce 80 character line limit
set autoread            "auto reload files changed outside

" now vim clipboard is the same as os x clipboard
set clipboard=unnamed

" no need to press shift for :
" nnoremap ; :

" :w!! will write to a root file without sudo vim
cmap w!! %!sudo tee > /dev/null %

" faster to normal mode
imap jk <C-c>
" imap kj <C-c>

" showing all tab completion options in command line
set wildmenu 
" <Tab> twice in the command line will bring up menu
set wildmode=list:longest,full 	
" Search and replace the word under the cursor with <Ctrl-h>
map <C-h> :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

" Switch to previously editing file
map <C-6> <C-^>

" make backspace work in iTerm
map <BS> dh
set backspace=indent,eol,start
" inoremap <BS> <Left><Del>

" Fast switch between tabs
map <C-Left> gT
map <C-Right> gt

" Moving tabs
noremap <silent> <C-S-Left> :exe "silent! tabmove " . (tabpagenr() - 2)<CR>
noremap <silent> <C-S-Right> :exe "silent! tabmove " . tabpagenr()<CR>

noremap H <C-w>h
noremap L <C-w>l
noremap <A-Up> <C-w>k
noremap <A-Down> <C-w>j

" shift key fixes
map:W :w 						
map:WQ :wq
map:wQ :wq
map:Q :q

" Include tags in folders all the way up to root.
set tags=./tags;/
set tags+=~/.vim/tags/stl

" JSON syntax
au! BufRead,BufNewFile *.json setfiletype json

au! BufRead,BufNewFile *.cl setlocal filetype=opencl

" cpp syntax folding
au! BufRead *.c,*.h,*.cpp set foldmethod=syntax

" latexsuite specific settings
map <F10> :w<Enter>\ll<Enter><C-l><Enter>
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex --shell-escape '.
                           \'--interaction=nonstopmode '.
                           \'-synctex=1 $*'
let g:Tex_ViewRule_pdf = 'Skim'
let g:Tex_UseMakefile = 0
let g:Tex_IgnoredWarnings = "Underfull\n".
      \"Overfull\n".
      \"specifier changed to\n".
      \"You have requested\n".
      \"Missing number, treated as zero.\n".
      \"There were undefined references\n".
      \"Citation %.%# undefined\n".
      \"LaTeX Font Warning\n".
      \"(epstopdf)\n".
      \"Unused global\n".
      \"Marginpar on page\n"
" keep this number the same as the number of lines above
let g:Tex_IgnoreLevel = 11
set shellslash " For windows
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
" This ensures that if labels are changed, pdflatex will run
" twice, and if *.bib changed, bibtex will also be run.
let g:Tex_MultipleCompileFormats='pdf'

" use ,t to perform textwrap on a paragraph
map ,t {!}fmt<Enter>
vmap ,t !fmt<Enter>

" Mappings for ctags
map :ct :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q 
" map <C-]> :set noignorecase<CR>:exec("tag ".expand("<cword>"))<CR>
noremap / :set ignorecase<CR>/

" use F4 for commenting and uncommenting of code
map <F4> <Leader>c<Space>
" add one space after the comment symbol for NERD commenter
let NERDSpaceDelims=1

" mapping for TComment
" map <F4> <C-_><C-_>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The section below are for Vim-R-plugin settings

" make conqueterm do v split by default
let vimrplugin_conquevsplit = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The section below are for matlab settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $VIMRUNTIME/macros/matchit.vim
" autocmd BufEnter *.m    compiler mlint

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The section below are for .vim/after/ftplugin/matlab.vim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (hostname() =~ "corn.*")
  let g:mlint_path_to_mlint="/usr/sweet/apps/matlab-2010b/bin/glnxa64/mlint"
elseif (hostname() == "david-icme")
  let g:mlint_path_to_mlint="/opt/matlab/bin/glnxa64/mlint"
else
  let g:mlint_path_to_mlint="/Applications/MATLAB_R2009a.app/bin/maci/mlint"
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The section below are for neocomplcache settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use neocomplcache. 
let g:neocomplcache_enable_at_startup = 1 
let g:neocomplcache_enable_smart_case = 1 
let g:neocomplcache_enable_camel_case_completion = 1 
let g:neocomplcache_enable_underbar_completion = 1 
let g:neocomplcache_manual_completion_start_length = 2
let g:neocomplcache_max_filename_width = 40
" let g:neocomplcache_enable_quick_match = 1
" let g:neocomplcache_quick_match_patterns = {'default':'-'}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The section below are for SuperTab settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = "<C-X><C-U>"
" auto close the preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" au Filetype python set sw=4 "Use 4 space tab stop

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The section below are for fuzzyfinder settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F2> :FufFile<Enter>
map <F3> :FufBuffer<Enter>
" let g:fuf_keyOpen="<C-l>"
" let g:fuf_keyOpenTabpage="<CR>"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The section below are for CommandT settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:CommandTMaxFiles=100000

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The section below are for gvim settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set go-=T
set go-=R
set go-=r
set go-=L
set go-=l
" set guifont=Monaco\ 14   "For gvim
set guifont=Monaco:h14     "For MacVim

" color scheme
set t_Co=256
colorscheme wombat256mod

" automatically source this file (so that no manual sourcing or vim restart is
" needed. (nested keyword makes CSApprox works)
au! BufWritePost .vimrc nested source %

" automatically add the python magic line
au BufEnter *.py if getline(1) == "" | :call setline(1, "#!/usr/bin/env python") | endif

" autochange working directory to opened file (Tip 64)
" au BufEnter * lcd %:p:h
" au BufEnter * lcd ~

" ConqueTerm Settings
vmap <F6> <F9><CR>jk<C-w>p
" vnoremap <F6> :<C-u>call conque_term#send_selected(visualmode().'\n')<CR><Esc><C-w>p
nnoremap <F6> V:<C-u>call conque_term#send_selected(visualmode().'\n')<CR>
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_SendVisKey = '<F9>'
let g:ConqueTerm_ToggleKey = ''
let g:ConqueTerm_EscKey = 'jk'
" open bash
" let g:ConqueTerm_TERM           = '/bin/bash'
map \p <C-W>v<C-W>l:ConqueTerm
map <F5> \p bash<Enter><Enter>
au BufEnter *.m map <F5> \p matlabf<Enter><Enter>
" au BufEnter *.py map <F5> \\p bpython<Enter><Enter>

" Show a horizontal line in insert mode
au InsertLeave * hi CursorLine ctermbg=234
au InsertEnter * hi CursorLine ctermbg=236

" Command-T settings
set wildignore+=*.pdf,*.mat,*.aux
let g:CommandTCancelMap='<C-c>'

" shortcuts
imap gkb Golub-Kahan bidiagonalization
