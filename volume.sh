#! /bin/bash
#quick script (little flag checking) for volume control
#Dan Kolb 2015 <dan@dankolb.net>
#usage:
#volume.sh <up|down> <5|1|mute>

#get min/max limits as well as the current level used
limits_min=$(amixer get Master | grep "Limits:" | awk '{print $3}')
limits_max=$(amixer get Master | grep "Limits:" | awk '{print $5}')
cur_vol=$(amixer get Master | grep "Front Left:" | awk '{print $4}')

#find out what 5% of the limit will be
percent=$(echo "$limits_max * 0.05" | bc)
#divide by 1 to get rid of decimal
percent=$(echo "$percent / 1" | bc)


if [[ $2 -eq "5" ]] 
	then
	percent="0.05"
fi
if [[ $2 -eq "1" ]]
	then
	percent="0.01"
fi

#same as above
#did I mention this was done quickly with little flag checking?
per_change=$(echo "$limits_max * $percent" | bc)
per_change=$(echo "$per_change / 1" | bc)

#grab first argument to know whether togo up or down
if [[ $1 == "up" ]]
	then
	new_lev=$(echo "$cur_vol + $per_change" | bc)
fi
if [[ $1 == "down" ]]
	then
	new_lev=$(echo "$cur_vol - $per_change" | bc)
fi

#and check if it is to be muted. (afterthough)
if [[ $2 == "mute" ]]
	then
	new_lev=0
fi	

#run the actual command
amixer cset iface=MIXER,name="Master Playback Volume" $new_lev 1>/dev/null
