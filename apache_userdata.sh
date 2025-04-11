#!/bin/bash
# Update the package list
apt update -y

# Install Apache2 web server
apt install -y apache2

# Ensure Apache is started and enabled at boot
systemctl start apache2
systemctl enable apache2

# Create a simple HTML page
echo "<h1>Welcome to Ansible Web Server</h1>" > /var/www/html/index.html
