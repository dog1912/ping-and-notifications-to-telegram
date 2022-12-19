#!/bin/bash
TOKEN=Token bot from telegram
function waitForHost
{
    if [ -n "$1" ];
    then
        waitForHost1 $1;
    else
        echo "waitForHost: Hostname argument expected"
    fi
}

function waitForHost1
{
    reachable=0;
    while [ $reachable -eq 0 ];
    do
    ping -q -c 1 $1
    if [ "$?" -eq 0 ];
    then
       if [[ "$1" = "lesnoy" ]]; then
        curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=234531726 -d text="$1 is up"
        curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=790786279 -d text="$1 is up"
        reachable=1
       elif [[ "$1" = "volkova" ]]; then
        curl -s -X POST https://api.telegram.org/bot$TOKENsendMessage -d chat_id=234531726 -d text="$1 is up"
        curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=790786279 -d text="$1 is up"
        curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=-1001725585015 -d text="Электричество включено"
        reachable=1
       else
        echo "Sending messages is not configured"
       fi
    fi
    done
    sleep 5

}
waitForHost $1

