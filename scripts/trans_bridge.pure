#!/bin/bash
BRINT=br0
SWINT=eth0
COMPINT=eth1

echo 1 > /proc/sys/net/ipv4/ip_forward

brctl addbr $BRINT
brctl addif $BRINT $COMPINT
brctl addif $BRINT $SWINT

ifconfig $COMPINT 0.0.0.0 up promisc
ifconfig $SWINT 0.0.0.0 up promisc
ifconfig $BRINT 0.0.0.0 up promisc

mii-tool -r  $SWINT
mii-tool -r  $COMPINT
