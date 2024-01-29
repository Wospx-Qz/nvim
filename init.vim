call plug#begin('C:\Users\qiaoz12\AppData\Local\nvim\plugged')
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
"Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'Wospx-Qz/vim-snippets'
Plug 'neoclide/coc.nvim',{'branch':'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'img-paste-devs/img-paste.vim'
Plug 'morhetz/gruvbox'
Plug 'moll/vim-bbye' " close buffer and keep status
Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " color-style
Plug 'Wospx-Qz/wosvim'
call plug#end()

"{{{ general config
:colorscheme catppuccin-latte "gruvbox one molokai
set clipboard^=unnamed,unnamedplus
set tabstop=4 
set shiftwidth=4
set autoindent
set number
set showmatch
set relativenumber
set background=light
set guifont=Consolas:h14:b
set autochdir
set mouse=nhv
set nrformats+=alpha
"}}}

let g:python_host_skip_check=1
let g:python_host_prog = 'D:\Users\qiaoz12\AppData\Local\anaconda3\python.exe'
let g:python3_host_skip_check=1
let g:python3_host_prog = 'D:\Users\qiaoz12\AppData\Local\anaconda3\python.exe'

let g:clipboard = {
          \   'name': 'win32yank-wsl',
          \   'copy': {
          \      '+': 'test.exe -i --crlf',
          \      '*': 'test.exe -i --crlf',
          \    },
          \   'paste': {
          \      '+': 'test.exe -o --lf',
          \      '*': 'test.exe -o --lf',
          \   },
          \   'cache_enabled': 0,
          \ }

"{{{Startify
let g:startify_custom_header = ['Try your best']
let g:startify_custom_footer = ['WospxJo']
let g:startify_bookmarks = [
			\{'m':'D:\Markdown'}, 
			\{'p':'D:\PythonProject'}, 
			\]
let g:startify_files_number = 20
"}}}

"{{{Nerdtree
let g:NERDTreeShowBookmarks=1
let g:NERDTreeSortOrder = ['[[-timestamp]]']
"}}}

"{{{snippets
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"}}}

nnoremap <ESC><ESC> :nohl<cr>
nnoremap <F2> :NERDTree<cr> 
nnoremap <F3> :NERDTreeClose<cr>
nnoremap K o<ESC>
nnoremap <Leader>j :s/\v[,.] \|[，。；：]/\0\r/g<cr>:nohl<cr>{j
nnoremap <leader>k vip:s/\n//g<cr>:nohl<cr>0
nnoremap <c-cr> :vs<cr><c-w><c-w>:term ipython<cr>a<c-\><c-n><c-w><c-w>
nnoremap <Leader><Leader> :b ipython <cr>a<c-w><c-v><cr><c-\><c-n><c-^><ESC><c-w><c-p>a<c-\><c-n><c-w><c-p>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader><Enter> :call Ipyrun()<cr>:call Ipyrun()<cr>:b ipython <cr>a<c-w><c-v><cr><c-\><c-n><c-^>
nnoremap <c-space> :let g:chinese_flag = 1 - g:chinese_flag<cr>

tnoremap jk <c-\><c-n><c-w><c-p>

inoremap jk <ESC><c-w><c-p>a
inoremap 【 [
inoremap 】 ]
inoremap  ｝ }
inoremap ｛ {
inoremap ￥ $
inoremap · `
inoremap …… ^
inoremap —— _
inoremap 。 <c-\><c-o>:call ChangeComment()<cr>
inoremap 、 <c-\><c-o>:call ChangeDunhao()<cr>
inoremap ： <c-\><c-o>:call ChangeMaohao()<cr>

onoremap $ ?#%%<cr>y/#%%<cr><c-o>
onoremap # ?#<cr>j0v/#<cr>k
onoremap : ?:<cr>j0y/In [<cr>


function! ChangeComment()
let l:last_char = getline('.')[col('.')-2]
if l:last_char =~ '\w\|\.\|(\|)' || len(l:last_char)==0
	call feedkeys('.','n')
else
	call feedkeys('。','n')
endif
endfunction

function! ChangeDunhao()
let l:last_char = getline('.')[col('.')-2]
if l:last_char =~ '\w\|\s\|\.\|\$\|\\' || len(l:last_char)==0
	call feedkeys('\','n')
else
	call feedkeys('、','n')
endif
endfunction

function! ChangeMaohao()
let l:last_char = getline('.')[col('.')-2]
if l:last_char =~ '\w\|\.\|(\|)\|:' || len(l:last_char)==0
	call feedkeys(':','n')
else
	call feedkeys('：','n')
endif
endfunction

" ipython run whole script
function! Ipyrun()
python<<EOF
filename = vim.eval("expand('%:t:r')")
runcom = '%run ' + filename
vim.command("let @+ = '%s'"%runcom)
EOF
endfunction

" input author information by abbr
function! HelpAbbrToInfo()
python<<EOF
from wospx.quickinfoinput import Abbr2Info
teststr  = vim.eval('@0')
ccc = Abbr2Info(teststr)
subedstr = ccc.get_info()
vim.command("let @a = '%s'"%subedstr)
vim.command('normal viw"ap')
EOF
endfunction
nnoremap <c-/> yiw:call HelpAbbrToInfo()<cr>

" Translate Markdown to Docx file by Pandoc
function! TransMD2(filetype)
let FT = a:filetype
python<<EOF
from wospx.newpandoctool import PandocMD
ft = vim.eval('FT')
FP = vim.eval("expand('%:p')")
obj = PandocMD(FP)
if ft == '0':
	obj.md2docx()
if ft == '1':
	obj.md2paper()
EOF
echo 'Completed'
endfunction

function! PreViewDocx()
python<<EOF
from wospx.newpandoctool import PandocMD
FP = vim.eval("expand('%:p')")
obj = PandocMD(FP)
obj.previewdocx()
EOF
echo 'opened'
endfunction

" markdowm preview
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }
let g:mkdp_auto_close = 0
let g:mkdp_markdown_css = "D:/MyTemplates/CSS/mymarkdown.css"

highlight myCiteColor ctermbg=blue guifg=#bbbbbb
autocmd! BufWinEnter *.md match myCiteColor /\[@.\{-}\]/

" 设置默认图片路径 img
let g:mdip_imgdir = 'img' 
"设置默认图片名称。当图片名称没有给出时，使用默认图片名称 image
let g:mdip_imgname = 'image'
autocmd FileType markdown nnoremap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<cr><ESC>

let g:chinese_flag = 0
autocmd WinEnter,VimEnter *.py let g:chinese_flag = 1
autocmd WinEnter,VimEnter *.json let g:chinese_flag = 1
autocmd WinEnter,VimEnter *.md let g:chinese_flag = 0


function! ChaLangENCN(lflag)
let language_flag = a:lflag
python<<EOF
LF = vim.eval('language_flag')
CF = vim.eval('g:chinese_flag')
import win32api
import win32gui
from win32con import WM_INPUTLANGCHANGEREQUEST
from win32con import KEYEVENTF_KEYUP
hwnd = win32gui.GetForegroundWindow()
# 0 = EN, 1 = CN
LANGUAGE = {
        "1": 0x0804, 
        "0": 0x0409  
    }
result = win32api.SendMessage(
        hwnd,
        WM_INPUTLANGCHANGEREQUEST,
        0,
        LANGUAGE[LF]
    )
if CF == '1' and LF == '1':
	win32api.keybd_event(16,0,KEYEVENTF_KEYUP,0)
	win32api.keybd_event(17,0,0,0)
	win32api.keybd_event(17,0,KEYEVENTF_KEYUP,0)
EOF
endfunction

autocmd! VimEnter * call ChaLangENCN(0)
autocmd! InsertEnter * call ChaLangENCN(1)
autocmd! InsertLeave * call ChaLangENCN(0)

highlight Folded guibg=#eff1f5 guifg=#006699
highlight FoldColumn guibg=#eff1f5 guifg=#c5d0e1
"highlight Folded ctermbg = NONE
"highlight FoldColumn ctermbg = NONE
let g:markdown_folding = 0
let g:markdown_enable_folding = 1

nnoremap <leader>d :call PreViewDocx()<cr>
nnoremap <leader>t :call TransMD2(0)<cr>
nnoremap <leader>T :call TransMD2(1)<cr>
