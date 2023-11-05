# Set up keyboard mappings for each device
setxkbmap -device "$(xinput list --id-only 'keyboard:ITE Tech. Inc. ITE Device(8910) Keyboard')" -layout es
setxkbmap -device "$(xinput list --id-only 'S U')" -layout us -variant altgr-intl
