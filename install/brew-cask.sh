if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/versions
brew tap caskroom/cask
brew tap caskroom/fonts

## Install packages
apps=(
   archiver
   atom
   bartender
   cyberduck
   dash
   discord
   duet
   evernote
   firefox
   font-ibm-plex
   font-source-code-pro
   github
   kap
   paw
   pocket
   #scratches
   sequel-pro
   sip
   sketch
   slack
   synergy
   trym
   tyke
#  glimmerblocker
#  macdown
)

brew cask install "${apps[@]}"


## Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
#brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize webpquicklook suspicious-package qlvideo
