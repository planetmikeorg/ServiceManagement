#!/bin/bash

# Run nmap scan
nmap  -p22,3389,5985,5986 -oX nmap_output.xml 10.1.10.0/24

# Convert XML to YAML
xmlstarlet sel -t -m '//host[ports/port[@portid="22" or @portid="5985" or @portid="5986"]]' -v 'address/@addr ports/@portid' -n nmap_output.xml > nmap_output.txt

# Create Ansible inventory file
echo "[linux]" > ansible_inventory.yml
awk '$2 == "22"' nmap_output.txt >> ansible_inventory.yml

echo "[windows]" >> ansible_inventory.yml
awk '$2 == "5985" || $2 == "5986"' nmap_output.txt >> ansible_inventory.yml