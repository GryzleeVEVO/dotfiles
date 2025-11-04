#!/bin/bash

while sleep 0.2; do
	vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 3)"

	if [[ -z $vol ]]; then
		vol="$(("$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 2 | tr -d . | sed 's/^0*//')" + 0))%"
	fi

	bat="$(cat /sys/class/power_supply/BAT0/capacity)%"

	if [[ $(cat /sys/class/power_supply/BAT0/status) = "Charging" ]]; then
		bat+=" Charging"
	fi

	date="$(date +'%Y-%m-%d %X')"
	echo "VOL ${vol} | BAT ${bat} | ${date}"
done
