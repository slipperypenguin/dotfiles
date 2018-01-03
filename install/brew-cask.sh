if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

#brew tap caskroom/cask
#brew tap caskroom/fonts

## Install packages
#apps=(
#  alfred
#  dash3
#  firefox
#  firefoxdeveloper
#  glimmerblocker
#  macdown
#  atom
#)

#brew cask install "${apps[@]}"


## Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
#brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package


## Link Hammerspoon config
#if [ ! -d ~/.hammerspoon ]; then ln -sfv "$DOTFILES_DIR/etc/hammerspoon/" ~/.hammerspoon; fi
