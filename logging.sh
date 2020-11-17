#!/bin/bash

SERVER="192.168.1.100"
PORT=514

log() {
    ##declare -A levels=([emerg]=0 [alert]=1 [critcal]=2 [err]=3 [warning]=4 [notice]=5 [info]=6 [debug]=7)
    local message=$1
    local level=$2
    ##[[ -n "${levels[$level]}" ]] || exit 1

    case "$level" in
        0)
        echo "<128>${0##*/}[$$]: emerg level: $message # 128" | nc -w1 -u "$SERVER" "$PORT"
        ;;

        1)
        echo "<129>${0##*/}[$$]: alert level: $message # 129" | nc -w1 -u "$SERVER" "$PORT"
        ;;

        2)
        echo "<130>${0##*/}[$$]: critical level: $message # 130" | nc -w1 -u "$SERVER" "$PORT"
        ;;
        
        3)
        echo "<131>${0##*/}[$$]: err level: $message # 131" | nc -w1 -u "$SERVER" "$PORT"
        ;;

        4)
        echo "<132>${0##*/}[$$]: warning level: $message # 132" | nc -w1 -u "$SERVER" "$PORT"
        ;;

        5)
        echo "<133>${0##*/}[$$]: notice level: $message # 133" | nc -w1 -u "$SERVER" "$PORT"
        ;;

        6)
        echo "<150>${0##*/}[$$]: info level: $message # 150" | nc -w1 -u "$SERVER" "$PORT"
        ;;

        7)
        echo "<151>${0##*/}[$$]: debug level: $message # 151" | nc -w1 -u "$SERVER" "$PORT"
        ;;

        *)
            echo "invalid syslog level"
    esac
}
