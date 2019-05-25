# In a Bash shell, this file (or .profile) is loaded first.
# This is a small .bash_profile that links to several others that have a dedicated purpose
#   i.e. one file for the aliases, one for the functions, etc.


## If not running interactively, don't do anything
[ -z "$PS1" ] && return


## Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)
READLINK=$(which greadlink 2>/dev/null || which readlink)
CURRENT_SCRIPT=$BASH_SOURCE

if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
  SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
  DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi


## Make utilities available
PATH="$DOTFILES_DIR/bin:$PATH"


## source the dotfiles (order matters)
for DOTFILE in "$DOTFILES_DIR"/system/.{function,function_*,path,env,alias,grep,nvm,completion,custom}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

if is-macos; then
  for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function,path}.macos; do
    [ -f "$DOTFILE" ] && . "$DOTFILE"
  done
fi


##
### Colors
##
## Change bash prompt to be colorized, rearranges prompt to be: "@username:cwd $ "
export PS1="@\[\033[36m\]\u\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "

## Add k8s helper to PS1
## "@username:cwd$ (kube-ps1) "
PS1=$PS1'$(kube_ps1) '

## Enable command line colors, define colors for the 'ls' command
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

## Makes reading directory listings easier
## -G: colorize output, -h: sizes human readable, -F: throws a / after a directory, * after an executable, and a @ after a symlink
alias ls='ls -GFh'

## Set LSCOLORS
eval "$(dircolors -b "$DOTFILES_DIR"/system/.dir_colors)"



## Hook for extra/custom stuff
DOTFILES_EXTRA_DIR="$HOME/.extra"

if [ -d "$DOTFILES_EXTRA_DIR" ]; then
  for EXTRAFILE in "$DOTFILES_EXTRA_DIR"/runcom/*.sh; do
    [ -f "$EXTRAFILE" ] && . "$EXTRAFILE"
  done
fi


## Clean up
unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE EXTRAFILE


## Export
export DOTFILES_DIR DOTFILES_EXTRA_DIR
