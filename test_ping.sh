#! /bin/bash
#quick ping test
#Dan Kolb 2015 <dan@dankolb.net>
url="google.com"
response=$(ping -c1 $url 2>&1 | grep -Po "time=\d*\.\d*" | awk -F= '{print $2}')
if [[ $response == "" ]] 
	then
	echo "999"
else
	echo $response
fi

