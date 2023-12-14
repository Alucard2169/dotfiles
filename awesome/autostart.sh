#!/bin/bash

# Check if volumeicon is already running
# if ! pgrep -x "volumeicon" >/dev/null; then
#	 volumeicon &
# fi
#!/bin/sh

run() {
	if ! pgrep -f "$1"; then
		"$@" &
	fi
}

picom --config $HOME/.config/picom/picom.conf
nm-applet &
lxsession &
