# ! /bin/sh
killall -q lemonbar

./.config/lemonbar/mylemonbar.sh | lemonbar -B "#00000000" -f "Roboto Medium:size=13" | sh
