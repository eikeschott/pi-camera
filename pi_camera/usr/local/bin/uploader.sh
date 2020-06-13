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
if [ $dnow -ge $imgstart ] && [ $dnow -le $imgstop ];
then
	if ping -c 1 192.168.188.42 &> /dev/null;
	then
		echo "Upload"
		/usr/bin/rclone move /home/pi/images/ eikeschott:pi_camera/ -q --delete-empty-src-dirs --delete-after --retries 1 --stats-one-line 
	else
		echo "No connection"
	fi 
else
	echo "Not within timerange"
fi
