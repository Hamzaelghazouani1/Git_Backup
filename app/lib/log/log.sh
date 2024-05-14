#!/bin/bash

log_file="./app/log/data.log"

log_command() {
    local command="$@"
    # Check if the log file exists
    if [ ! -f "$log_file" ]; then
        touch "$log_file"
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Log file created" >> "$log_file"
    fi
    # Log before executing the command
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Executing command: $command" >> "$log_file"

    # Execute the command and capture stderr
    command_output=$(eval "$command" 2>&1)
    exit_status=$?
    
    # Check the exit status
    if [ "$exit_status" -eq 0 ] && [ -z "$command_output" ]; then
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Command completed successfully: $command" >> "$log_file"
    else
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Command failed: $command" >> "$log_file"
        echo "$(date +"%Y-%m-%d %H:%M:%S") - error : $command_output" >> "$log_file"
    fi
}

# Call the function with the command passed as arguments
log_command "$@"