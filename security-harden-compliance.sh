#============================
#Script for Security Hardening and Compliance
#=============================

#!/bin/bash

# Script Name: security_hardening.sh
# Description: Applies security hardening and ensures compliance with best practices

echo "===== SECURITY HARDENING AND COMPLIANCE CHECK - $(date) ====="

# 1. Ensure permissions on critical system files
echo "[SECURITY: Fixing File Permissions]"
chmod 600 /etc/shadow
chmod 644 /etc/passwd
chmod 600 /etc/ssh/sshd_config
echo "File permissions secured."

# 2. Disable root SSH login for better security
echo "[SECURITY: Disabling Root SSH Login]"
sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
echo "Root SSH login disabled."

# 3. Ensure firewall is enabled and configured
echo "[SECURITY: Configuring Firewall]"
ufw enable
ufw allow OpenSSH
ufw allow 80/tcp
ufw allow 443/tcp
echo "Firewall configured and enabled."

# 4. Enable automatic security updates
echo "[SECURITY: Enabling Automatic Security Updates]"
apt install -y unattended-upgrades
dpkg-reconfigure -plow unattended-upgrades
echo "Automatic security updates enabled."

# 5. Check for and remove unused packages
echo "[SECURITY: Removing Unused Packages]"
apt autoremove -y
echo "Unused packages removed."

# 6. Ensure secure SSH protocol (disable outdated versions)
echo "[SECURITY: Enforcing SSH Protocol 2]"
sed -i 's/^#Protocol 2/Protocol 2/' /etc/ssh/sshd_config
echo "SSH Protocol 2 enforced."

# 7. Restart SSH service to apply changes
echo "[SECURITY: Restarting SSH Service]"
systemctl restart ssh
echo "SSH service restarted."

echo "===== SECURITY HARDENING COMPLETE ====="
