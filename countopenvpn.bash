#!/bin/sh
J=$(cat /var/log/openvpn-status.log |grep "CLIENT_LIST" | tail -n +2 |wc -l)

echo $J
echo $J




