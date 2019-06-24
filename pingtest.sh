#!/bin/bash

#Please have the file in the same directory as the script before running!

log_location="$(pwd)"
datestamp=$(date +"%m%d%Y%H%M")
log="$datestamp-test_file.txt"
read -p "What is the name of the csv file?: " file_name
echo "Writing a log to $log_location "

# IF CSV has more than 6 columns, please add them here (A = col1, B= col2, etc)
while IFS=, read -r col1 col2 col3 col4 col5 col6
do 
    if [[ $col1 = *"10"* ]]; then
      echo "Attempt to ping $col1"
      if [[ -n $(ping -c 4 $col1 | grep "100") ]]; then
        echo "Could not ping $col1. Logging..."
        echo "Could not ping $col1" >> $log_location/$log
        echo "Location: $col2" >> $log_location/$log
        echo "Description: $col3" >> $log_location/$log
        echo -e "Description: $col4\n" >> $log_location/$log
        
        else
          echo "$col1 can ping."
          echo "Location: $col2"
          echo "Description: $col3"
          echo "Description: $col4" 
          
      fi
    else
      echo "No static IP address, it's connected through $col1." 
      echo "Location: $col2"
      echo "Description: $col3"
      echo "Description: $col4" 
      
    fi
    echo " "
    
done < $file_name
echo "File located in $log_location/$log"
