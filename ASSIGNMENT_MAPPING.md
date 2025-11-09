# Assignment Mapping (Basic Version)

Day 1:
- File: `scripts/backup.sh`
- Function: Creates a timestamped backup directory and copies (rsync or cp).
- Enhancement idea (commented): retention cleanup with `find -mtime`.

Day 2:
- File: `scripts/update.sh`
- Function: Runs apt update, upgrade, autoremove. Supports `-n` dry-run.

Day 3:
- File: `scripts/log_monitor.sh` + `config/patterns.txt`
- Function: Greps system log for patterns: error, failed, unauthorized/denied.
- Continuous mode uses `tail -F` + grep; single scan uses `-1`.

Day 4:
- File: `scripts/menu.sh`
- Function: Simple text menu to trigger backup/update/log scans.

Day 5:
- File: `scripts/test_basic.sh`
- Function: Executes dry-run backup/update and one log scan as simple verification.

Shared:
- `scripts/common.sh` provides a timestamp logger writing to `logs/maintenance.log`.
- `config/config.env` holds backup source/destination and pattern file path.