#!/usr/bin/env bash
# Day 2: Basic system update (apt only) for Linux

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"

DRY_RUN=false

usage() {
  echo "Usage: $0 [-n]"
  echo "  -n  dry-run (show commands only)"
}

while getopts ":nh" opt; do
  case "$opt" in
    n) DRY_RUN=true ;; 
    h) usage; exit 0 ;;
    *) usage; exit 1 ;;
  esac
done

if ! command -v apt-get >/dev/null 2>&1; then
  log "apt-get not found. This script is basic (Ubuntu/Debian only)."
  exit 1
fi

log "Starting system update (apt) (dry-run=$DRY_RUN)"
if $DRY_RUN; then
  echo "sudo apt-get update"
  echo "sudo apt-get -y upgrade"
  echo "sudo apt-get -y autoremove"
else
  sudo apt-get update
  sudo apt-get -y upgrade
  sudo apt-get -y autoremove
fi
log "System update complete."