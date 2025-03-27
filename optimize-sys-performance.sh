#optimizing system performance by:
    #Cleaning temporary files
    #Restarting critical services
    #Checking for and installing system updates

#!/bin/bash

# Define log file for the script
LOG_FILE="/var/log/system_optimization.log"

# Function to log messages
log_message() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a $LOG_FILE
}

# Clean temporary files
log_message "Cleaning temporary files..."
sudo rm -rf /tmp/*
sudo rm -rf ~/.cache/*
log_message "Temporary files cleaned."

# Restart critical services
log_message "Restarting critical services..."
sudo systemctl restart networking
sudo systemctl restart ssh
log_message "Critical services restarted."

# Update and upgrade system packages
log_message "Updating system packages..."
sudo apt update && sudo apt upgrade -y
log_message "System packages updated and upgraded."

# Clean up unused packages and dependencies
log_message "Removing unused packages and dependencies..."
sudo apt autoremove -y
sudo apt autoclean
log_message "Unused packages and dependencies removed."

# Completion message
log_message "System optimization completed successfully."


#Make the script executable
chmod +x optimize_system.sh

#If the file is missing, create it using a text editor like nano or vim:
#Open the file using nano
nano optimize_system.sh

#Make it executable:
chmod +x optimize_system.sh


#Run it manually
./optimize_system.sh

#========================================
#END OF SCRIPT
#=============================