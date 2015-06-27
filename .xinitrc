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

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setxkbmap -option ctrl:swapcaps
setxkbmap -option terminate:ctrl_alt_bksp


# filesystem browser
thunar --daemon &

# disables touchpad while typing (avoids annoying jumping around)
syndaemon -t -k -i 2 -d &

if [[ -d /usr/share/fonts ]]; then
  for d in /usr/share/fonts/*; do [[ -d $d ]] && xset +fp "$d"; done
fi
xset fp rehash

xset r rate 250 25 &
xset b off
xset b 0 0 0

if [[ -d /etc/X11/xinit/xinitrc.d ]]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do [[ -x $f ]] && . "$f"; done
  unset f
fi

#xautolock -secure -time 15 -corners 00-0 -cornersize 5 -locker 'i3lock -d -p default -c 1a1a1a' &
/usr/bin/xscreensaver -no-splash &
nm-applet &
cbatticon &
/usr/bin/start-pulseaudio-x11 &
pasystray &
xbindkeys
feh --bg-scale /usr/share/wallpapers/solarized/solarized-dark.jpg

exec awesome --no-argb &> /tmp/awesome.log
