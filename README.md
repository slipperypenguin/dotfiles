# dotfiles
![dotfiles](https://i.imgur.com/wKDfQxw.png)


These are my dotfiles. It is setup for macOS and Linux

## Package overview
* Bash
* [Homebrew](https://brew.sh) (packages: [Brewfile](./install/Brewfile))
* [homebrew-cask](https://caskroom.github.io) (packages: [Caskfile](./install/Caskfile))
* Node.js + npm LTS (packages: [npmfile](./install/npmfile))
* Latest Ruby (packages: [Gemfile](./install/Gemfile))
* Latest Git, Bash 4, Python 3, GNU coreutils, curl
* [Mackup](https://github.com/lra/mackup) (sync application settings)
* `$EDITOR` (and Git editor) is [GNU nano](https://www.nano-editor.org)
* IDE is [atom](https://atom.io)
* Development (Go/Kubernetes/Node/JS)

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
```

Use the [Makefile](./Makefile) to install everything [listed above](#package-overview), and symlink [runcom](./runcom) and [config](./config) (using [stow](https://www.gnu.org/software/stow/)):

```bash
$ cd ~/.dotfiles
$ make
```


## Post-install
- `dotfiles dock` (set [Dock items](./macos/dock.sh))
- `dotfiles macos` (set [macOS defaults](./macos/defaults.sh))
- Mackup
  - Log in to iCloud (and wait until synced)
  - `ln -s ~/.config/mackup/.mackup.cfg ~` (until [#632](https://github.com/lra/mackup/pull/632) is fixed)
  - `mackup restore`



## The `dotfiles` command
```bash
    $ dotfiles help
    Usage: dotfiles <command>

    Commands:
       clean            Clean up caches (brew, npm, gem)
       dock             Apply macOS Dock settings
       edit             Open dotfiles in IDE (atom) and Git GUI (nano)
       help             This help message
       macos            Apply macOS system defaults
       test             Run tests
       update           Update packages and pkg managers (OS, brew, npm, gem)
```

## Customize/extend
You can put your custom settings, such as Git credentials in the `system/.custom` file which will be sourced from `.bash_profile` automatically. This file is in `.gitignore`.

Alternatively, you can have an additional, personal dotfiles repo at `~/.extra`. The runcom `.bash_profile` sources all `~/.extra/runcom/*.sh` files.



## Additional resources
* [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Homebrew](https://brew.sh)
* [homebrew-cask](https://caskroom.github.io) / [usage](https://github.com/phinze/homebrew-cask/blob/master/USAGE.md)
* [Bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)



## Credits
Many thanks to the [dotfiles community](https://dotfiles.github.io) and [webpro](https://github.com/webpro/dotfiles) for the [guide](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)
