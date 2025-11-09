#!/usr/bin/env bash
# Day 3: Basic log monitor (file-based)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"

CONFIG_FILE="$SCRIPT_DIR/../config/config.env"
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

PATTERNS_FILE="${PATTERNS_FILE:-$SCRIPT_DIR/../config/patterns.txt}"

LOG_FILE_DEFAULT=""
if [[ -f "/var/log/syslog" ]]; then
  LOG_FILE_DEFAULT="/var/log/syslog"
else
  LOG_FILE_DEFAULT="/var/log/messages"
fi

SCAN_ONCE=false
LOG_FILE_IN=""

usage() {
  echo "Usage: $0 [-1] [-f logfile] [-p patterns.txt]"
  echo "  -1  scan once and exit"
  echo "  -f  choose a different log file (default: $LOG_FILE_DEFAULT)"
  echo "  -p  choose a patterns file (default: $PATTERNS_FILE)"
}

while getopts ":1f:p:h" opt; do
  case "$opt" in
    1) SCAN_ONCE=true ;; 
    f) LOG_FILE_IN="$OPTARG" ;; 
    p) PATTERNS_FILE="$OPTARG" ;; 
    h) usage; exit 0 ;;
    *) usage; exit 1 ;;
  esac
done

LOG_TO_SCAN="${LOG_FILE_IN:-$LOG_FILE_DEFAULT}"

if [[ ! -f "$PATTERNS_FILE" ]]; then
  log "Patterns file not found: $PATTERNS_FILE"
  exit 1
fi

log "Log monitor starting. File: $LOG_TO_SCAN | Patterns: $PATTERNS_FILE | once=$SCAN_ONCE"

if $SCAN_ONCE; then
  grep -E -i -f "$PATTERNS_FILE" "$LOG_TO_SCAN" 2>/dev/null | while IFS= read -r line; do
    echo "$line"
    log "[ALERT] $line"
  done
  log "Scan-once complete."
else
  tail -Fn0 "$LOG_TO_SCAN" 2>/dev/null | grep -E -i -f "$PATTERNS_FILE" --line-buffered | while IFS= read -r line; do
    echo "$line"
    log "[ALERT] $line"
  done
fi