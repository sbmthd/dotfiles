#!/bin/sh
# Prints a nerd-font battery glyph sized to the current charge level,
# followed by the percentage (mirrors the icon style used in tmux.conf).
# Colours the segment when running low on battery (skipped while charging).
#
# Usage: battery.sh [low-color] [critical-color]
low_color="${1:-#ffaa88}"
critical_color="${2:-#D70000}"

batt=$(pmset -g batt)
pct=$(printf '%s\n' "$batt" | grep -Eo '[0-9]+%' | head -1 | tr -d '%')

if [ -z "$pct" ]; then
	exit 0
fi

if [ "$pct" -ge 90 ]; then
	icon=$(printf '\xef\x89\x80')  # nf-fa-battery_full
elif [ "$pct" -ge 60 ]; then
	icon=$(printf '\xef\x89\x81')  # nf-fa-battery_three_quarters
elif [ "$pct" -ge 35 ]; then
	icon=$(printf '\xef\x89\x82')  # nf-fa-battery_half
elif [ "$pct" -ge 15 ]; then
	icon=$(printf '\xef\x89\x83')  # nf-fa-battery_quarter
else
	icon=$(printf '\xef\x89\x84')  # nf-fa-battery_empty
fi

color=""
if ! printf '%s\n' "$batt" | grep -Eq '; *charging;'; then
	if [ "$pct" -lt 15 ]; then
		color="$critical_color"
	elif [ "$pct" -lt 35 ]; then
		color="$low_color"
	fi
fi

if [ -n "$color" ]; then
	printf '#[fg=%s]%s %s%%' "$color" "$icon" "$pct"
else
	printf '%s %s%%' "$icon" "$pct"
fi
