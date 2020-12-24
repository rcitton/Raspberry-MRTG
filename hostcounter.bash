#! /bin/bash
COUNTER=$(nmap -sn 192.168.178.0/24|grep "Host is up" |wc -l)
echo $COUNTER
echo $COUNTER
