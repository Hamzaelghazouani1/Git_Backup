setup_cron_job() { 

    if [ $# -ne 2 ]; then
        echo "Usage: setup_cron_job <interval> <path>"
        return 1
    fi
    
    crontab -l | grep -q "$2"

    if [ $? -ne 0 ]; then
        (crontab -l ; echo "0 9 */$1 * * $2") | crontab -
        echo "Cron job set up successfully"
    else
        echo "Cron job already exists"
    fi
}