## Installing the dotfiles
To “activate” the dotfiles, you can either copy or symlink them from the home directory. Otherwise they’re just sitting there being useless.
**Beware you probably already have a .bash_profile and .gitconfig in the user folder. So please be careful here. With great power comes great responsibility. Probably it’s best to backup important files before you’re moving them around.**

Let’s assume you have the relevant dotfiles together in ~/.dotfiles. You can create a symlink from here to the directory where they are expected (usually your home directory, ~):
```bash
ln -sv “~/.dotfiles/runcom/.bash_profile” ~
ln -sv “~/.dotfiles/runcom/.inputrc” ~
ln -sv “~/.dotfiles/git/.gitconfig” ~
```
We already have the core of a dotfiles setup.


## Installation Script
You may want to have an installation script to automate symlinking the dotfiles in the repo to your home directory. But there’s more we can put in a script that we run once to install a new system. See this install.sh for an example. Also make sure to check out other people’s scripts for more ideas and inspiration.

To install the dotfiles on a new system, we can do so easily by cloning the repo:
```bash
git clone https://github.com/slipperypenguin/dotfiles.git
cd dotfiles
```
Then do the symlinking (either manually or with a script), et voilà!
