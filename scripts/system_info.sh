#!/bin/bash
# Welcome message [cite: 40]
echo "Welcome, Ahmad Danish Azharin Bin Ahmad Josli!"

# Display system stats [cite: 41, 42, 43, 44]
echo "--- Current Date and Time ---"
date
echo "--- Disk Usage ---"
df -h /
echo "--- Memory Usage ---"
free -h
echo "--- Top 5 CPU Processes ---"
ps -eo pid,cmd,%cpu --sort=-%cpu | head -n 6

# Save a copy directly to the logs folder [cite: 45]
echo "Generating log file..."
LOGPATH="$HOME/linux_assignment/logs/system_log_$(date +%Y%m%d).log"

echo "Welcome, Ahmad Danish Azharin Bin Ahmad Josli!" > $LOGPATH
date >> $LOGPATH
df -h / >> $LOGPATH
free -h >> $LOGPATH
ps -eo pid,cmd,%cpu --sort=-%cpu | head -n 6 >> $LOGPATH
