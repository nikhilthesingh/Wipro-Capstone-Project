#!/usr/bin/env bash
# Day 4: Simple menu to run tasks

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/common.sh"

PAUSE() { read -rp "Press Enter to continue..." _; }

run_backup() { "$SCRIPT_DIR/backup.sh"; }
run_backup_dry() { "$SCRIPT_DIR/backup.sh" -n; }
run_update() { "$SCRIPT_DIR/update.sh"; }
run_update_dry() { "$SCRIPT_DIR/update.sh" -n; }
scan_logs_once() { "$SCRIPT_DIR/log_monitor.sh" -1; }
start_log_monitor() { "$SCRIPT_DIR/log_monitor.sh"; }

while true; do
  clear 2>/dev/null || true
  echo "==== Maintenance Menu ===="
  echo "1) Backup"
  echo "2) Backup (dry-run)"
  echo "3) Update (apt)"
  echo "4) Update (apt) dry-run"
  echo "5) Log Scan Once"
  echo "6) Log Monitor (continuous)"
  echo "7) Exit"
  echo "=========================="
  read -rp "Choose [1-7]: " choice
  case "$choice" in
    1) run_backup; PAUSE ;;
    2) run_backup_dry; PAUSE ;;
    3) run_update; PAUSE ;;
    4) run_update_dry; PAUSE ;;
    5) scan_logs_once; PAUSE ;;
    6) start_log_monitor; PAUSE ;;
    7) echo "Bye!"; exit 0 ;;
    *) echo "Invalid option"; PAUSE ;;
  esac
done
