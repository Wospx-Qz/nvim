call plug#begin('C:\Users\Wospx\AppData\Local\nvim\plugged')
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'Wospx-Qz/vim-snippets'
Plug 'neoclide/coc.nvim',{'branch':'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
call plug#end()

"{{{config
:colorscheme gruvbox "one molokai
set clipboard^=unnamed,unnamedplus
set tabstop=4 
set shiftwidth=4
set autoindent
set number
set showmatch
set relativenumber
set background=dark
set guifont=Consolas:h14:b
set autochdir
set mouse=vn
"}}}

"{{{Startify
let g:startify_custom_header = ['Try your best']
let g:startify_custom_footer = ['WospxJo']
let g:startify_bookmarks = [
			\{'m':'D:\Markdown'}, 
			\{'b':'D:\MyBeamer'}, 
			\{'p':'D:\PythonProject'}, 
			\{'v':'D:\vimfile'},
			\]
let g:startify_files_number = 20
"}}}

"{{{Nerdtree
let g:NERDTreeShowBookmarks=1
let g:NERDTreeSortOrder = ['[[-timestamp]]']
"}}}

"{{{vimlatex
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
let g:vimtex_view_general_options
     \ = ' -reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_fold_enabled = 1
function! s:write_server_name() abort
  let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
  call writefile([v:servername], nvim_server_file)
endfunction

augroup vimtex_common
  autocmd!
  autocmd FileType tex call s:write_server_name()
augroup END
let g:vimtex_compiler_latexmk_engines={'_':'-xelatex'}
"}}}

"{{{snippets
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"}}}

"{{{python
"map <F5> :w<cr>:!python %<cr>
nnoremap <F5> :w<cr>:sp<cr><c-w><c-w>:term python %<cr>
nnoremap <F7> :w<cr>:term python<cr>
"noremap ,l :sp<CR><C-w>j:term ipython<CR> i %run 
"}}}

"{{{mapping
inoremap jj <ESC>
inoremap JJ <ESC>
inoremap Jj <ESC>
inoremap jJ <ESC>
nnoremap <ESC><ESC> :nohl<cr>
nnoremap <F2> :NERDTree<cr> 
nnoremap <F3> :NERDTreeClose<cr> 
nnoremap <Leader>t :NERDTreeFind<cr>
"}}}
"

" self Setting
nnoremap <c-cr> :vs<cr><c-w><c-w>:term ipython<cr>a<c-\><c-n><c-w><c-w>
nnoremap <Leader><Leader> :b ipython <cr>a<c-v><cr><c-\><c-n><c-^>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
tnoremap jk <c-\><c-n><c-w><c-p>
inoremap jk <ESC><c-w><c-p>a
iabbrev CUEN China Unicom (Shanghai) Industrial Internet Co.,Ltd.
inoremap 【 [
inoremap 】 ]

onoremap # ?#%%<cr>y/#%%<cr>

function! AlignTcbraster()
python<<EOF
from wospx.aligntool import alignfigurebox
teststr  = vim.eval('@0')
filepath= vim.eval("expand('%:p')")
subedstr = alignfigurebox(filepath,teststr)
vim.command("let @a = '%s'"%subedstr)
vim.command('normal vip"ap')
EOF
endfunction

nnoremap <leader><space> yip:call AlignTcbraster()<cr>

function! MakeNewTexFile()
python<<EOF
from wospx.beamertool import beamerfile
import os
obj = beamerfile()
FP = vim.eval("expand('%:p')")
obj.filepath = os.path.dirname(FP)
Preamble = obj.makePreamble()
obj.getTemplate()
vim.command("let @t = '%s'"%Preamble)
vim.command('normal vip"tp')
EOF
endfunction

function! TransMd2Docx()
python<<EOF
from wospx.pandoctool import md2docx
FP = vim.eval("expand('%:p')")
md2docx(FP)
EOF
echo 'ok'
endfunction

autocmd InsertEnter * :silent :!D:\\Software\\im-select\\im-select.exe 2052
autocmd InsertLeave * :silent :!D:\\Software\\im-select\\im-select.exe 1033

nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
let g:mkdp_auto_close = 0
