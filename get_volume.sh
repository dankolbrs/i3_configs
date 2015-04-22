#! /bin/bash
#script to report current volume (to be displayed in conky)
#Dan Kolb 2015 <dan@dankolb.net>
#usage:
#get_volume.sh 
amixer get Master 2>&1 | grep "Front Right:" | awk '{print $5}' | sed -e 's/\[//' -e 's/\]//' -e 's/\%//'
