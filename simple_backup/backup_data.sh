#!/bin/bash
# This file should be located on a remote machine
GREEN="\033[1;32m"
NC="\033[0m"
cecho(){
	# [0 means not bold and [1 means bold text
    RED="\033[1;31m" 
    GREEN="\033[1;32m"
    YELLOW="\033[1;33m" 
    CYAN="\033[1;36m"
    NC="\033[0m" # No Color

    # printf "${(P)1}${2} ${NC}\n" # <-- zsh
    printf "${!1}${2} ${NC}\n" # <-- bash
}
echo ''
echo "=============REMOTE MACHINE============="
echo "=================BEGIN================="
echo ''
echo "------------------Date--------------------"
cecho "CYAN" "||>> $(date) <<||"
echo "------------------------------------------"
echo ''
# Getting the current time in order to add to the file name
current_time=$(date "+%Y.%m.%d-%H.%M.%S")
# Folder that we save all the files in
DIR="backup_data"
if [ ! -d $DIR ]; 
then
	cecho "RED" "$DIR folder does not exists! Making it..."
	mkdir $DIR
	else
	cecho "RED"  "Note: Following file/s are already in the back_data folder!"
	ls $DIR -alF -h
fi
sleep 1



if [ "$(ls -A $DIR)" ]; then
    cecho "RED" "Removing existing data at $DIR folder ..."
	rm /root/$DIR/*.*
else
    cecho "GREEN" "$DIR is Empty!"
fi
sleep 1
echo ''
cecho "GREEN" "Initiating backup process ..."
echo ''
echo "---------FOLDERS----------"
# directories to be backed up
for directory in /var/www /var/webmin /var/lib/ /etc /run
do
	printf "Backing up ${GREEN}$directory${NC} directory.\n"

done
# directories to be backed up
tar -czf ./$DIR/drposture_$current_time.tar.gz  /var/www /var/webmin /var/lib/ /etc
sleep 1
echo ''
echo "---------DATABASE----------"
# databases to be backed up
for name in test1 test2 all
do

	if [[ $name == all ]]
	then
		printf "Backing up ${GREEN}AllDatabaseBackup.sql${NC} database.\n"
		mysqldump --all-databases -u root  > ./$DIR/AllDatabaseBackup.sql
	else
		printf "Backing up ${GREEN}$name${NC} database.\n"
		mysqldump -u root $name > ./$DIR/$name.sql
	fi
done
echo "---------------------------"
cecho "GREEN" "The following files are gonna be transfered to you local machine."
ls $DIR
echo ''
echo "==========END OF BACKUP PROCESS========="
cecho "CYAN" "ALL DONE! auf Wiedersehen. :)"
echo ''

