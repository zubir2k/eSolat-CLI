#!/bin/bash

# Function to convert numeric Hijri month to Arabic name
get_hijri_month_name() {
  case "$1" in
    01) echo "Muharram";;
    02) echo "Safar";;
    03) echo "Rabi'ul Awwal";;
    04) echo "Rabi'ul Akhir";;
    05) echo "Jamadil Awwal";;
    06) echo "Jamadil Akhir";;
    07) echo "Rajab";;
    08) echo "Sha'ban";;
    09) echo "Ramadan";;
    10) echo "Syawaal";;
    11) echo "Zulkaedah";;
    12) echo "Zulhijjah";;
    *) echo "Unknown";;
  esac
}

# Check if an area code argument is provided
if [ $# -ne 1 ]; then
  echo "[eSolat] Missing Area code!"
  echo "Usage: $0 <area_code>"
  echo "Refer here: https://zubirco.de/esolatcode"
  echo 
  exit 1
fi

# Get the area code from the command-line argument
area_code="$1"

# API URL with the area code
API_URL="https://www.e-solat.gov.my/index.php?r=esolatApi/takwimsolat&period=today&zone=${area_code}"

# Send a GET request to the API and store the response in a variable
response=$(curl -s "$API_URL")

# Check if the API response is empty or contains an error
if [ -z "$response" ]; then
  echo "[eSolat] Error: Failed to fetch data from the API."
  exit 1
fi

# Parse the response using jq (make sure jq is installed)
hijri=$(echo "$response" | jq -r '.prayerTime[0].hijri')
hijri_month_numeric=$(echo "$hijri" | awk -F "-" '{print $2}')
hijri_month_name=$(get_hijri_month_name "$hijri_month_numeric")
hijri_day=$(echo "$hijri" | awk -F "-" '{print $3}')
hijri_year=$(echo "$hijri" | awk -F "-" '{print $1}')
date=$(echo "$response" | jq -r '.prayerTime[0].date')
day=$(echo "$response" | jq -r '.prayerTime[0].day')
imsak=$(echo "$response" | jq -r '.prayerTime[0].imsak')
fajr=$(echo "$response" | jq -r '.prayerTime[0].fajr')
syuruk=$(echo "$response" | jq -r '.prayerTime[0].syuruk')
dhuhr=$(echo "$response" | jq -r '.prayerTime[0].dhuhr')
asr=$(echo "$response" | jq -r '.prayerTime[0].asr')
maghrib=$(echo "$response" | jq -r '.prayerTime[0].maghrib')
isha=$(echo "$response" | jq -r '.prayerTime[0].isha')

# Print the formatted prayer times
echo "Today: $(date +"%A, %d %B %Y")"
echo "Hijri Date: $hijri_day $hijri_month_name $hijri_year"h
echo "Time Now: $(date +"%I:%M%p")"
echo "Today prayer time ($area_code):"
echo "+---------+---------+---------+---------+---------+"
echo "|  Subuh  |  Zohor  |   Asar  | Maghrib |  Isyak  |"
echo "|---------|---------|---------|---------|---------|"
printf "| %s | %s | %s | %s | %s |\n" "$(date -d "$fajr" +%I:%M%p)" "$(date -d "$dhuhr" +%I:%M%p)" "$(date -d "$asr" +%I:%M%p)" "$(date -d "$maghrib" +%I:%M%p)" "$(date -d "$isha" +%I:%M%p)"
echo "'---------+---------+---------+---------+---------'"
