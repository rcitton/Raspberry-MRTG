#!/bin/sh
J=$(cat /var/log/openvpn.log|grep "Peer Connection Initiated" |wc -l)

echo $J
echo $J




