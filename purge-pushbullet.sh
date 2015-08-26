#!/bin/bash

# pass the pushbullet api file name to use for marking all alert notifcations as read

export PUSH_BULLET="../pushapi.txt"
export API=`cat $PUSH_BULLET`

for id in `curl -u $API: https://api.pushbullet.com/v2/pushes?modified_after=0 | sed -e 's/[{}]/''/g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | awk 'BEGIN { FS=":";} /iden/{  curiden=$2;  } /dismissed/ { if( $2 == "false" ) { print curiden ; } }'|sed s/\"//g` ; do
        curl -u $API: -X POST https://api.pushbullet.com/v2/pushes/$id --header 'Content-Type: application/json' --data-binary '{"dismissed": true}'
done

