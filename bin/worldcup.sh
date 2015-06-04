#!/bin/bash
URL="https://s3-ap-northeast-1.amazonaws.com/aucfan-tuningathon/dataset/"
listFileNames="fileNames.txt"
downloadFolder="download/"
ext=".gz"
sumDataFile="sumData.txt"

#================Input processing===========================
if [ ! -z "$1" ];
then
	listFileNames=$1
fi
echo "Take file names from: $listFileNames"

if [ ! -z "$2" ];
then
	URL=$2
fi
echo "Download (if needed) from: $URL"


#================= Download if file are missing ===================
while read fileName
do
	if [ ! -f "$downloadFolder$fileName$ext" ];
	then
		wget --no-check-certificate -O "$downloadFolder$fileName$ext" "$URL$fileName$ext"
	fi
done < $listFileNames


#========== unzip and merge files ============================
printf "Unziping and merging......."
zcat -c ${downloadFolder}* > $sumDataFile
printf "done\n\n"


#=================Count Total =====================
totalCount=`cut -f 3 "$sumDataFile" | sort | uniq | wc -l`
printf "Number of unique user in TOTAL = $totalCount  \n\n"


#====================Count by day=========================
daysFileName="days.txt"
cut -f 1 $sumDataFile | sort | uniq > $daysFileName

while read day
do
    dayCount=`grep $day $sumDataFile | cut -f 3 | sort -u | wc -l`
	printf "$day has $dayCount unique users\n"
done < $daysFileName
rm $daysFileName
printf "\n"

#====================Count by region=========================
regionFileName="region.txt"
cut -f 2 $sumDataFile | sort | uniq > $regionFileName

while read region
do
    regionCount=`grep $region $sumDataFile | cut -f 3 | sort -u | wc -l`
	printf "$region has $regionCount unique users\n"
done < $regionFileName
rm $regionFileName
