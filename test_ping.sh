#! /bin/bash
#quick ping test
#Dan Kolb 2015 <dan@dankolb.net>
url="google.com"
ping -c1 $url | grep -Po "time=\d*\.\d*" | awk -F= '{print $2}'

