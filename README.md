breadcrumb.vim
==============

`breadcrumb.vim`は、折畳階層に関する情報を表示します。

## インストール

ダウンロードした[zipファイル](https://github.com/1995hnagamin/vim-breadcrumb/releases)を
`~/.vim/plugin`以下に展開してください。
詳細については、[:help add-global-plugin](http://vim-jp.org/vimdoc-ja/usr_05.html#add-global-plugin)を参照してください。

### dein.vim

[dein.vim](https://github.com/Shougo/dein.vim)を使う場合、
vimrcに次の1行を追加してください。

```
call dein#add('1995hnagamin/vim-breadcrumb')
```

### vim-plug

[vim-plug](https://github.com/junegunn/vim-plug)を使う場合、
vimrcに次の1行を追加してください。

```
Plug '1995hnagamin/vim-breadcrumb'
```

## 使い方

現在行の折畳階層に関する情報を見る場合、次のコマンドを実行してください。

```
:BreadcrumbEchoMsg
```

## ライセンス

修正BSDライセンス

## 開発者

NAGAMINE Hideaki (github.com/1995hnagamin)
