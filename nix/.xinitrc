#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Load resources
xrdb -merge ~/.Xresources

# Remap CapsLocks to Escape
xmodmap -e "clear lock"
xmodmap -e "keycode 0x42 = Escape"

# Keyboard repeat
xset r rate 150 25

# Wallpaper
fbsetbg /data/img/wall/wallpaper-972417_contrast.png

# Deamon for X
exec urxvtd -q -f -o & # stop with the server
#exec /usr/lib/notification-daemon-1.0/notification-daemon start &

# WM
#exec i3 exec notion exec wmii exec musca
#exec fluxbox
exec herbstluftwm
#exec enlightenment_start
#exec compiz ccp

# Session ended, cleanup
#exec /usr/lib/notification-daemon-1.0/notification-daemon stop &
