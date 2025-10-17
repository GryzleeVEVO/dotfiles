#!/bin/bash

while true; do
	vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 3)"

	if [[ -z $vol ]]; then
		vol="$(("$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d ' ' -f 2 | tr -d .)" + 0))%"
	fi

	bat="$(cat /sys/class/power_supply/BAT0/capacity)%"
	date="$(date +'%Y-%m-%d %X')"
	echo "VOL ${vol} | BAT ${bat} | ${date}"

	sleep 0.1
done
