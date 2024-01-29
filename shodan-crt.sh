#!/bin/bash

# Ensure URL is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1

# Step 1: Extract subdomains from crt.sh
echo "Extracting subdomains for $DOMAIN..."
curl -s "https://crt.sh/?q=${DOMAIN}&output=json" | jq . | grep name | cut -d":" -f2 | grep -v "CN=" | cut -d'"' -f2 | awk '{gsub(/\\n/,"\n");}1;' | sort -u > subdomains.txt

# Ensure subdomains were found
if [ ! -s subdomains.txt ]; then
    echo "No subdomains found for $DOMAIN."
    exit 1
fi

# Step 2: Resolve subdomains to IPs
echo "Resolving IPs for discovered subdomains..."
> ip-addresses.txt # Clear previous IP addresses if any
for i in $(cat subdomains.txt); do
    IP=$(host "$i" | grep "has address" | grep "$DOMAIN" | cut -d" " -f4)
    if [[ ! -z "$IP" ]]; then
        echo "$IP" >> ip-addresses.txt
    fi
done

# Ensure IPs were found
if [ ! -s ip-addresses.txt ]; then
    echo "No IP addresses found for subdomains of $DOMAIN."
    exit 1
fi

# Step 3: Shodan lookup for each IP
echo "Performing Shodan lookups..."
for i in $(cat ip-addresses.txt); do
    shodan host "$i"
done

echo "OSINT data collection complete for $DOMAIN."

