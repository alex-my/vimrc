"
" vim 配置文件 2024-0309
" 
" version: 0.2.0
"
" 配置项文档: https://vimdoc.sourceforge.net/htmldoc/options.html
" coc.nvim 文档: https://github.com/neoclide/coc.nvim

" ====================================================================>
" ------------------------------ 基本配置 ------------------------------

" 开启文件类型检查，并使用对应的缩进规则
filetype indent on

" 在插入模式下使用退格键删除
set bs=2

" 使用 utf-8 编码
set encoding=utf8

" 允许使用鼠标
set mouse=a

" 输入文本时候隐藏鼠标
set mousehide

" 不与 vi 兼容
set nocompatible

" 启用 256 色
set t_Co=2556
set termguicolors

" 语法高亮
syntax on

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

" ------------------------------ 缩进 ------------------------------
" 自动缩进，下一行会与上一行的缩进保持一致
set autoindent

" 制表符宽度
set tabstop=4
set softtabstop=4

" 缩进时，每一级字符数
set shiftwidth=4

" 将 tap 转为空格
set expandtab

" 自动缩进宽度
set sw=4

" ------------------------------ 显示 ------------------------------
" 显示行号
set number

" 底部状态栏显示光标当前位置
set ruler

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

" 高亮显示当前行
set cursorline

" 底部是否显示状态栏，0 不显示，1 多窗口时显示，2 一直显示
set laststatus=2

" 底部显示当前输入的命令
set showcmd

" 底部显示当前状态: 插入、可视
set showmode

" 垂直滚动时，光标距离顶部/底部的行数
set scrolloff=5

" 水平滚动时，光标距离行首/行尾的字符数
set sidescrolloff=15

" ------------------------------ 搜索 ------------------------------
" 光标遇到括号时，自动高亮另一个
set showmatch

" 高亮显示被搜索到的文本
" set hlsearch

" ------------------------------ 临时文件 ------------------------------
" 不创建交换文件 .swap
set noswapfile

" 不创建备份文件
set nobackup

" 保留操作历史，即使文件重新打开，仍然有效，生成一个 .un-文件名 的隐藏文件
set undofile

" 操作历史文件保存位置
set undodir=~/.vim/.undo

" 
" ====================================================================>
" ------------------------------ 管理 ------------------------------
"
" 
" vim-plug 插件管理，此处安装所有插件
" 
" 命令:
" PlugInstall 	安装插件
" PlugUpdate	安装或者更新插件
" PlugClean 	移除未使用的插件
" PlugUpgrade 	更新 vim-plug 自己
" PlugStatus 	检查插件状态
"
" 列出安装的插件，并指定安装目录
call plug#begin('~/.vim/plugged')
	" 代码补全工具
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " 代码片段工具
	Plug 'honza/vim-snippets'
    " 状态栏美化
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
    " 工程目录树
	Plug 'preservim/nerdtree'
    " 配合 nerdtree 显示 git 信息
	Plug 'Xuyuanp/nerdtree-git-plugin'
    " 文件搜索
	Plug 'ctrlpvim/ctrlp.vim'
    " 配色方案
	" Plug 'flazz/vim-colorschemes'
    Plug 'ajmwagar/vim-deus'
    " 括号着色
	Plug 'kien/rainbow_parentheses.vim'
call plug#end()

" ------------------------------ vim-plug ------------------------------

" ------------------------------ 补全提示按钮
" `TAB`: 向后选择
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

" `SHIFT+TAB`: 向前选择
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" `ENTER`: 选中当前补全
inoremap <silent><expr> <CR> 
    \ coc#pum#visible() ? coc#pum#confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ------------------------------ 诊断
" `[+g` 向前跳转到诊断信息
nmap <silent> [g <Plug>(coc-diagnostic-prev)

" `]+g` 向后跳转到诊断信息
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" ------------------------------ 跳转
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" `K` 显示目标的文档注释
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" ------------------------------ 选择
" 快速选中函数内部 internal function
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)

" 快速选中整个函数 all function
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" 快速选中类内部 internal class
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)

" 快速选中整个类 all class
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" 选中全部
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" ------------------------------ 其它
" 自动高亮当前指向的目标及其引用
autocmd CursorHold * silent call CocActionAsync('highlight')

" 重命名
nmap <leader>rn <Plug>(coc-rename)

" 选中部分格式化
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " 按照文件类型指定格式化工具
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 选中部分额外执行命令
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" 当前指定部分额外执行命令
nmap <leader>ac  <Plug>(coc-codeaction-cursor)

" 当前文件额外命令，例如 Generate Getters and Setters
nmap <leader>as  <Plug>(coc-codeaction-source)

" 快速修复
nmap <leader>qf  <Plug>(coc-fix-current)

" 重构
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" 获取代码长度
nmap <leader>cl  <Plug>(coc-codelens-action)

" 添加格式化命令 :Format
command! -nargs=0 Format :call CocActionAsync('format')

" 添加折叠命令 :Fold
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" 添加导入引用命令 :OR
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" ------------------------------ 子插件管理
" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ------------------------------ 子插件配置
" coc-explorer
" 打开或关闭目录树
nmap <space>e <Cmd>CocCommand explorer<CR>

let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'tab:$': {
\     'position': 'tab:$',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" 快速跳转
nmap <space>ed <Cmd>CocCommand explorer --preset .vim<CR>
nmap <space>ef <Cmd>CocCommand explorer --preset floating<CR>
nmap <space>ec <Cmd>CocCommand explorer --preset cocConfig<CR>
nmap <space>eb <Cmd>CocCommand explorer --preset buffer<CR>

" 所有快速跳转命令
nmap <space>el <Cmd>CocList explPresets<CR>


" ------------------------------ nerdtree 生成工程目录树 ------------------------------
" 打开和关闭 nerdtree
nmap <C-n> :NERDTreeToggle <CR>
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

" ------------------------------ nerdtree-git-plugin 在工程目录树中显示 git 信息 ------------------------------
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

" ------------------------------ ctrlp 文件查找 ------------------------------
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

" ------------------------------ vim-colorschemes/vim-deus 配色方案 ------------------------------
" 配色方案见 https://vimcolorschemes.com/
" 配色方案见  https://github.com/ajmwagar/vim-deus
"
" 当前选择 vim-deus
set background=dark
colorscheme deus
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:deus_termcolors=256

" ------------------------------ rainbow_parentheses.vim 括号配色 ------------------------------
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