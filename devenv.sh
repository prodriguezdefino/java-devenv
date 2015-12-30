#!/bin/bash


case "$1" in
    down)
        source devenv-down.sh
        ;;
    reload)
        source devenv-reload-containers.sh
        ;;
    logs)
        source devenv-logs.sh $2
        ;;
    status)
        source devenv-status.sh
        ;;
    up)
        source devenv-up.sh
        ;;
    inspect)
        source devenv-inspect.sh $2
        ;;
     
    *)
        echo $"Usage: $0 {down|reload|logs <container>|up|inspect <container>|status}"
        exit 1
esac