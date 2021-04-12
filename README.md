## 如何使用

移除旧配置，将本项目下的`vimrc` 复制到根目录下

```text
rm -rf ~/.vimrc
rm -rf ~/.vim

git clone https://github.com/alex-my/vimrc.git
cd vimrc
cp .vimrc ~/.vimrc
```

安装`vim-plug`做为插件管理

```text
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

安装`ctags`，如果是`mac`不使用自带的

```text
-- mac 下的安装方法
brew install ctags

-- 重启终端，查看
which ctags
/usr/local/bin/ctags
```

如果写`golang`，可以安装`gotags`

```text
-- mac 下的安装方式
brew install gotags
```

打开`~/.vimrc`，然后在命令模式下输入`PlugInstall`安装插件

需要对`YouCompleteMe`进行处理，需要事先安装`cmake`和`python3`

```text
-- mac 下的安装方式
brew install cmake
```

这里默认`YouCompleteMe`对所有语言的支持

```text
cd ~/.vim/plugged/YouCompleteMe
sudo ./install.py --all
```

过程有点费时

## 快捷键分配

- `ctrl+n`: 打开与关闭`nerdtree`
- `ctrl+j`:打开与关闭`tagbar`
- `ctrl+p`: 文件查找
- `ctrl+d`: 文件查找时，切换路径查找和文件名查找
- `ctrl+r`: 文件查找时，切换查找是否启用正则表达式

## 错误

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
