#!/bin/bash
TOKEN='Token bot from telegram'
PING_TIMEOUT=5
declare -A TARGETS
TARGETS=([host1]="chat id channel" [host2]="chat id channel")

target=$1
chat_ids=${TARGETS[$target]}

if [ -z "$chat_ids" ]; then
    echo "Invalid target. Expected one of: ${!TARGETS[@]}"
    exit 1
fi

count=$(ping -c 4 -w $PING_TIMEOUT $target | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')

if [ $count -eq 0 ]; then
    for chat_id in $chat_ids; do
        start_time=$(date +%s)
        curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$chat_id -d text="Server unavailable"
    done
    function waitHost
    {
        if [ -n "$target" ];
        then
            waitForHost $target;
        else
            echo "waitHost: Hostname argument expected"
        fi
    }

    function waitForHost
    {
        reachable=0;
        while [ $reachable -eq 0 ];
        do
        ping -q -c 1 $target
        if [ "$?" -eq 0 ];
        then
            chat_ids=${TARGETS[$1]}
            if [ -n "$chat_ids" ]; then
                for chat_id in $chat_ids; do
                    end_time=$(date +%s)
                    diff_time=$((end_time-start_time))
                    hours=$((diff_time / 3600))
                    minutes=$(((diff_time / 60 + 1) % 60))
                    curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$chat_id -d text="Server vailable. Server didn't respond : $hours hrs $minutes min"
                done
                reachable=1
            else
                echo "Sending messages is not configured for $target"
            fi
        fi
        done
        sleep 5
    }
    waitHost $target
fi
