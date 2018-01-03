if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask
#brew tap caskroom/fonts

## Install packages
apps=(
#  alfred
   archiver
   atom
   bartender
   cyberduck
   dash
   discord
   duet
   evernote
   firefox
   github
   kap
   muzzle
   paw
   rocket
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
#brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
