#!/usr/bin/env bash
# Basic common helpers (Linux)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

LOG_DIR="$BASE_DIR/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/maintenance.log"

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

log() {
  # simple logger: prints and appends to log file
  local msg="$*"
  echo "[$(timestamp)] $msg" | tee -a "$LOG_FILE"
}