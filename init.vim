call plug#begin('C:\Users\Wospx\AppData\Local\nvim\plugged')
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ZSaberLv0/ZFVimIM'
Plug 'ZSaberLv0/ZFVimJob'
Plug 'ZSaberLv0/ZFVimIM_openapi'
"Plug 'godlygeek/tabular' "必要插件，安装在vim-markdown前面
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"Plug 'plasticboy/vim-markdown'
"Plug 'ferrine/md-img-paste.vim' 
"Plug 'yinflying/matlab.vim'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'Wospx-Qz/vim-snippets'
"Plug 'BurntSushi/ripgrep'
"Plug 'sharkdp/fd'
"Plug 'nvim-treesitter/nvim-treesitter'
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim',{'branch':'release'}
"Plug 'jpalardy/vim-slime'
"Plug 'sillybun/vim-repl'
"Plug 'hkupty/iron.nvim'
"Plug 'Neur1n/neuims'
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
"保存折叠信息
"autocmd BufWinLeave *.m mkview
"autocmd BufWinLeave *.md mkview
"autocmd BufWinLeave *.txt mkview
"autocmd BufWinLeave *.tex mkview
"autocmd BufWinLeave *.vim mkview
"}}}

"{{{ZFVimIM
let g:ZFVimIM_openapi_enable=1
let g:ZFVimIM_symbolMap = {
            \   '!' : ['！'],
            \   '-' : ['-'],
            \   '_' : ['——'],
            \   '(' : ['（'],
            \   ')' : ['）'],
            \   '[' : ['['],
            \   ']' : [']'],
            \   ',' : ['，'],
            \   '.' : ['。'],
            \   '<' : ['《'],
            \   '>' : ['》'],
            \   '/' : ['/'],
            \   ';' : ['；'],
            \   ':' : ['：'],
            \   '?' : ['？'],
            \   "'" : ['‘', '’'],
            \   '"' : ['“', '”'],
            \ }


function! s:myLocalDb()
    let db = ZFVimIM_dbInit({
                \   'name' : 'QZdb',
                \ })
    call ZFVimIM_cloudRegister({
                \   'mode' : 'local',
                \   'dbId' : db['dbId'],
                \   'repoPath' : 'C:\Users\Wospx\AppData\Local\nvim\db',
                \   'dbFile' : '/pinyin_huge.txt', 
                \   'dbCountFile' : '/pinyin_huge_count.txt', 
                \ })
endfunction
autocmd User ZFVimIM_event_OnDbInit call s:myLocalDb()
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

"easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nnoremap <Leader>f <Plug>(easymotion-overwin-f)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 2

" JK motions: Line motions
nnoremap <Leader>j <Plug>(easymotion-j)
nnoremap <Leader>k <Plug>(easymotion-k)

	


"{{{mapping
inoremap jj <ESC>
nnoremap <ESC><ESC> :nohl<cr>
"nnoremap <F2> :Startify<cr> 
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
