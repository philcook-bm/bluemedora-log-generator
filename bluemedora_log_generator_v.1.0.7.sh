#!/bin/bash
# tail Script
#Created by Phil Cook @ Blue Medora, Inc. 
#v1.0.7 last modified:10/4/2018


#setting a time variable to 60 seconds
declare seconds=60
echo -e "
 _____ __    _____ _____    _____ _____ ____  _____ _____ _____ 
| __  |  |  |  |  |   __|  |     |   __|    \|     | __  |  _  |
| __ -|  |__|  |  |   __|  | | | |   __|  |  |  |  |    -|     |
|_____|_____|_____|_____|  |_|_|_|_____|____/|_____|__|__|__|__|
"
echo ========================================
echo Blue Medora Log Generator Script v.1.0.7
echo ========================================


#make sure logs are in debug before continuing.
echo "Are your logs set to debug?"
select yn in "Yes" "No"; do
   case $yn in
        Yes )  break;;
        No ) echo "Please navigate to vROps UI and set the logging to debug. Then run this script again."; exit;;
   esac
done

#read the results of the ls command and place each one into an option in the menu.
IFS=$'\n' read -d '' -ra lines < <(ls $ALIVE_BASE/user/log/adapters/) 


echo
cd $ALIVE_BASE/user/log/adapters/
echo "Please select the management pack you wish to tail the logs for:"
echo =================================================================

#When an option is selected, store the value in a variable.
select adapter in "${lines[@]}"; do
  [[ -n $adapter ]] || { echo "Invalid choice. Please try again." >&2; continue; }
  break # valid choice was made; exit prompt.


done

#read the results of the ls command and place each one into an option in the menu.
IFS=$'\n' read -d '' -ra lines < <(ls $ALIVE_BASE/user/log/adapters/$adapter)
cd $ALIVE_BASE/user/log/adapters/$adapter
echo
echo "Which log file  would you like to tail the log for?"
echo ====================================
echo
echo The ID of the log file corresponds with the instance ID of the adapter instance object in vROps. 
echo For information on how to find the instance ID, please copy and paste this URL into a browser:
echo
echo  https://support.bluemedora.com/s/article/Identifying-a-vROps-Object-s-Internal-ID
echo
echo

#When an option is selected, store the value in a variable.
select adapterlog in "${lines[@]}"; do
  [[ -n $adapterlog ]] || { echo "Invalid choice. Please try again." >&2; continue; }
  break # valid choice was made; exit prompt.

done
echo "How many minutes do you want to tail the log for?"
echo ===================================================

#record the response and place it into a variable.
read runtime

#the input is in minutes but the sleep command actually processes seconds, so we need to create a new variable which is the user input multiplied by 60.
totalruntime=$((seconds*runtime))

#take the previous input for the log file to tail, and then execute the tail command with the new sleep parameter calculated. Kill the process after that time has expired.
read adapterlog & tail -F $adapterlog | tee longrun_$adapterlog & sleep $totalruntime; kill $!
echo
echo
#print the location of the log that was generated.
echo "Log location: $ALIVE_BASE/user/log/adapters/$adapter/longrun_$adapterlog"
echo
echo "Please create a light support bundle from the vROps UI and upload it to our FTP server. Copy and paste the URL below into a browser for connection information:"
echo
echo "https://support.bluemedora.com/s/article/Blue-Medora-FTP-Server"
echo 
echo
echo "Thanks for using this tool! Please run 'rm bluemedora_log_generator_v.1.0.7.sh' to clean up. Don't forget to take your logs out of debug mode!"