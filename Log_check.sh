#!/bin/bash
#====================================================================
#script Function: Get the patch successful/Failed Dates from BAP Log
#This script is working based on Puppet Facts concept
#Analysing BAP log to Generate patch successful/Failed dates
#====================================================================

server_name=`hostname`
Today=`date +%Y-%m-%d`
Log_Dir=/var/log/${server_name}
loop_count=`ls -lt ${Log_Dir} | grep -v total | wc -l`

for ((i = 1 ; i <= $loop_count ; i++)); do
covert_to_date=`ls -lt ${Log_Dir} | grep -v total | sed -n "$i p" |awk '{print $9}' | cut -c 1-10`
Day_difference="$(( ($(date -d $Today +%s) - $(date -d $covert_to_date +%s)) / 86400 ))"

  if (( ${Day_difference} < 29 )); then
    check_file=`ls -lt ${Log_Dir} | grep -v total | sed -n "$i p" |awk '{print $9}'`
    successful=`cat ${Log_Dir}/${check_file} | grep -i successfully | sed -n "1 p"|awk '{print $1}'`
    completed=`cat ${Log_Dir}/${check_file} | grep -i complete  | sed -n "1 p"|awk '{print $1}'`
  
        if [[ ${successful} == "Successfully" || ${completed} = "Complete!"  ]]; then
 
	   if (( ${Day_difference} < 29 )); then
	      echo "patch_successful=${server_name}:${covert_to_date}"
              patch_successful="${server_name}:${covert_to_date}"
              break
	   fi
        fi
  fi  
done
  
if [ -z ${patch_successful} ]; then
    
   for ((i = 1 ; i <= $loop_count ; i++)); do
      covert_to_date=`ls -lt ${Log_Dir} | grep -v total | sed -n "$i p" |awk '{print $9}' | cut -c 1-10`
      Day_difference="$(( ($(date -d $Today +%s) - $(date -d $covert_to_date +%s)) / 86400 ))"
  
          if (( ${Day_difference} > 29 )); then
             check_file=`ls -lt ${Log_Dir} | grep -v total | sed -n "$i p" |awk '{print $9}'`
             successful=`cat ${Log_Dir}/${check_file} | grep -i successfully | sed -n "1 p"|awk '{print $1}'`
  
             if [ -z ${successful} ]; then
               echo "patch_failed=${server_name}:${covert_to_date}"
               break
             fi
          fi
   done
fi
