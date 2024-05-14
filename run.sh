source ./app/src/main.sh
source ./app/src/controller/menu.sh
if [ ! $(cat ./app/src/data/status.bin) ]; then
    main
else
    options "$@"
fi