# Wipro Capstone Project

Bash Maintenance Suite (Day 1 draft)

This repo holds a Linux-only bash scripting project for my capstone. Day 1 focuses on backups.

Current scripts:
- scripts/common.sh (shared helpers)
- scripts/backup.sh (time-stamped rsync backup, retention)

Next steps (coming days): updates, log monitor, menu, tests.

Usage (Day1):
```
./scripts/backup.sh -n   # dry-run
./scripts/backup.sh      # real run
```

Config in config/config.env (edit paths if needed).

Logs will appear in logs/maintenance.log once other parts land.

-- initial draft
