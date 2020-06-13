#!/bin/bash
source dawncalc.sh

# Calculate dawn and dusk +- 30 Minutes for start and stop of todays recording timespan
imgstart=$(/bin/date -d "$AufgangStunde:$AufgangMinute today - 0 min" +'%Y%m%d%H%M')
imgstop=$(/bin/date -d "$UntergangStunde:$UntergangMinute today + 0 min" +'%Y%m%d%H%M')

# Output todays recording timespan
echo "Recording between $(/bin/date -d "$AufgangStunde:$AufgangMinute today - 0 min" +'%H:%M') and $(/bin/date -d "$UntergangStunde:$UntergangMinute today + 0 min" +'%H:%M')"

# Get current date as numeric to calculate with
dnow=$(/bin/date -d now  +'%Y%m%d%H%M')

# If the current time lies between the recording timespan
if [ $dnow -ge $imgstart ] && [ $dnow -le $imgstop ]
then
	/bin/echo "It's bright outside"
	DATE=$(/bin/date +"%Y_%m_%d_%H_%M_%S")
	year=$(/bin/date "+%Y")
	month=$(/bin/date "+%m")
	day=$(/bin/date "+%d")
	/bin/mkdir -p /home/pi/images/cam1/"$year"/"$year"_"$month"/"$year"_"$month"_"$day"
	cd /home/pi/images/cam1/"$year"/"$year"_"$month"/"$year"_"$month"_"$day" || exit

	/usr/bin/raspistill -q 8 -sa 5 -w 1280 -h 960 -awb sun -o cam1_"$DATE".jpg
	
else
	/bin/echo "It's dark outside"
fi
