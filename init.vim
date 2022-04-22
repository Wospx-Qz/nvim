call plug#begin('C:\Users\Wospx\AppData\Local\nvim\plugged')

Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ZSaberLv0/ZFVimIM'
Plug 'ZSaberLv0/ZFVimJob'
Plug 'ZSaberLv0/ZFVimIM_pinyin_base'
Plug 'ZSaberLv0/ZFVimIM_openapi' 
Plug 'godlygeek/tabular' "必要插件，安装在vim-markdown前面
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'plasticboy/vim-markdown'
Plug 'ferrine/md-img-paste.vim' 
Plug 'yinflying/matlab.vim'
Plug 'lervag/vimtex'
call plug#end()

:colorscheme molokai
set clipboard^=unnamed,unnamedplus
set tabstop=4 
set shiftwidth=4
set autoindent
set number
set showmatch
set relativenumber
"保存折叠信息
autocmd BufWinLeave *.m mkview
autocmd BufWinLeave *.md mkview
autocmd BufWinLeave *.txt mkview
autocmd BufWinLeave *.tex mkview


"ZFVimIM
let g:ZFVimIM_symbolMap = {
            \   '!' : ['！'],
            \   '-' : [''],
            \   '_' : ['——'],
            \   '(' : ['（'],
            \   ')' : ['）'],
            \   '[' : ['【'],
            \   ']' : ['】'],
            \   '<' : ['《'],
            \   '>' : ['》'],
            \   '\' : ['、'],
            \   '/' : ['、'],
            \   ';' : ['；'],
            \   ':' : ['：'],
            \   ',' : ['，'],
            \   '.' : ['。'],
            \   '?' : ['？'],
            \   "'" : ['‘', '’'],
            \   '"' : ['“', '”'],
            \ }

"Startify
let g:startify_custom_header = ['Try your best']
let g:startify_custom_footer = ['WospxJo']
let g:startify_bookmarks = [
			\'C:\Users\Wospx\AppData\Local\nvim\init.vim',
			\'D:\Markdown',
			\'D:\File\matlabscript',
			\'D:\1.Paper\0.Thesis',
			\'D:\vimfile',
			\]
let g:startify_files_number = 5
"let NERDTreeHijackNetrw = 0

"Nerdtree
let g:NERDTreeShowBookmarks=1
"let g:nerdtree_tabs_open_on_console_startup=1

"md-img-paste.vim
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
"let g:mdip_imgdir_absolute = 'D:\Markdown\img'
let g:mdip_imgdir = 'img'
let g:mdip_imgname = 'image'

"markdown-preview.nvim
let g:mkdp_path_to_chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1

"vimlatex
let g:tex_flavor = 'latex'
let g:Tex_ViewRule_pdf = 'D:\Users\Wospx\AppData\Local\SumatraPDF\SumatraPDF.exe -reuse-instance -inverse-search "gvim -c \":RemoteOpen +\%l \%f\""'
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-pdf',
    \ 'pdflatex'         : '-pdf',
    \ 'dvipdfex'         : '-pdfdvi',
    \ 'lualatex'         : '-lualatex',
    \ 'xelatex'          : '-xelatex',
    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
    \ 'context (luatex)' : '-pdf -pdflatex=context',
    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
    \}
let g:vimtex_view_general_viewer = 'D:\Users\Wospx\AppData\Local\SumatraPDF\SumatraPDF.exe' 
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_view_general_options
     \ = ' -reuse-instance -forward-search @tex @line @pdf'
     \ . ' -inverse-search "' . 'cmd /c start /min \"\" '  . exepath(v:progpath)
     \ . ' -v --not-a-term -T dumb -c  \"VimtexInverseSearch %l ''%f''\""' "for vim/gvim
"let g:vimtex_compiler_latexmk_engines={'_':'-xelatex'}
"let g:vimtex_compiler_latexrun_engines={'_':'xelatex'}
"let g:vimtex_view_general_viewer = 'SumatraPDF'
"let g:vimtex_view_general_options
"      \ = '-reuse-instance -forward-search @tex @line @pdf'

"let g:vimtex_view_method='sumatra'   
"let g:vimtex_view_general_viewer = 'D:\Users\Wospx\AppData\Local\SumatraPDF\SumatraPDF.exe'
"let g:vimtex_compiler_progname = 'nvr'
"let g:vimtex_view_general_options_latexmk = '-reuse-instance'  
"let g:vimtex_view_general_viewer = 'SumatraPDF'
"let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
"let g:vimtex_view_general_options_latexmk = '-reuse-instance'

"python
map <F5> :w<cr>:!python %<cr>
inoremap jj <ESC>
nnoremap <ESC><ESC> :nohl<cr>
