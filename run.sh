-#!/bin/bash

# Gaganode
GAGA_TOKEN="cfvsvbhgizffvhksa3ade4250b753862"

# Grass CLI
GR_MAIL=""
GR_PASS=""

line_count=1

text="abc"
sed 's/^[[:space:]]*//;s/[[:space:]]*$//' ./proxy/proxy.txt > ./proxy/new_proxy.txt
while IFS=: read -r admin password ip port ; do
    str="$line_count | -> $admin:$password@$ip:$port <-"
    echo -e $str
    docker run -d --restart always --name $line_count$text$line_count -i -t --privileged \
                -v /etc/machine-id:/etc/machine-id:ro \
                -e PROXY_SERVER=$ip \
                -e PROXY_PORT=$port \
                -e PROXY_LOGIN=$admin \
                -e PROXY_PASSWORD=$password \
                -e GAGA_TOKEN=$GAGA_TOKEN \
                -e GRASS_MAIL=$GR_MAIL \
                -e GRASS_PASS=$GR_PASS \
                cli_v2:latest
    line_count=$((line_count + 1))
    sleep 1
done < ./proxy/new_proxy.txt
