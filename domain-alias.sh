#!/bin/bash

# Usage: sudo domain-alias.sh myapp 8000
domain=$1
port=$2

if [ -z "$domain" ] || [ -z "$port" ]; then
  echo "Usage: domain-alias.sh <domain> <port>"
  exit 1
fi

existing=$(cat /etc/hosts | grep $domain | cut -d' ' -f1)
if [ -n "$existing" ]; then
  localip=$existing
else
  last=$(cat /etc/hosts | grep -oP "127.0.0.\d" | cut -d'.' -f4 | sort -n | tail -1)
  next=$(expr $last + 1)
  localip="127.0.0.$next"
fi

{
  ifconfig lo0 alias $localip
  ipfw add fwd $localip,$port tcp from any to $localip dst-port 80
  echo "$localip $domain" >> /etc/hosts
} && echo "Done. Run apps at $localip port $port and view them at http://$domain/."
