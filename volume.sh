#! /bin/bash
#quick script (little flag checking) for volume control
limits_min=$(amixer get Master | grep "Limits:" | awk '{print $3}')
limits_max=$(amixer get Master | grep "Limits:" | awk '{print $5}')
cur_vol=$(amixer get Master | grep "Front Left:" | awk '{print $4}')

#echo "cur $cur_vol"
#echo "min $limits_min"
#echo "max $limits_max"

percent=$(echo "$limits_max * 0.05" | bc)
percent=$(echo "$percent / 1" | bc)

#echo $percent

if [[ $2 -eq "5" ]] 
	then
	percent="0.05"
fi
if [[ $2 -eq "1" ]]
	then
	percent="0.01"
fi

per_change=$(echo "$limits_max * $percent" | bc)
per_change=$(echo "$per_change / 1" | bc)

if [[ $1 == "up" ]]
	then
	new_lev=$(echo "$cur_vol + $per_change" | bc)
fi
if [[ $1 == "down" ]]
	then
	new_lev=$(echo "$cur_vol - $per_change" | bc)
fi

if [[ $2 == "mute" ]]
	then
	new_lev=0
fi	
amixer cset iface=MIXER,name="Master Playback Volume" $new_lev 1>/dev/null
