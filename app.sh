#!/bin/bash


# ---> Setup the environment
# Manage Log file for the script (log all activities, errors, warnings, info, debug) //history.log
# Get time to run the script
# Setup cron job to run the script at a specific time

# ---> Use sub process to run fealds of the script (file management, git, etc)

# ---> setup folder
# Get info from user (folder,etc)
# Check if folder exists, if not create it

# ---> Use sub process to run the script as root if not running as root (or other techniques)
# ---> setup git
# Check if git is installed
# If not install git

# ---> setup git config
# Check if git is configured
# If not configure git

# ---> setup repo
# Init git repo and add remote origin

# ---> Filter files in sub folders and divide them into folders based on file type (images, videos, docs, etc)
# Get all files in the folder
# Filter files based on file type
# Create folders based on file type
# Move files to respective folders

# ---> compress files
# Compress folder into a zip file

# ---> Crypt folder Copression encrypt/decrypt (use any algorithm) with password
# Get password from user
# Encrypt folder
# Decrypt folder
# Save password in a secure file accessible only by the user


# ---> push to remote
# Add files to git
# Commit files
# Push to remote

# ---> Run process in the background
# ---> Notify user of completion (optional) containe link of page index.html containing all files in the folder with the info based on log file and other info
# ---> Exit script