# 1 如何使用

- 移除旧配置，将本项目下的`vimrc` 复制到根目录下

  ```text
  rm -rf ~/.vim*
  rm -rf ~/.config/coc

  git clone https://github.com/alex-my/vimrc.git
  cd vimrc
  cp .vimrc ~/.vimrc
  ```

- 安装`vim-plug`做为插件管理

  ```text
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```

- 打开`~/.vimrc`，然后在命令模式下输入`PlugInstall`安装插件

## coc.vim

安装一个插件对`coc`的插件进行管理

```text
-- 安装
:CocInstall coc-marketplace

-- 打开管理面板
:CocList marketplace

-- 安装插件
:CocList marketplace python
```

已安装插件列表

```text
-- ~/.config/coc/extensions/package.json
{
  "dependencies": {
    "coc-json": ">=1.9.2",
    "coc-snippets": ">=3.1.10",
    "coc-java": ">=1.15.2",
    "coc-go": ">=1.3.33",
    "coc-marketplace": ">=1.9.0",
    "coc-emmet": ">=1.1.6",
    "coc-pairs": ">=1.4.2",
    "coc-lists": ">=1.5.1",
    "coc-git": ">=2.7.0",
    "coc-sh": ">=1.2.2",
    "coc-explorer": ">=0.26.6"
  }
}
```

插件升级

```text
CocUpdate
```

插件卸载

```text
CocUninstall coc-json
```

coc.vim 配置

```json
-- ~/.vim/coc-settings.json

{
  "languageserver": {
    "golang": {
      "command": "gopls",
      "rootPatterns": ["go.mod", ".git/"],
      "filetypes": ["go"]
    }
  },
  "java.jdt.ls.java.home":"/usr/local/opt/openjdk/libexec/openjdk.jdk/Contents/Home",
  "java.format.enabled": true,
  "java.completion.guessMethodArguments": true,
  "java.completion.autoImport": true
}
```

# 2 快捷键分配

## 2.1 补全

- `tab`: 向后查找
- `shift+tab`: 向前查找
- `enter`: 选中

## 2.2 诊断

- `[+g`: 向前跳转到诊断信息
- `]+g`: 向后跳转到诊断信息

## 2.3 跳转

- `g+d`: 跳转到定义
- `g+t`: 跳转到类型定义
- `g+i`: 跳转到实现
- `g+r`: 跳转到引用

## 2.4 文档

- `K`: 显示目标定义时的注释

## 2.5 选中

可视操作时

- `i+f`: 快速选中函数内部 internal function
- `a+f`: 快速选中整个函数 all function
- `i+c`: 快速选中类内部 internal class
- `a+c`: 快速选中整个类 all class
- `ctrl+s`: 选中全部

## 2.6 命令

- `:Format`: 格式化文件
- `:Fold`: 折叠
- `:OR`: 添加导入引用命令

## 2.7 打开目录

- `space+e`: coc-explorer 提供的目录树

## 2.7 杂项

- `\+rn`: 重命名
- `\+f`: 格式化选中的内容
- `\+a'`: 选中部分执行 `actions`
- `\+c`: 当前指向执行 `actions`
- `\+s`: 当前文件执行 `actions`
- `\+q+f`: 执行快速修复
- `\+re`: 当期文件重构
- `\+r`: 选中部分重构
- `\+c+l`: 获取代码长度

## 2.8 其它插件

- `ctrl+n`: 打开与关闭`nerdtree`
- `ctrl+p`: 文件查找
- `ctrl+d`: 文件查找时，切换路径查找和文件名查找
- `ctrl+r`: 文件查找时，切换查找是否启用正则表达式

# 3 日常

- 插件管理

  ```text
  PlugUpdate 安装或者更新插件
  PlugUpgrade 更新 vim-plug 自己
  PlugClean 移除未使用的插件
  PlugStatus 检查插件状态
  ```

# 4 知识点

## 4.1 映射指令

- map: 执行时会进行递归替换
- xmap: 在可视模式下
- noremap: 执行时不会进行递归替换
- inoremap: 在输入模式下有效

## 4.2 映射参数

- <silent>: 执行过程中，不会对界面产生变化
- <expr>: 映射的是一个表达式
- <leader>: 一搬是按下 \

# 5 错误

- 使用 `vim 文件名`打开没有问题，但使用`crontab -e`等会报错

  ```text
  Error detected while processing /root/.vimrc:
  line   27:
  E538: No mouse support: mouse=a
  line   79:
  E518: Unknown option: autochdir
  line  108:
  E492: Not an editor command: ^IPlug 'preservim/nerdtree'
  line  110:
  E492: Not an editor command: ^IPlug 'Xuyuanp/nerdtree-git-plugin'
  ...
  ```

  查看默认的编辑器，发现输出为空

  ```text
  echo $EDITOR
  ```

  设置默认的编辑器为`vim`
  在`~/.bashrc`或者`~/.zshrc`添加

  ```text
  export EDITOR=vim
  ```

  执行`source ~/.bashrc` 或者 `source ~/.zshrc` 立即生效

  在执行`crontab -e`，没有发现报错了
