#!/bin/bash
dataFolder="data"
listFile="$dataFolder/*"

#===========================================
#		Merge all files
printf "\n\nPreparing for total data..."
sumDataFileName="sumData.txt"

#If file already exist, delete it
if [ -a $sumDataFileName ]
	then
	rm $sumDataFileName
fi

cat $listFile >> "$sumDataFileName"
printf "done\n"
#==========================================



totalCount=`cut -f 3 "$sumDataFileName" | uniq | wc -l`
printf "Number of unique user in TOTAL = $totalCount  \n\n"
#========================================================




daysFileName="days.txt"
cut -f 1 $sumDataFileName | sort | uniq > $daysFileName

while read day
do
    dayCount=`grep $day $sumDataFileName | cut -f 3 | uniq | wc -l`
	printf "$day has $dayCount unique users\n"
done < $daysFileName
rm $daysFileName
printf "\n"
#============================================================



regionFileName="region.txt"
cut -f 2 $sumDataFileName | sort | uniq > $regionFileName

while read region
do
    regionCount=`grep $region $sumDataFileName | cut -f 3 | uniq | wc -l`
	printf "$region has $regionCount unique users\n"
done < $regionFileName
rm $regionFileName
