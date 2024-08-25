#!/usr/bin/env bash

final_info=""
available_width=$((($1 - 80)>>1)) # approximation for around half screen width
available_width=$(( $available_width > 45 ? 45 : $available_width ))
player=$(fastfetch -c ~/.config/fastfetch/tmux/player.jsonc --player-format "{1}")

if [ -n "$player" ]; then
	case $player in
		Spotify)
			final_info='󰓇 '
			;;
		Firefox)
			final_info='󰈹 '
			;;
		*)
			final_info=' '
			;;
	esac
	final_info="${final_info}$(fastfetch -c ~/.config/fastfetch/tmux/media.jsonc --media-format "{3} - {1}")"

	if ((available_width > 0)); then
		if ((${#final_info} > available_width)); then
			echo "${final_info:0:available_width}…"
		else
			echo $final_info
		fi
	fi
fi