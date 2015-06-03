#!/bin/bash
urlFile="urlList.txt"
#urlFile="urlListExtra.txt"

downloadFolder = "download/"

while read url
do
	echo "Download from $url"
    wget -P $downloadFolder $url
done < $urlFile


