# simple backup for the choosen directories and databases

0. backup_data.sh should be on remote
1. run: ./backmeup.sh should be run on the local machine
chosen folders will be compressed via `tar` and transfered back via rsync
chosen databases will be saved as .sql and transfered back to the local machine via rsync as well.

