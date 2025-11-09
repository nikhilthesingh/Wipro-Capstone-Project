#!/usr/bin/env bash
# Day 5: very basic checks (not formal tests)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Running basic checks..."
echo "1) backup dry-run"
"$SCRIPT_DIR/backup.sh" -n || echo "backup dry-run failed (check paths?)"

echo "2) update dry-run (apt)"
"$SCRIPT_DIR/update.sh" -n || echo "update dry-run failed (maybe not apt-based?)"

echo "3) log scan once"
"$SCRIPT_DIR/log_monitor.sh" -1 || echo "log scan failed (patterns/log file missing?)"

echo "Done. Check logs/maintenance.log."