#!/bin/sh

## Work macBook
dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Launchpad.app"
dockutil --no-restart --add "/Applications/App Store.app"
dockutil --no-restart --add "/Applications/Mail.app"
dockutil --no-restart --add "/Applications/FirefoxDeveloperEdition.app"
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/Messages.app"
dockutil --no-restart --add "/Applications/Reminders.app"
dockutil --no-restart --add "/Applications/Notes.app"
dockutil --no-restart --add "/Applications/iTunes.app"
dockutil --no-restart --add "/Applications/System Preferences.app"
dockutil --no-restart --add "/Applications/Evernote.app"


## iMac, touchBar, Hackbook
#dockutil --no-restart --remove all
#dockutil --no-restart --add "/Applications/Launchpad.app"
#dockutil --no-restart --add "/Applications/App Store.app"
#dockutil --no-restart --add "/Applications/Safari.app"
#dockutil --no-restart --add "/Applications/FaceTime.app"
#dockutil --no-restart --add "/Applications/Mail.app"
#dockutil --no-restart --add "/Applications/Calendar.app"
#dockutil --no-restart --add "/Applications/Messages.app"
#dockutil --no-restart --add "/Applications/Reminders.app"
#dockutil --no-restart --add "/Applications/Notes.app"
#dockutil --no-restart --add "/Applications/iTunes.app"
#dockutil --no-restart --add "/Applications/Photos.app"
#dockutil --no-restart --add "/Applications/System Preferences.app"
#dockutil --no-restart --add "/Applications/Discord.app"
#dockutil --no-restart --add "/Applications/Evernote.app"
#dockutil --no-restart --add "/Applications/Utilities/Terminal.app"


killall Dock
