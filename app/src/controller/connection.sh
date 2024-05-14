checkConnection(){
    echo "Checking connection..."
    ping -c 1 github.com >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Connection successful"
    else
        echo "Connection failed :("
        echo "Please check your internet connection and try again."
        echo "Exiting..."
        exit 1
    fi
}