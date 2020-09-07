"
" vim 配置文件 2020-0906
" 
" version: 0.1.0
" 
" ------------------------------ basic ------------------------------
" 不与 vi 兼容
set nocompatible

" 语法高亮
syntax on
" 底部显示当前状态: 插入、可视
set showmode
" 底部是否显示状态栏，0 不显示，1 多窗口时显示，2 一直显示
set laststatus=2
" 底部状态栏显示光标当前位置
set ruler
" 底部显示当前输入的命令
set showcmd

" 使用 utf-8 编码
set encoding=utf8

" 允许使用鼠标
set mouse=a
" 输入文本时候隐藏鼠标
set mousehide


" 高亮显示当前行
set cursorline
" 高亮显示被搜索到的文本
set hlsearch
" 光标遇到括号时，自动高亮另一个
set showmatch

" 显示行号
set number
" 行与行之间没有空行
set linespace=0
" 一行显示多少字符
set textwidth=120
" 自动折行，一行太长分成几行显示，但仍然属于同一行
set wrap
" 禁止在单词中分行，只有遇到比如空格、连词号等标点符号才会换行
set linebreak
" 折行处与编辑窗口右侧边缘之间空出的字符数
set wrapmargin=2
" 垂直滚动时，光标距离顶部/底部的行数
set scrolloff=5
" 水平滚动时，光标距离行首/行尾的字符数
set sidescrolloff=15

" 自动缩进，下一行会与上一行的缩进保持一致
set autoindent
" 自动缩进宽度
set sw=4
" 制表符宽度
set tabstop=4
" 开启文件类型检查，并使用对应的缩进规则
filetype indent on

" 在插入模式下使用退格键删除
set bs=2
" 不创建交换文件 .swap
set noswapfile
" 不创建备份文件
set nobackup
" 保留操作历史，即使文件重新打开，仍然有效，生成一个 .un-文件名 的隐藏文件
set undofile
" 操作历史文件保存位置
set undodir=~/.vim/.undo
" 历史记录数量
set history=1000

" 自动切换工作目录，打开多文件时，默认的工作目录是第一个文件所在的目录
set autochdir
" 出错时，不要发出声音
set noerrorbells
" 出错时，发出视觉提示，比如屏幕闪烁
set visualbell
" 打开文件监视，外部发生了改变时发出提示
set autoread
" 命令模式下，tab 自动补全
set wildmenu
set wildmode=longest:list,full



" ------------------------------ basic plugin ------------------------------
" vim-plug 插件管理，此处安装所有插件
" 
" 命令:
" PlugInstall 	安装插件
" PlugUpdate	安装或者更新插件
" PlugClean 	移除未使用的插件
" PlugUpgrade 	更新 vim-plug 自己
" PlugStatus 	检查插件状态
"
filetype off

" 列出安装的插件，并指定安装目录
call plug#begin('~/.vim/plugged')

	" 生成工程目录树
	Plug 'preservim/nerdtree'
	" 配合 nerdtree 显示 git 信息
	Plug 'Xuyuanp/nerdtree-git-plugin'
	" 生成函数、变量列表
	Plug 'majutsushi/tagbar'
	" 文件搜索
	Plug 'ctrlpvim/ctrlp.vim'
	" 状态栏美化
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	" 快速对文本添加括号、引号等
	Plug 'tpope/vim-surround' 
	" 语法检查
	Plug 'vim-syntastic/syntastic'
	" 代码片段工具
	Plug 'SirVer/ultisnips'	
	" 配色方案
	Plug 'flazz/vim-colorschemes'
	" 代码补全工具
	Plug 'ycm-core/YouCompleteMe'
	" 括号着色
	Plug 'kien/rainbow_parentheses.vim'
	" git 使用
	Plug 'scrooloose/vim-fugitive'
	" markdown
	Plug 'plasticboy/vim-markdown'
	" golang 插件
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


call plug#end()

filetype on
filetype plugin on
filetype plugin indent on

" >>>>>>>>>>>>>>>>>> nerdtree 生成工程目录树 >>>>>>>>>>>>>>>>>>
" 打开和关闭 nerdtree
map <C-n> :NERDTreeToggle <CR>
" 当只剩下 nerdtree 时自动关闭窗口
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 设置宽度
let NERDTreeWinSize=30
" 设置位置 left | right
let NERDTreeWinPos='left'
" 打开文件后是否关闭 nerdtree，0 不关闭，1 关闭
let NERDTreeQuitOnOpen=0
" 是否显示文件，0 只显示文件夹，1 显示文件
let NERDTreeShowFiles=1
" 是否显示隐藏文件，0 不显示，1 显示
let NERDTreeShowHidden=1
" 是否显示行号，0 不显示，1 显示
let NERDTreeShowLineNumbers=1
" 忽略显示
let NERDTreeIgnore=['\~$','.DS_Store']

" >>>>>>>>>>>>>>>>>> nerdtree-git-plugin 在工程目录树中显示 git 信息 >>>>>>>>>>>>>>>>>>
let g:NERDTreeGitStatusIndicatorMapCustom = {
	\ 'Modified'  :'✹',
	\ 'Staged'    :'✚',
	\ 'Untracked' :'✭',
	\ 'Renamed'   :'➜',
	\ 'Unmerged'  :'═',
	\ 'Deleted'   :'✖',
	\ 'Dirty'     :'✗',
	\ 'Ignored'   :'☒',
	\ 'Clean'     :'✔︎',
	\ 'Unknown'   :'?',
	\ }

" >>>>>>>>>>>>>>>>>> tagbar 生成函数、变量列表 >>>>>>>>>>>>>>>>>>
" 打开和关闭 tagbar
map <C-j> :TagbarToggle <CR>
" 设置 ctags,需要 ctags 支持，在 mac 下，需要自行另外安装一个，不要自带的 brew install ctags
" 设置路径，使用 which ctags
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
" 设置宽度
let g:tagbar_width=30
" 设置位置 
let g:tagbar_right=1
" 自动打开 tagbar
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.go,*.java,*.py call tagbar#autoopen()
" 配置 gotags，不再需要手动 ctags -R。要安装 gotags，brew install gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


" >>>>>>>>>>>>>>>>>> ctrlp 文件查找 >>>>>>>>>>>>>>>>>>
" 查找的快捷键
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" 以.git、.svn或者当前文件所在目录做为搜索范围，加快查找速度
let g:ctrlp_working_path_mode = 'ra'
" 窗口显示的数目
let g:ctrlp_max_height = 30
let g:ctrlp_match_window_reversed = 0
" 最近最多使用的数量 MRU
let g:ctrlp_mruf_max = 500
" 设置使用文件名搜索，而不是按全路径，可以使用 ctrl + d 切换
let g:ctrlp_by_filename = 1
" 搜索时，不使用正则表达式，设置为 1 时使用正则表达式，可以使用 ctrl + r 切换
let g:ctrlp_regexp = 0
" 忽略查找的目录
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_custom_ignore = '\v[\/](node_modules|coverage|target|dist|vendor)|(\.(swp|ico|git|svn|png|jpg|gif|ttf))$'

" >>>>>>>>>>>>>>>>>> syntastic 语法检查 >>>>>>>>>>>>>>>>>>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" >>>>>>>>>>>>>>>>>> vim-go golang 插件 >>>>>>>>>>>>>>>>>>
" >>>>>>>>>>>>>>>>>> ultisnips 代码片段工具 >>>>>>>>>>>>>>>>>>
" >>>>>>>>>>>>>>>>>> youcompleteme 代码补全工具 >>>>>>>>>>>>>>>>>>
" 下载安装之后，需要进入目录.vim/plugged/YouCompleteMe 执行脚本
" 事先依赖 cmake 和 python3，需要事前安装
" sudo ./install.py --all


" >>>>>>>>>>>>>>>>>> vim-colorschemes 配色方案 >>>>>>>>>>>>>>>>>>
colorscheme Dark2


" >>>>>>>>>>>>>>>>>> rainbow_parentheses.vim 括号配色 >>>>>>>>>>>>>>>>>>
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
