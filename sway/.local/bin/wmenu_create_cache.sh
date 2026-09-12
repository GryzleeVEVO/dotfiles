#!/usr/bin/env bash

set -euo pipefail

SEARCH_DIRS=(
	"$HOME/.local/share/applications"
	"/usr/share/applications"
	"/usr/local/share/applications"
	"/var/lib/flatpak/exports/share/applications"
)
DEST_FILE="$XDG_CACHE_HOME/wmenu-desktop-entries"
declare -A app_map

while IFS= read -r -d '' file; do
	if grep -qi '^NoDisplay=true' "$file" ||
		! grep -qi '^Type=.*Application.*$' "$file" ||
		grep -qi "^OnlyShowIn=.*KDE.*$" "$file"; then
		continue
	fi

	name=$(grep -m1 -E '^Name=' "$file" 2>/dev/null | sed 's/^Name=//')

	if [[ -z "$name" ]]; then
		name=$(basename "$file" .desktop)
	fi

	app_map["$name"]="$file"
done < <(
	for dir in "${SEARCH_DIRS[@]}"; do
		if ! [[ -d "$dir" ]]; then
			continue
		fi

		find -L "$dir" -type f -maxdepth 1 -name '*.desktop' -print0 2>/dev/null
	done
)

(
	printf -v fmtStr '%s %%q\\n' "${!app_map[@]}"
	printf "$fmtStr" "${app_map[@]}"
) >"$DEST_FILE"
