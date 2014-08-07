#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	#for f in /etc/X11/xinit/xinitrc.d/* ; do
		#[ -x "$f" ] && . "$f"

	#done
	#unset f
#fi

sh ~/.screenlayout/dual_portrait.sh

# Programs
redshift -l 45.703182:-73.644361 -t 5500:4000 & # Protect my eye
unclutter &
xcompmgr &
urxvtd -q -f -o &

~/utils/random_wall.sh
~/utils/on_idle.py -loop -i 120 ~/utils/random_wall.sh &
noppoo_choc_mini_linux &

xrdb -merge ~/.Xresources

# Font path
xset +fp /usr/share/fonts/local
xset +fp /usr/share/fonts/misc
xset +fp /usr/share/fonts/artwiz-fonts
xset fp rehash
# Prevent screen from blanking
xset -dpms; xset s off

xmodmap ~/.Xmodmap # Key map
xset r rate 150 25 # Key repeat

#run systemd as user instance
systemd --user &

$HOME/.config/herbstluftwm/start_with_rule.sh &
exec ck-launch-session dbus-launch herbstluftwm

#exec fluxbox
#exec i3
