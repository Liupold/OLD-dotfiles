#!/bin/bash

BATTERY=""
VOLUME=""
VOL_SYM=""
BRIGHT=""
DATE_TIME=""
MUSIC=""
BSPWM_DESK=""

timeout_delay='.5s'

update_bar() {
        echo -e "%{l}$BSPWM_DESK  %{c}$MUSIC   %{r}$VOLUME $BRIGHT $BATTERY $DATE_TIME"
}

_all() {
        battery
        volume
        brightness
        datetime
        music
        bspwm_desktop
        update_bar
}

battery_sym() {
        PERCENT="$(echo $1 | sed 's|%||g')"
        [ $PERCENT -gt 95 ] && echo "" && exit
        [ $PERCENT -lt 95 ] && [ $PERCENT -gt 75 ] echo "" && exit
        [ $PERCENT -lt 75 ] && [ $PERCENT -gt 50 ] echo "" && exit
        [ $PERCENT -lt 50 ] && [ $PERCENT -gt 20 ] echo "" && exit
        [ $PERCENT -lt 20 ] echo "" && exit

}

battery() {
        STATUS="$(acpi -b | grep -o 'Charging' || acpi -b | grep -o 'Discharging')"
        BATTERY_INFO="$(acpi -b)"
        PERCENT="$(echo $BATTERY_INFO | cut -d, -f2 | sed 's| ||g')"
        TIME_="$(echo $BATTERY_INFO | cut -d, -f3 | cut -d' ' -f2)"

        [ "$STATUS" = "Charging" ] && SYM="" || SYM=""
        SYM="$SYM $(battery_sym $PERCENT)"

        [ ! -z "$TIME_" ] && BATTERY="$SYM $PERCENT($TIME_)" || BATTERY="$SYM $PERCENT"
}

volume() {
        VOLUME=$(amixer -D pulse get Master | grep -m1 -o '\[.*%\]')
}

brightness() {
        BRIGHT=" $(light -G)"
}

datetime() {
        DATE_TIME=$(date "+%a %b %d, %T")
}

event_handler() {
        ACPI_EVENT="$1"

        if [[ "$ACPI_EVENT" == *"volume"* ]]; then
                volume; update_bar
        elif [[ "$ACPI_EVENT" == *"brightness"* ]]; then
                brightness; update_bar
        elif [[ "$ACPI_EVENT" == *"jack"* ]]; then
                echo vol_sym; update_bar
        elif [[ "$ACPI_EVENT" == *"676AA15E-6A47-"* ]]; then
                battery; update_bar
        fi

}

music() {
        [ "$(playerctl status 2>/dev/null)" = 'Playing' ] && \
                MUSIC="$(playerctl -i chromium metadata --format \
                '{{playerName}}: {{title}} [{{duration(position)}}/{{duration(mpris:length)}}]')" || MUSIC=""
}

bspwm_desktop() {
        occupied="$(bspc query -D -d .occupied --names)"
        focus=$(bspc query -D -d focused --names)

        echo $occupied | grep $focus >/dev/null || occupied="$occupied $focus"

        BSPWM_DESK=$(echo $occupied | sed "s|\<$focus\>|%{F#000000}$focus%{F-}|g")
}
acpi_loop() {
        n=0
        while [ 1 ]; do
            ACPI_EVENT=$(timeout $timeout_delay acpi_listen -c 1)
            datetime && bspwm_desktop && music && update_bar
            [ $n -gt 60 ] && n=0 && battery && update_bar
            n=$((n + 1))
            [ -n "$ACPI_EVENT" ] && event_handler $ACPI_EVENT
        done
}

_all
acpi_loop

