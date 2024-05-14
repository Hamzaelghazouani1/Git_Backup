source app/src/view/setup.sh
source app/lib/crone/crone.sh

timeBackup(){
    timeBackupEcho
    read time
    case $time in
        1)
            echo "Every 1 day"
            setup_cron_job 1 "bash $PWD/app/src/main.sh" >/dev/null 2>&1 &
            ;;
        2)
            echo "Every 2 days"
            setup_cron_job 2 "bash $PWD/app/src/main.sh" >/dev/null 2>&1 &
            ;;
        3)
            echo "Every 3 days"
            setup_cron_job 3 "bash $PWD/app/src/main.sh" >/dev/null 2>&1 &
            ;;
        4)
            echo "Every 4 days"
            setup_cron_job 4 "bash $PWD/app/src/main.sh" >/dev/null 2>&1 &
            ;;
        5)
            echo "Every 5 days"
            setup_cron_job 5 "bash $PWD/app/src/main.sh" >/dev/null 2>&1 &
            ;;
        6)
            echo "Every 6 days"
            setup_cron_job 6 "bash $PWD/app/src/main.sh" >/dev/null 2>&1 &
            ;;
        7)
            echo "Every 7 days"
            setup_cron_job 7 "bash $PWD/app/src/main.sh" >/dev/null 2>&1 &
            ;;
        *)
            echo "Invalid option"
            clear
            timeBackup
            ;;
    esac

}