#This is for empty file, use index as the day
index=0
for f in $listFile
do
	index=$(expr $index + 1)
	day=`cut -f 1 "$f" | head -n 1`
	if [ -z "$day" ]
		then
			day="Day $index"
	fi
	count=`cut -f 3 "$f" | uniq -c | wc -l`
	printf "$day - number of unique user = $count \n"
done