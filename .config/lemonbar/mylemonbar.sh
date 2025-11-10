#!/bin/sh

# Define the clock
Clock() {
        DATETIME=$(date "+%a %b %d, %T")

        printf "$DATETIME"
}

# Print the clock

# while true; do
#         echo "%{c}%{F#FFFF00}%{B#0000FF} $(Clock) %{F-}%{B-}"
#         sleep 1
# done

#Define the battery
Battery() {
        BATPERC=$(acpi --battery | cut -d, -f2)
        echo "$BATPERC"
}

AudioVolume() {
        VOLUME=$(pactl list sinks | grep 'Volume:' | head -n1 | awk '{print $5}')
        echo "$VOLUME"
}


CurrentWorkspace() {
        WORKSPC=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)
        echo "$WORKSPC"
}

Core0Temp () {
        CORE0TEMP=$(sensors|grep "Core 0")
        echo "${CORE0TEMP:16:-36}"
}

Core1Temp () {
        CORE1TEMP=$(sensors|grep "Core 1")
        echo "${CORE1TEMP:16:-36}"
}

FanSpeed () {
        FANSPD=$(sensors|grep "Right")
        echo "${FANSPD:14:-34}"
}



# Print the percentage
while true; do
        # echo "%{r}$(Battery)"
        echo \
        \
        "%{l}%{B#CC2E3440} $(CurrentWorkspace) $(Core0Temp) $(Core1Temp) $(FanSpeed) %{B-} \
        %{c}%{B#882E3440} $(Clock) %{B-} \
        %{r}%{B#882E3440} "%{A:pavucontrol:}audiomanager%{A}" VOL $(AudioVolume) BAT$(Battery) %{B-}"
        sleep 0.5;
done
