call plug#begin('~\AppData\Local\nvim\plugged')
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'SirVer/ultisnips'
Plug 'Wospx-Qz/vim-snippets'
Plug 'neoclide/coc.nvim',{'branch':'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'img-paste-devs/img-paste.vim'
Plug 'moll/vim-bbye' " close buffer and keep status
Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " color-style
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

let g:python_host_skip_check = 1 
let g:python3_host_skip_check = 1
let g:python_host_prog  = 'D:\Users\qiaoz12\AppData\Local\anaconda3\python.exe'
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
let g:startify_custom_header = ['Wospx']
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
nnoremap <Leader>j :s/\v[,.] \|[，。；：、]/\0\r/g<cr>:nohl<cr>{j
nnoremap <leader>k vip:s/\n//g<cr>:nohl<cr>0
"nnoremap <c-cr> :vs<cr><c-w><c-w>:term ipython<cr>a<c-\><c-n><c-w><c-w>
nnoremap <c-cr> :vs<cr><c-w><c-w>:call Openipython()<cr>a<c-\><c-n><c-w><c-w>
nnoremap <Leader><Leader> :b ipython <cr>a<c-w><c-v><cr><c-\><c-n><c-^><ESC><c-w><c-p>a<c-\><c-n><c-w><c-p>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"nnoremap <leader><Enter> :call Ipyrun()<cr>:call Ipyrun()<cr>:b ipython <cr>a<c-w><c-v><cr><c-\><c-n><c-^>
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

function! Openipython()
try
	exe "bd!ipython"
	exe "term ipython"
catch
	exe "term ipython"
endtry
endfunction

function! Ipyrun()
let l:filename = '%run '..expand('%:t:r')
let @+ = l:filename
endfunction

function! Ab2In()
call system('python -m wospx.quickinput '..@c)
echo 'python -m wospx.quickinput '..@c
endfunction
nnoremap <c-/> "cyiw :call Ab2In()<cr>


" markdowm preview
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
let g:mkdp_auto_close = 0


" default image path img
let g:mdip_imgdir = 'img' 
" default image name
let g:mdip_imgname = 'image'
autocmd FileType markdown nnoremap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<cr><ESC>

let g:chinese_flag = 0

autocmd WinEnter,VimEnter *.py let g:chinese_flag = 1
autocmd WinEnter,VimEnter *.json let g:chinese_flag = 0
autocmd WinEnter,VimEnter *.md let g:chinese_flag = 0

autocmd! VimEnter * call ChaLangENCN(0)

autocmd! InsertEnter * call ChaLangENCN(1)
autocmd! InsertLeave * call ChaLangENCN(0)
"

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


autocmd! BufWinEnter *.md match myCiteColor /\[@.\{-}\]/
highlight myCiteColor ctermbg=blue guifg=#bbbbbb
highlight Folded guibg=#eff1f5 guifg=#006699
highlight FoldColumn guibg=#eff1f5 guifg=#c5d0e1

let g:markdown_folding = 0
let g:markdown_enable_folding = 1

nnoremap <leader>d :call system('python -m wospx.pandoctool ' .. expand('%:p') .. ' -1')<cr>
nnoremap <leader>t :call system('python -m wospx.pandoctool ' .. expand('%:p') .. ' 0')<cr>
nnoremap <leader>T :call system('python -m wospx.pandoctool ' .. expand('%:p') .. ' 1')<cr>



