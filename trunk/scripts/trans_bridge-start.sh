#!/bin/bash

# need bridge-utils and macchanger

SWMAC=f0:ad:4e:00:0d:79
COMPMAC=b8:ac:6f:5a:96:dd
COMIP=192.168.15.105
GWNET=192.168.15.0/24
DEFGW=192.168.15.1
BRINT=br0
SWINT=eth0
COMPINT=eth3
BRIP=169.254.66.66
RANGE=61000-62000

brctl addbr $BRINT
brctl addif $BRINT $COMPINT
brctl addif $BRINT $SWINT

ifconfig $COMPINT 0.0.0.0 up
ifconfig $SWINT 0.0.0.0 up
#ifconfig $COMPINT 0.0.0.0 up
macchanger -m $SWMAC br0 > /tmp/mac.txt 2> /tmp/mac.err
ifconfig $BRINT $BRIP up promisc

route  add -net $GWNET dev $BRINT
route add default gw $DEFGW
ebtables -t nat -A POSTROUTING -s $SWMAC -o $SWINT -j snat --to-src $COMPMAC
iptables -t nat -A POSTROUTING -o $BRINT -s $BRIP -p tcp -j SNAT --to $COMPIP:$RANGE


