#!/bin/bash

server_name=`hostname`

Log_PATH=puppet-client
loop_count=`ls -lt $Log_PATH | grep -v total | wc -l`

for ((i = 1 ; i <= $loop_count ; i++)); do

check_file=`ls -lt $Log_PATH | grep -v total | sed -n "$i p" |awk '{print $9}' `
successful=`cat $Log_PATH/$check_file | grep -i successful`
if [ $? == 0 ]; then
 echo "output=$server_name:$check_file"
 exit
fi

if [ $i == $loop_count ]; then
echo "output=$server_name:$check_file" 
fi

done
