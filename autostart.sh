#!/bin/bash

/bin/bash ~/D-W-M/scripts/dwm-status.sh &
/bin/bash ~/D-W-M/scripts/wp-autochange.sh &
#picom -o 0.95 -i 0.88 --detect-rounded-corners --vsync --blur-background-fixed -f -D 5 -c -b
picom --config  ~/mypicom/picom.conf
#nm-applet &
#~/D-W-M/scripts/autostart_wait.sh
#fcitx  &
