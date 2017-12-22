if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
  echo "Skipped: Homebrew (missing: ruby, curl and/or git)"
  return
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap Goles/battery
brew update
brew upgrade


## Install packages
apps=(
  #bash-completion2
  bats
  #battery
  #coreutils
  cf-cli
  curl
  #diff-so-fancy
  #dockutil
  exercism
  #ffmpeg
  #fasd
  #gifsicle
  git
  #git-extras
  #gnu-sed --with-default-names
  #grep --with-default-names
  #hub
  httpie
  #imagemagick
  jq
  #libyaml
  #lynx
  mackup
  #nano
  node
  #oniguruma
  openssl
  #pcre
  #pandoc
  #peco
  #psgrep
  python
  #readline
  ruby
  #shellcheck
  #ssh-copy-id
  #tree
  #unar
  watchman
  wget
  #wifi-password
  yarn
)

brew install "${apps[@]}"

export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"

ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~
