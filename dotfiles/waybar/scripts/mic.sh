#!/bin/bash
# ── mic.sh ─────────────────────────────────────────────────
# Description: Shows microphone mute/unmute status with icon
# Usage: Called by Waybar `custom/microphone` module every 1s
# Dependencies: pactl (PulseAudio / PipeWire)
# ───────────────────────────────────────────────────────────


if pactl get-source-mute @DEFAULT_SOURCE@ | grep -q 'yes'; then
  # Muted → mic-off icon (Red)
  echo "<span foreground='#ff0033'>[  ]</span>"
else
  # Active → mic-on icon (Cyan)
  echo "<span foreground='#00ffff'>[  ]</span>"
fi

