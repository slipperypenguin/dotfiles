# dotfiles
![dotfiles](https://i.imgur.com/wKDfQxw.png)


This is my dotfiles setup for macOS. It is still a work in progress.

## Package overview
* Core
  * Bash
  * [Homebrew](https://brew.sh) + [homebrew-cask](https://caskroom.github.io)
  * Node.js + npm LTS
  * GNU [sed](https://www.gnu.org/software/sed/), [grep](https://www.gnu.org/software/grep/), [Wget](https://www.gnu.org/software/wget/)
  * Latest Git, Python 3, GNU coreutils, curl
  * `$EDITOR` is [atom](https://atom.io)
  * Git editor is [nano](https://www.nano-editor.org)
* Development (Node/JS/JSON): [jq](https://stedolan.github.io/jq),
* macOS: [dockutil](https://github.com/kcrawford/dockutil), [Mackup](https://github.com/lra/mackup), [Quick Look plugins](https://github.com/sindresorhus/quick-look-plugins)
* [macOS apps](https://github.com/slipperypenguin/dotfiles/blob/master/install/brew-cask.sh)


## Install
On a sparkling fresh installation of macOS:
```bash
    sudo softwareupdate -i -a
    xcode-select --install
```

The Xcode Command Line Tools includes git and make (not available on stock macOS). Then, install this repo with `curl` available:
```bash
bash -c "`curl -fsSL https://raw.githubusercontent.com/slipperypenguin/dotfiles/master/remote-install.sh`"
```

This will clone (using `git`), or download (using `curl` or `wget`), this repo to ``~/.dotfiles`. Alternatively, clone manually into the desired location:

```bash
git clone https://github.com/slipperypenguin/dotfiles.git ~/.dotfiles
source ~/.dotfiles/install.sh
```

## The `dotfiles` command
```bash
    $ dotfiles help
    Usage: dotfiles <command>

    Commands:
       clean            Clean up caches (brew, npm, gem, rvm)
       dock             Apply macOS Dock settings
       edit             Open dotfiles in IDE (code) and Git GUI (stree)
       help             This help message
       macos            Apply macOS system defaults
       test             Run tests
       update           Update packages and pkg managers (OS, brew, npm, gem)
```

## Customize/extend
You can put your custom settings, such as Git credentials in the `system/.custom` file which will be sourced from `.bash_profile` automatically. This file is in `.gitignore`.

Alternatively, you can have an additional, personal dotfiles repo at `~/.extra`.

* The runcom `.bash_profile` sources all `~/.extra/runcom/*.sh` files.
* The installer (`install.sh`) will run `~/.extra/install.sh`.


## Additional resources
* [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Homebrew](https://brew.sh)
* [homebrew-cask](https://caskroom.github.io) / [usage](https://github.com/phinze/homebrew-cask/blob/master/USAGE.md)
* [Bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [Solarized Color Theme for GNU ls](https://github.com/seebi/dircolors-solarized)


## Credits
Many thanks to the [dotfiles community](https://dotfiles.github.io) and [webpro](https://github.com/webpro/dotfiles) for the [guide](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)
