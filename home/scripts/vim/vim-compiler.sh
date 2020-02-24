#!/bin/bash
filename="$1"

if [[ $filename =~ ^.*.py$ ]];then

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

	python ~/scripts/vim/latexrun.py "$filename" && rm -r latex.out

	endtime=$EPOCHREALTIME

	runtime="$(echo "$endtime - $starttime" | bc -l)"
	echo [Finished in "$runtime"s]

else
	echo UnKnown File Type \""$filename"\"
fi
