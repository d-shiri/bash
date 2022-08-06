#!/bin/bash
# This file should be run on the destination machine (local)
echo ''
echo "=============LOCAL MACHINE============="
echo "=================BEGIN================="
echo ''
DIR="backup_data"
if [ ! -d $DIR ];
then
	echo "$DIR folder does not exists! Making it..."
	mkdir $DIR
	else
	echo "Note: Following file/s are already in the back_data folder in your local machine!"
	ls $DIR
fi
sleep 1
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
# run backup_data.sh on the remote machine
ssh user@example.com './backup_data.sh'
sleep 1
# get the data from remote (change the directories if you want)
rsync -chavz --stats user@example.com:/root/$DIR ./$DIR
echo ''
mv $DIR/$DIR $DIR/$DIR_$current_time
echo "CHECK OUT THE FOLLOWING FOLDER TO SEE THE RESULTS:"
echo $DIR_$current_time
echo "=====ALL FILES ARE TRANSFERED TO THE DESTINATION FOLDER====="
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
