#!/bin/bash
set -e

# Define variables
github_repo="https://github.com/cloudboostauk/resturant.git"
github_branch="main"
website_dir="/var/www/html"

# Update package lists
apt update -y

# Install required packages
apt install -y apache2 mysql-server php git

# Enable and start Apache
systemctl enable apache2
systemctl start apache2

# Ensure web root directory exists
mkdir -p "$website_dir"
chown ubuntu:ubuntu "$website_dir"

# Delete existing files in web root
rm -rf "$website_dir"/*

# Clone the GitHub repo
git clone -b "$github_branch" "$github_repo" "$website_dir"

# Set ownership and permissions for website files
chown -R www-data:www-data "$website_dir"

# Restart Apache service
systemctl restart apache2
