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

# Key mapping
xmodmap ~/.Xmodmap

# Keyboard repeat
xset r rate 150 25

# Wallpaper
#fbsetbg /data/img/wall/wallpaper-972417_contrast2.png
fbsetbg /data/img/wall/113576_contrast.png

# Deamon for X
exec urxvtd -q -f -o & # stop with the server
#exec /usr/lib/notification-daemon-1.0/notification-daemon start &

# Hide cursor when mouse is idle
exec unclutter -visible -root &

exec xcompmgr -fF -D20 -I 0.15 -O 0.05 &

exec conky &

# WM
#exec fluxbox
exec herbstluftwm
#exec enlightenment_start
#exec compiz ccp

# Session ended, cleanup
#exec /usr/lib/notification-daemon-1.0/notification-daemon stop &
