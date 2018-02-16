if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
  echo "Skipped: Homebrew (missing: ruby, curl and/or git)"
  return
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew upgrade


## Install packages
apps=(
  bash-completion2
  bats
  coreutils
  couchdb
  curl
  dockutil
  exercism
  gdbm
  git
  #git-extras
  gnu-sed --with-default-names
  grep --with-default-names
  httpie
  icu4c
  jq
  libyaml
  mackup
  mongodb
  #nano
  node
  oniguruma
  openssl
  osquery
  pcre
  pkg-config
  python
  python3
  readline
  ruby
  sqlite
  #tree
  watchman
  wget
  #wifi-password
  yarn
)

brew install "${apps[@]}"

export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"

ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~
