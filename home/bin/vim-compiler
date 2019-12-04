#!/bin/bash
filename="$1"

if [[ $filename =~ ^.*.py$ ]];then
	clear
	starttime=$EPOCHREALTIME

	python -u $filename

	endtime=$EPOCHREALTIME

	runtime="$(echo "$endtime - $starttime" | bc -l)"
	echo [Finished in "$runtime"s]

elif [[ $filename =~ ^.*.sh$ ]];then
	starttime=$EPOCHREALTIME

	sh $filename

	endtime=$EPOCHREALTIME

	runtime="$(echo "$endtime - $starttime" | bc -l)"
	echo [Finished in "$runtime"s]


elif [[ $filename =~ ^.*.c$ ]];then
	echo C file


elif [[ $filename =~ ^.*.cpp$ ]];then
	echo Cpp file


elif [[ $filename =~ ^.*.tex$ ]];then

	starttime=$EPOCHREALTIME

	python /home/rohnch/bin/latexrun.py $filename

	endtime=$EPOCHREALTIME

	runtime="$(echo "$endtime - $starttime" | bc -lc)"
	echo [Finished in "$runtime"s]

	read -p "remove latex.out? (y/n)" cleartex
	if [[ $cleartex == y ]];then
		rm -r latex.out
	fi
else
	echo UnKnown File Type \""$filename"\"
fi
