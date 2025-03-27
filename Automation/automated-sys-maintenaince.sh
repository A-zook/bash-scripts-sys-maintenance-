#!/bin/bash

# Script Name: system_maintenance.sh
# Description: Automates log analysis, system optimization, error fixing, and security hardening

echo "===== SYSTEM MAINTENANCE STARTED - $(date) ====="

# Objective 1: Log Analysis
echo "[TASK 1: LOG ANALYSIS]"
grep -i 'error\|fail\|warning' /var/log/syslog > /var/log/error_report.log
echo "Log analysis complete. Check /var/log/error_report.log for details."

# Objective 2: Optimize Performance
echo "[TASK 2: PERFORMANCE OPTIMIZATION]"
apt update && apt upgrade -y    # Update and upgrade packages
apt autoremove -y               # Remove unused packages
apt clean                       # Clean up APT cache
systemctl restart networking    # Restart networking services
echo "Performance optimization complete."

# Objective 3: Fix Common Errors (WSL Example)
echo "[TASK 3: FIXING COMMON ERRORS]"
if grep -q "WSL" /var/log/syslog; then
    wsl --shutdown
    echo "WSL restarted."
else
    echo "No WSL errors found."
fi

# Objective 4: Security Hardening and Compliance
echo "[TASK 4: SECURITY HARDENING]"
chmod 600 /etc/shadow
chmod 644 /etc/passwd
sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
ufw enable
ufw allow OpenSSH
apt install -y unattended-upgrades
dpkg-reconfigure -plow unattended-upgrades
systemctl restart ssh
echo "Security hardening complete."

echo "===== SYSTEM MAINTENANCE COMPLETE ====="

#To Make It Executable
chmod +x system_maintenance.sh

#To Run It
./system_maintenance.sh
