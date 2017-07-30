# dotfiles

## Usage
### Setup
```
$ ./setup.sh
```

### Install brew files
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew bundle
```

### Install fish plugins
```
$ curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisherman
$ cd ~/.config/fish/functions
$ fisher
```
