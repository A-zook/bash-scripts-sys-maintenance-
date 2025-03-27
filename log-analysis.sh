#!/bin/bash

# Define log file for analysis
LOG_FILE="/var/log/auth.log"         # For authentication logs (e.g., failed logins)
SYS_LOG="/var/log/syslog"            # For system logs
SEC_LOG="/var/log/security.log"       # For security logs (if available)
OUTPUT_FILE="/var/log/log_analysis_report.txt"

# Ensure output file is writable
touch $OUTPUT_FILE
chmod 644 $OUTPUT_FILE

# Date and Time for the report
echo "===== LOG ANALYSIS REPORT - $(date) =====" > $OUTPUT_FILE

# Analyze Failed Logins
echo -e "\n[FAILED LOGIN ATTEMPTS]" >> $OUTPUT_FILE
grep "Failed password" $LOG_FILE | tail -n 10 >> $OUTPUT_FILE

# Analyze System Errors
echo -e "\n[SYSTEM ERRORS]" >> $OUTPUT_FILE
grep -i "error" $SYS_LOG | tail -n 10 >> $OUTPUT_FILE

# Analyze Security Breaches (if security log is available)
if [[ -f "$SEC_LOG" ]]; then
    echo -e "\n[SECURITY BREACHES]" >> $OUTPUT_FILE
    grep -i "failed" $SEC_LOG | tail -n 10 >> $OUTPUT_FILE
else
    echo -e "\n[SECURITY BREACHES]" >> $OUTPUT_FILE
    echo "No security log file found." >> $OUTPUT_FILE
fi

# Display the report
cat $OUTPUT_FILE

#Make the script executable
chmod +x monitor_system.sh

#If the file is missing, create it using a text editor like nano or vim:
#Open the file using nano
nano analyze_logs.sh

#Make it executable:
chmod +x analyze_logs.sh


#Run it manually
./analyze_logs.sh

#=====================
#END OF SCRIPT
#=====================