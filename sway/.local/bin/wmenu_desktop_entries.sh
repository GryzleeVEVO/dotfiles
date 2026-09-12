#!/usr/bin/env bash

set -euo pipefail

DEST_FILE="$XDG_CACHE_HOME/wmenu-desktop-entries"
declare -A app_map

if ! [ -f "$DEST_FILE" ] || ! [ -s "$DEST_FILE" ]; then
	"$HOME/.local/bin/wmenu_create_cache.sh"
fi

while IFS= read -r line; do
	name=${line% /*}
	path=${line##* }
	app_map["$name"]="$path"
done <"$DEST_FILE"

if [[ ${#app_map[@]} -eq 0 ]]; then
	exit 1
fi

selection=$(printf '%s\n' "${!app_map[@]}" | sort -f | wmenu -i -l 20 -p "Run:" || true)

[[ -z "$selection" ]] && exit 0

dex "${app_map[$selection]}" >/dev/null 2>&1
