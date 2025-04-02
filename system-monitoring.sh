#!/bin/bash

# Define log file location
LOG_FILE="/var/log/system_monitor.log"

# Ensure log file exists
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Get Current Timestamp
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# Get CPU Usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Get Memory Usage
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_usage=$(awk "BEGIN {printf \"%.2f\", ($mem_used/$mem_total)*100}")

# Get Disk Usage
disk_usage=$(df -h | grep '^/dev' | awk '{print $1, $5}')

# Write to log file
echo "[$timestamp] CPU Usage: ${cpu_usage}% | Memory Usage: ${mem_usage}% | Disk Usage: $disk_usage" >> "$LOG_FILE"

# Display output in the terminal
echo -e "\n==== System Monitoring Report ===="
echo "Timestamp: $timestamp"
echo "CPU Usage: $cpu_usage%"
echo "Memory Usage: $mem_usage%"
echo "Disk Usage:"
echo "$disk_usage"
echo "=================================="

#Make the script executable
chmod +x monitor_system.sh

#If the file is missing, create it using a text editor like nano or vim:
#Open the file using nano
nano monitor_system.sh

#Make it executable:
chmod +x monitor_system.sh


#Run it manually
./monitor_system.sh


#Set Up a Cron Job for Automation
crontab -e


#Schedule the script to run every 5 minutes:
*/5 * * * * /path/to/monitor_system.sh

#========================
#END OF SCRIPT
#=======================
