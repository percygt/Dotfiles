#!/bin/bash

sleep 20

# Kill switch
protonvpn-cli ks --off
protonvpn-cli ks --on

# Netshield
protonvpn-cli ns --off
# or --malware if you don't want to block ads
protonvpn-cli ns --ads-malware

# Start VPN
protonvpn-cli c -f
