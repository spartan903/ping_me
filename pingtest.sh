#!/bin/bash

#Please have the file in the same directory as the script before running!
talk(){
  say -v Daniel -a 54 $1
}

no_ping(){
  echo "Could not ping $col1. Logging..."
  echo "Could not ping $col1" >> $log_location/$log
  echo "Location: $col2" >> $log_location/$log
  echo "Description: $col3" >> $log_location/$log
  echo "Description: $col4" >> $log_location/$log
  echo "Description: $col5" >> $log_location/$log
  echo "Description: $col6" >> $log_location/$log
  echo -e "\n"
}

can_ping(){
  echo "$col1 can ping."
  echo "Location: $col2"
  echo "Description: $col3"
  echo "Description: $col4" 
  echo "Description: $col5"
  echo "Description: $col6"  
}


log_location="$(pwd)"
datestamp=$(date +"%m%d%Y%H%M")
log="$datestamp-test_file.txt"
read -p "What is the name of the csv file?: " file_name

if test -f "$file_name"; then
echo "File Found!"
echo "Writing a log to $log_location "

# IF CSV has more than 6 columns, please add them here (A = col1, B= col2, etc). Please have col1 contain the IP address
while IFS=, read -r col1 col2 col3 col4 col5 col6
do 
   if [[ $col1 =~ [0-9] ]] || [[ $col1 = *".com"* ]] || [[ $col1 = *".org"* ]]; then
    echo "Attempt to ping $col1"
    if [[ -n $(ping -c 4 $col1 | grep "100") ]]; then
      no_ping
    else
      can_ping  
    fi
  else
    echo "No IP address, it's connected through $col1." 
    echo "Location: $col2"
    echo "Description: $col3"
    echo "Description: $col4"
    echo "Description: $col5"  
    echo "Description: $col6" 
      
  fi
  echo " "
    
done < $file_name
echo "File located in $log_location/$log"

else
echo "File not found. Please make sure the csv is in the same directory as the script."
fi
