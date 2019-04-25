#COMPUTER_NAME="HackBook"

#osascript -e 'tell application "System Preferences" to quit'

## Ask for the administrator password upfront
sudo -v

## Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

##############################################################################
# General UI/UX
##############################################################################

## Set computer name (as done via System Preferences → Sharing)
#sudo scutil --set ComputerName "$COMPUTER_NAME"
#sudo scutil --set HostName "$COMPUTER_NAME"
#sudo scutil --set LocalHostName "$COMPUTER_NAME"
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

## Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on


##############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
##############################################################################

## Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

## Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true

## Set the timezone; see `sudo systemsetup -listtimezones` for other values
#sudo systemsetup -settimezone "America/New_York" > /dev/null


##############################################################################
# Screen
##############################################################################

## Require password immediately after sleep or screen saver begins
#defaults write com.apple.screensaver askForPassword -int 1
#defaults write com.apple.screensaver askForPasswordDelay -int 0


##############################################################################
# Finder
##############################################################################

## Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
#defaults write com.apple.finder QuitMenuItem -bool true

## Finder: show hidden files by default
#defaults write com.apple.finder AppleShowAllFiles -bool true

## Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

## Finder: show status bar
#defaults write com.apple.finder ShowStatusBar -bool true

## Finder: show path bar
#defaults write com.apple.finder ShowPathbar -bool true

## Finder: allow text selection in Quick Look
#defaults write com.apple.finder QLEnableTextSelection -bool true

## Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

## When performing a search, search the current folder by default
#defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

## Disable the warning when changing a file extension
#defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

## Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

## Use AirDrop over every interface.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

## Expand the following File Info panes:
## “General”, “Open with”, and “Sharing & Permissions”
#defaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true


##############################################################################
# Dock
##############################################################################

## Show indicator lights for open applications in the Dock
#defaults write com.apple.dock show-process-indicators -bool true

## Automatically hide and show the Dock
#defaults write com.apple.dock autohide -bool true

## Make Dock icons of hidden applications translucent
#defaults write com.apple.dock showhidden -bool true

## No bouncing icons
#defaults write com.apple.dock no-bouncing -bool true


##############################################################################
# Mail
##############################################################################

## Display emails in threaded mode
#defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"

## Disable send and reply animations in Mail.app
#defaults write com.apple.mail DisableReplyAnimations -bool true
#defaults write com.apple.mail DisableSendAnimations -bool true

## Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

## Disable inline attachments (just show the icons)
#defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

## Mark all messages as read when opening a conversation
#defaults write com.apple.mail ConversationViewMarkAllAsRead -bool true


##############################################################################
# Terminal
##############################################################################

## Only use UTF-8 in Terminal.app
#defaults write com.apple.terminal StringEncodings -array 4

## Use "Monokai Pro (Filter Spectrum)" theme
defaults write com.apple.terminal "Default Window Settings" -string "Monokai Pro (Filter Spectrum)"
defaults write com.apple.terminal "Startup Window Settings" -string "Monokai Pro (Filter Spectrum)"

## Disable the annoying line marks
#defaults write com.apple.Terminal ShowLineMarks -int 0


##############################################################################
# Activity Monitor
##############################################################################

## Show the main window when launching Activity Monitor
#defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

## Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

## Show all processes in Activity Monitor
#defaults write com.apple.ActivityMonitor ShowCategory -int 0

## Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
