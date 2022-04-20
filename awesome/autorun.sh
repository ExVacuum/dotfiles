#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run mpd-discord-rpc
run udiskie
run nm-applet
run keepassxc
run kdeconnect-indicator
run discord-canary --start-minimized
run optimus-manager-qt
run pomotroid --no-sandbox
run rclone bisync gdrive:/ ~/gdrive/
run kmail
run kitty
