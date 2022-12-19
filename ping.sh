#!/bin/bash
TOKEN=Token bot from telegram
if [[ "$1" = "lesnoy" ]]; then
count=$(ping -c 4 "$1" | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
if [ $count -eq 0 ]; then
curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=234531726 -d text="No ping $1"
curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=790786279 -d text="No ping $1"
bash /root/scripts/pinger.sh $1 > /dev/null
wait
fi
elif [[ "$1" = "volkova" ]]; then
count=$(ping -c 4 "$1" | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
if [ $count -eq 0 ]; then
curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=234531726 -d text="No ping $1"
curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=790786279 -d text="No ping $1"
curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=-1001725585015 -d text="Электричество выключено"
bash /root/scripts/pinger.sh $1 > /dev/null
wait
fi
else
    echo "FAIL"
fi
