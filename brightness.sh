#! /bin/bash
cur_bright=$(cat /sys/class/backlight/intel_backlight/brightness)
max_bright=$(cat /sys/class/backlight/intel_backlight/max_brightness)

if [[ $1 == 'up' ]] 
	then
	let cur_bright=$cur_bright+100
fi

if [[ $1 == 'down' ]]
	then
	let cur_bright=$cur_bright-100
fi

if [[ $cur_bright -lt  $max_bright ]] && [[ $cur_bright -gt 100 ]]
	then
	echo "echo $cur_bright > /sys/class/backlight/intel_backlight/brightness" | sudo bash
fi
