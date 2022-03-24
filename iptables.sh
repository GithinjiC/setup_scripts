#!/bin/bash

set -x

lsmod | grep br_netfilter
if [ $? -eq 0 ]; then
  sysctl net.bridge.bridge-nf-call-iptables=1
  echo "Done."
else
  echo "br_netfilter module is not loaded"