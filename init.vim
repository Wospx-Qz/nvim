call plug#begin('C:\Users\qiaoz12\AppData\Local\nvim\plugged')
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'Wospx-Qz/vim-snippets'
Plug 'neoclide/coc.nvim',{'branch':'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'img-paste-devs/img-paste.vim'
Plug 'morhetz/gruvbox'
Plug 'moll/vim-bbye' " close buffer and keep status
Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " color-style
call plug#end()

"{{{config
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

"{{{snippets
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"}}}

nnoremap <ESC><ESC> :nohl<cr>
nnoremap <F2> :NERDTree<cr> 
nnoremap <F3> :NERDTreeClose<cr>
nnoremap K o<ESC>
nnoremap <Leader>t :NERDTreeFind<cr>
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

onoremap % ?#%%<cr>y/#%%<cr>
onoremap # ?#<cr>j0v/#<cr>k
onoremap : ?:<cr>j0y/In [<cr>

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
nnoremap <c-\> yiw:call HelpAbbrToInfo()<cr>

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

" markdowm preview
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
let g:mkdp_auto_close = 0
let g:mkdp_markdown_css = "D:/MyTemplates/CSS/sspai.css"

highlight myCiteColor ctermbg=blue guifg=#bbbbbb
autocmd! BufWinEnter *.md match myCiteColor /\[@.\{-}\]/

" 设置默认图片路径 img
let g:mdip_imgdir = 'img' 
"设置默认图片名称。当图片名称没有给出时，使用默认图片名称 image
let g:mdip_imgname = 'image'
autocmd FileType markdown nnoremap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<cr><ESC>

let g:chinese_flag = 0
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


