# -------------------------
# environments
# -------------------------
# binary
set -x PATH /usr/local/bin $PATH
# homebrew
set -x HOMEBREW_GITHUB_API_TOKEN b5ab7ab26e945787e016db29e018c9e707b49977
# tmux
set -x TERM screen-256color
# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH
# rbenv
set -x PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1
# node
set -x PATH ./node_modules/.bin $PATH
# go
set -x PATH $HOME/.goenv/shims $PATH
goenv rehash >/dev/null ^&1

# -------------------------
# settings
# -------------------------
# hub
eval (hub alias -s)

# -------------------------
# aliases
# -------------------------
# fishシェルの再起動
alias relogin='eval $SHELL'

# vi -> vim
alias vi='vim'

# rmでゴミ箱に入れる
alias rm='rmtrash'

# -------------------------
# functions
# -------------------------
# cd後にlsを実行させる関数
function cd
  builtin cd $argv; and ls
end

# ghq管理下のリポジトリからリポートリポジトリへ遷移する関数
function hur
  ghq list | fzf | cut -d '/' -f 2,3 | xargs hub browse
end

# 移動履歴からディレクトリを選択し遷移する関数
function hcd
  z -l | fzf | awk '{ print $2 }' | read recent
  if [ $recent ]
      cd $recent
      commandline -r ''
      commandline -f repaint
  end
end

# プロセスの一覧から対象のプロセスを選択し、終了させる関数
function pkl
  ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -9
end

# git管理下のファイルをfzfで絞り込み、選択したファイルをvimで開く関数
function lvi
  git ls-files | uniq | fzf | xargs -o vim
end

# gitのブランチ一覧からブランチを選択し、そのブランチをチェックアウトする関数
function gco
  git branch | fzf | tr -d ' ' | read branch
  if [ $branch ]
    git checkout $branch
  end
  commandline -f repaint
end

# gitのブランチ一覧からブランチを選択し、そのブランチを削除する関数
function gdb
  git branch | fzf | tr -d ' ' | read branch
  if [ $branch ]
    git branch -D $branch
  end
  commandline -f repaint
end

# agで文字列を検索し、fzfで絞り込んだファイルをvimで開く関数
# ex) fvi ${検索文字列} ${検索ディレクトリ名}
function avi
  if math "2 == " (count $argv) > /dev/null
    ag $argv[1] $argv[2] | fzf | awk -F : '{print "-c " $2 " " $1}' | xargs -o vim
  end
end
