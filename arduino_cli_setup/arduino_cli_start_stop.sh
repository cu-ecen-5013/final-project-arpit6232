#!/bin/sh

case "$1" in
    start)
        # Install arduino libraries"
        /home/root/cli.sh
        ;;
    stop)
        # DO NOTHING
        ;;
    *)
        echo "Usage: $0 {start|stop}"
    exit 1
esac
exit 0    
