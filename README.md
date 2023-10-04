# 🕋 eSolat Shell Script
A simple shell script that retrieve current Malaysia prayer time based on area codes by JAKIM. \
May this be beneficial to those who find it useful. Insha'Allah

## Prerequisite
1. Host connected to the Internet (obviously)
2. `jq` installed

## Installation
1. Simply copy the `esolat.sh` file into your desired location (e.g. `/home/{USER}` path)
2. Be sure to grant executable `chmod +x {LOCATION}/esolat.sh`

## Usage
1. Run the script followed by the Area code (Refer list code from Jakim [here](https://zubirco.de/esolatcode))
Example: `./esolat.sh SGR01`

![image](https://github.com/zubir2k/esolat-cli/assets/1905339/317d35d8-bfb0-43be-8b0a-947bc58cd885)

## Use cases
1. Autorun this script during login to your machine via SSH
2. Geeky way to get your daily prayer time 😅

## Special Thanks
1. JAKIM for the [eSolat](https://www.e-solat.gov.my/) API
