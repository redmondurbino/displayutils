#!/bin/bash

EXTEND_SCRIPT="$HOME/extend_displays.py"
MIRROR_SCRIPT="$HOME/mirror_displays.py"
STATE_FILE="$HOME/.display_mode_state"

mode="$(cat "$STATE_FILE" 2>/dev/null)"
if [[ "$mode" != "mirror" && "$mode" != "extend" ]]; then
  mode="extend"
fi

# Always print a title, no matter what
echo "Displays: ${mode^}"
echo "---"

# Validate scripts exist
if [[ ! -x "$EXTEND_SCRIPT" ]]; then
  echo "Missing/Not executable: extend_displays.py"
fi
if [[ ! -x "$MIRROR_SCRIPT" ]]; then
  echo "Missing/Not executable: mirror_displays.py"
fi

echo "Toggle | bash='$0' param1=toggle terminal=false refresh=true"
echo "Extend | bash='$0' param1=extend terminal=false refresh=true"
echo "Mirror | bash='$0' param1=mirror terminal=false refresh=true"
echo "---"
echo "Open Plugin Folder | bash='open' param1='$HOME/Documents/SwiftBar' terminal=false"
echo "Refresh | refresh=true"

run_cmd() {
  # Run quietly; if it fails, show an alert-style line next refresh
  "$@" >/tmp/swiftbar_display_toggle.out 2>/tmp/swiftbar_display_toggle.err
  return $?
}

case "$1" in
  toggle)
    if [[ "$mode" == "extend" ]]; then
      run_cmd "$MIRROR_SCRIPT" && echo "mirror" > "$STATE_FILE"
    else
      run_cmd "$EXTEND_SCRIPT" && echo "extend" > "$STATE_FILE"
    fi
    ;;
  extend)
    run_cmd "$EXTEND_SCRIPT" && echo "extend" > "$STATE_FILE"
    ;;
  mirror)
    run_cmd "$MIRROR_SCRIPT" && echo "mirror" > "$STATE_FILE"
    ;;
esac
