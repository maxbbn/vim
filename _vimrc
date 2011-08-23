""""""""""""""""""""""""""""""""""
"  @ bbn' vim rc
"
"        Author: maxbbn(qipbbn@gmail.com)
"       Website: http://www.maxbbn.com
"         Since: 2011-01-08
" Last Modified: 2011-01-08
"
""""""""""""""""""""""""""""""""""
" 获取当前目录
func! GetPWD()
    return substitute(getcwd(), "", "", "g")
endf

func! MySys()
    return "linux"
endf
" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vim/_vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim/_vimrc

" 行控制
set linebreak " 英文单词在换行时不被截断
set nocompatible " 设置不兼容VI
set wrap " 设置自动折行

" 保留历史记录
set history=700

" 标签页
set tabpagemax=15 " 最多15个标签
set showtabline=2 " 总是显示标签栏

" 关闭遇到错误时的声音提示
set noerrorbells
set novisualbell
set t_vb= " close visual bell

" 行号和标尺
set ruler " 显示标尺
set number " 行号
set rulerformat=%15(%c%V\ %p%%%)

"搜索
set hlsearch  " 高亮显示搜索的内容
set noincsearch " 关闭显示查找匹配过程
set magic "Set magic on, for regular expressions

" 命令行于状态行
set cmdheight=1 " 设置命令行的高度
set laststatus=2 " 始终显示状态行
set stl=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ [PWD]\ %r%{GetPWD()}%h\ %=\ [Line]%l/%L\ %=\[%P] "设置状态栏的信息

" 制表符(设置所有的tab和缩进为4个空格)
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab "使用空格来替换tab
set smarttab

" 状态栏显示目前所执行的指令
set showcmd

" 缩进
set autoindent " 设置自动缩进
set smartindent " 设置智能缩进

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start

set mouse=a

" 自动完成
set complete=.,w,b,k,t,i
set completeopt=longest,menu " 只在下拉菜单中显示匹配项目，并且会自动插入所有匹配项目的相同文本

" 代码折叠
set foldmethod=indent

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" 显示tab和空格
set list
" 设置tab和空格样式
set listchars=tab:\|\ ,nbsp:%,trail:-

" 设定行首tab为灰色
highlight LeaderTab guifg=#666666
" 匹配行首tab
match LeaderTab /\t/

set wildmenu "打开 wildmenu 选项，启动具有菜单项提示的命令行自动完成。
set matchpairs=(:),{:},[:],<:>
set whichwrap=b,s,<,>,[,]

" 搜索时智能大小写
set ignorecase
set smartcase

"
set clipboard+=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"Persistent undo
try
    if MySys() == "windows"
      set undodir=C:\Windows\Temp
    else
      set undodir=~/.vim_runtime/undodir
    endif

    set undofile
catch
endtry

" Set hidden to undo buffer
set hidden



" =====================
"    默认为 UTF-8 编码
" =====================
if has("multi_byte")
    set encoding=utf-8
    " English messages only
    "language messages zh_CN.utf-8
    if has('win32')
        language english
        let &termencoding=&encoding " 处理consle输出乱码
    endif

    set fencs=utf-8,gbk,chinese,latin1
    set formatoptions+=mM
    set nobomb " 不使用 Unicode 签名

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" =====================
" 主题配色
" =====================
if has('syntax')
    " 保证语法高亮
    syntax on

    if has('gui_running')
        colorscheme zenburn

        let g:colors_name="zenburn"
    endif

    " 默认编辑器配色
    " au BufNewFile,BufRead,BufEnter,WinEnter * colo yytextmate

    " 各不同类型的文件配色不同
    "au BufNewFile,BufRead,BufEnter,WinEnter *.wiki colo moria

    au BufNewFile,BufRead *.less set filetype=less
endif

" =====================
" 图形界面
" =====================
if has('gui_running')
    "set guioptions=mcr " 只显示菜单
    "set guioptions=   " 隐藏全部的gui选项
    "set guioptions+=r " 显示gui右边滚动条
    "Toggle Menu and Toolbar 使用F2隐藏/显示菜单
    set guioptions-=m
    set guioptions-=T
    map <silent> <F3> :if &guioptions =~# 'T' <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=m <bar>
        \else <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=m <Bar>
        \endif<CR>

    "if has("unix") && !has('gui_macvim')
        "set guifont=Courier\ 11\ Pitch\ 12
    "endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Map space to / (search) and c-space to ? (backgwards search)
" map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Tab configuration
map <C-t> :tabnew<cr>
map <C-k> :tabclose<cr>
map <C-Tab> :tabnext<cr>
map <C-n> :tabnext<cr>
map <C-S-Tab> :tabprevious<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2
catch
endtry

" =====================
"  插件配置
" =====================
"zencoding
let g:user_zen_settings = {
\  'indentation' : '    ',
\  'lang' : 'zh-CN',
\}
let g:user_zen_expandabbr_key = '<c-e>'
let g:use_zen_complete_tag = 1

"NERD_commenter
let NERDShutUp = 1
map <c-h> ,c<space>

"neo complomplache
let g:neocomplcache_min_syntax_length = 3

"web indent
let g:js_indent_log = 0
