#!/usr/bin/env bash
# Day 1: Basic backup script (Linux)
# Copies a source directory into a timestamped folder under the backup destination.
# If rsync is available, use it; otherwise fall back to cp -r.

set -e

SCRIPT_DIR="$(cd ""$(dirname ""${BASH_SOURCE[0]}""")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"

CONFIG_FILE="$SCRIPT_DIR/../config/config.env"
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

# Defaults (can be overridden in config.env or flags)
BACKUP_SOURCE="${BACKUP_SOURCE:-$HOME/Documents}"
BACKUP_DEST="${BACKUP_DEST:-$HOME/system_backups}"

DRY_RUN=false

usage() {
  echo "Usage: $0 [-s source_dir] [-d dest_dir] [-n]"
  echo "  -s  source directory (default: $BACKUP_SOURCE)"
  echo "  -d  destination directory (default: $BACKUP_DEST)"
  echo "  -n  dry-run (show what would happen)"
}

while getopts ":s:d:nh" opt; do
  case "$opt" in
    s) BACKUP_SOURCE="$OPTARG" ;; 
    d) BACKUP_DEST="$OPTARG" ;; 
    n) DRY_RUN=true ;; 
    h) usage; exit 0 ;; 
    *) usage; exit 1 ;; 
  esac
done

mkdir -p "$BACKUP_DEST"
TS="$(date +"%Y-%m-%d_%H%M%S")"
DEST_DIR="$BACKUP_DEST/backup_$TS"

log "Starting backup: $BACKUP_SOURCE -> $DEST_DIR (dry-run=$DRY_RUN)"

if command -v rsync >/dev/null 2>&1; then
  log "Using rsync -a"
  if $DRY_RUN; then
    echo "rsync -a \"$BACKUP_SOURCE/\" \"$DEST_DIR/\""
  else
    mkdir -p "$DEST_DIR"
    rsync -a "$BACKUP_SOURCE/" "$DEST_DIR/"
  fi
else
  log "rsync not found, using cp -r"
  if $DRY_RUN; then
    echo "mkdir -p \"$DEST_DIR\" && cp -r \"$BACKUP_SOURCE/\" \"$DEST_DIR/\""
  else
    mkdir -p "$DEST_DIR"
    cp -r "$BACKUP_SOURCE/" "$DEST_DIR/"
  fi
fi

log "Backup complete: $DEST_DIR"

# Optional retention cleanup (commented out for safety). Uncomment to enable.
# Example: delete backup directories older than 7 days
# find "$BACKUP_DEST" -maxdepth 1 -type d -name 'backup_*' -mtime +7 -exec rm -rf {} \;