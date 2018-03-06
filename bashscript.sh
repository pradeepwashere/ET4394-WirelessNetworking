#!/bin/bash

echo "The current working directory: $PWD"
_mydir="$(pwd)"
mkdir ${_mydir}/Proper$(date "+_%M_%H_%d_%Y")
cd Proper$(date "+_%M_%H_%d_%Y")
tshark -T fields -e wlan_mgt.ssid -e wlan.addr -E separator="/t" -i mon1 -a duration:500 -I > bigdata$(date "+%b_%d_%Y").txt 
awk -F'\t' '{print $1}' bigdata$(date "+%b_%d_%Y").txt > mediumdata$(date "+%b_%d_%Y").txt
awk -F, '{x[$1];}END{for(y in x){print y,x[y]}}' mediumdata$(date "+%b_%d_%Y").txt > finaldata$(date "+%b_%d_%Y").txt
echo "Starting sniffing hidden packets"
tshark -i mon1 -a duration:30| grep  Beacon | grep -e '=\00' -e SSID=Broadcast | awk '{print $3}' | awk -F, '{x[$1];}END{for(y in x){print y,x[y]}}' | wc -l > count$(date "+%b_%d_%Y").txt

