#!/bin/bash

# Verify if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Destination paths
GRUB_BK_DEST="/etc/default/grub.bk"
CHANGE_BACKGROUND_DEST="/usr/local/sbin/change_background"
SERVICE_DEST="/etc/systemd/system/change-background.service"

# Source files for the script and service
CHANGE_BACKGROUND_SRC="./change_background"
SERVICE_SRC="./change-background.service"

# Create a backup of /etc/default/grub as grub.bk
if [ -f "/etc/default/grub" ]; then
    echo "Creating a backup of /etc/default/grub at $GRUB_BK_DEST..."
    cp /etc/default/grub "$GRUB_BK_DEST" || { echo "Failed to create backup"; exit 1; }
else
    echo "Error: /etc/default/grub does not exist. Ensure GRUB is installed."
    exit 1
fi

# Copy the change_background script and set executable permissions
echo "Copying $CHANGE_BACKGROUND_SRC to $CHANGE_BACKGROUND_DEST..."
cp "$CHANGE_BACKGROUND_SRC" "$CHANGE_BACKGROUND_DEST" || { echo "Failed to copy $CHANGE_BACKGROUND_SRC"; exit 1; }
chmod +x "$CHANGE_BACKGROUND_DEST" || { echo "Failed to set executable permissions on $CHANGE_BACKGROUND_DEST"; exit 1; }

# Copy the systemd service file
echo "Copying $SERVICE_SRC to $SERVICE_DEST..."
cp "$SERVICE_SRC" "$SERVICE_DEST" || { echo "Failed to copy $SERVICE_SRC"; exit 1; }

# Reload systemd and enable the service
echo "Reloading systemd and enabling the service..."
systemctl daemon-reload || { echo "Failed to reload systemd"; exit 1; }
systemctl enable change-background.service || { echo "Failed to enable the service"; exit 1; }

# Final message
echo "Files installed successfully. Modify the file /usr/local/sbin/change_background to set a valid path."
echo "This line: --> echo GRUB_BACKGROUND=\"/home/ak/Imágenes/grub2/\"\$((1 + RANDOM %30)).\".png\" > /etc/default/grub"

