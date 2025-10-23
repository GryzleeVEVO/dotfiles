#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

search_dirs=(
	"$HOME/.local/share/applications"
	"/usr/share/applications"
	"/usr/local/share/applications"
	"/var/lib/flatpak/exports/share/applications"
)

declare -A app_map

while IFS= read -r -d '' file; do
	if grep -qi '^NoDisplay=true' "$file" ||
		! grep -qi '^Type=.*Application.*$' "$file" ||
		grep -qi "^OnlyShowIN=KDE$" "$file"; then
		continue
	fi

	name=$(grep -m1 -E '^Name=' "$file" 2>/dev/null | sed 's/^Name=//')

	if [[ -z "$name" ]]; then
		name=$(basename "$file" .desktop)
	fi

	app_map["$name"]="$file"
done < <(
	for dir in "${search_dirs[@]}"; do
		if ! [[ -d "$dir" ]]; then
			continue
		fi

		find -L "$dir" -type f -maxdepth 1 -name '*.desktop' -print0 2>/dev/null
	done
)

if [[ ${#app_map[@]} -eq 0 ]]; then
	exit 1
fi

selection=$(printf '%s\n' "${!app_map[@]}" | sort -f | wmenu -i -l 20 -p "Run:" || true)

[[ -z "$selection" ]] && exit 0

dex "${app_map[$selection]}" >/dev/null 2>&1
