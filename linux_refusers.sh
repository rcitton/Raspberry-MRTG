#!/bin/sh
l=`grep -E 'BREAK-IN|Invalid|Failed|refused|Illegal' /var/log/auth.log* | wc -l`
echo $l
echo $l

