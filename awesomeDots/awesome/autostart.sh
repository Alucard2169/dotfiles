#!/bin/sh

run() {
	if ! pgrep -f "$1"; then
		"$@" &
	fi
}

picom --config $HOME/.config/picom/picom.conf
nm-applet &
lxsession &
