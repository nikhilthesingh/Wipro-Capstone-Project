# Wipro Capstone Project — Bash Maintenance Suite (Linux, basic)

Very simple Bash scripts for basic system maintenance on Linux:
- Day 1: Backup a folder into a timestamped directory
- Day 2: System update (apt only) + cleanup
- Day 3: Log monitoring (file-based) using grep and a small patterns file
- Day 4: Menu script to run all tasks
- Day 5: Short mapping doc + a tiny test script

I kept it basic on purpose (intro level, no advanced stuff).

## Setup
Make scripts executable:
```bash
chmod +x scripts/*.sh
```
Optional: edit `config/config.env` to change backup source/destination.

## Usage
Day 1 (backup):
```bash
./scripts/backup.sh -n              # dry-run (shows what would happen)
./scripts/backup.sh                 # real backup
```

Day 2 (update apt-based systems):
```bash
./scripts/update.sh -n              # dry-run
./scripts/update.sh                 # real run (uses sudo)
```

Day 3 (log monitor):
```bash
./scripts/log_monitor.sh -1         # scan once and exit
./scripts/log_monitor.sh            # continuous (Ctrl+C to stop)
```

Day 4 (menu):
```bash
./scripts/menu.sh
```

Day 5 (basic checks):
```bash
./scripts/test_basic.sh
```

Logs (simple) are appended to logs/maintenance.log.

## Notes
- Backup uses rsync if available, else cp -r. Commented “find … -mtime” line shows optional retention cleanup.
- Update script assumes apt (Ubuntu/Debian) to keep it basic.
- Log monitor greps `/var/log/syslog` or falls back to `/var/log/messages` with patterns in `config/patterns.txt`.
- Test script just sanity-checks main scripts; not formal tests.

## Possible Improvements
- Support other package managers (dnf, yum, pacman, etc.).
- Add exclusions to backup (node_modules, large caches).
- Better alerts for logs (e.g., notify-send).