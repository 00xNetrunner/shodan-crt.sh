#!/bin/bash

# Created by 00xNetrunner
# I got inspired to write this script when i was doing the foot printing module on HTB Academy. i thought it could do with some automation. 

# Ensure a domain is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

# Assign the first argument as the domain to be processed
DOMAIN=$1

# Step 1: Extract subdomains using crt.sh
echo "Extracting subdomains for $DOMAIN..."
# Fetch data from crt.sh, parse JSON, filter and clean data to get subdomains, and store results in subdomains.txt
curl -s "https://crt.sh/?q=${DOMAIN}&output=json" | jq . | grep name | cut -d":" -f2 | grep -v "CN=" | cut -d'"' -f2 | awk '{gsub(/\\n/,"\n");}1;' | sort -u > subdomains.txt

# Check if subdomains were found, exit if none
if [ ! -s subdomains.txt ]; then
    echo "No subdomains found for $DOMAIN."
    exit 1
fi

# Step 2: Resolve each subdomain to an IP address
echo "Resolving IPs for discovered subdomains..."
# Clear the file to store IPs
> ip-addresses.txt
for i in $(cat subdomains.txt); do
    # Resolve subdomain to IP and filter relevant information
    IP=$(host "$i" | grep "has address" | grep "$DOMAIN" | cut -d" " -f4)
    # If an IP is found, append it to ip-addresses.txt
    if [[ ! -z "$IP" ]]; then
        echo "$IP" >> ip-addresses.txt
    fi
done

# Check if IPs were found, exit if none
if [ ! -s ip-addresses.txt ]; then
    echo "No IP addresses found for subdomains of $DOMAIN."
    exit 1
fi

# Step 3: Query each IP against the Shodan database
echo "Performing Shodan lookups..."
for i in $(cat ip-addresses.txt); do
    # Perform a Shodan search for each IP
    shodan host "$i"
done

echo "OSINT data collection complete for $DOMAIN."
