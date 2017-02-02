#!/bin/bash
ROOT_UID=0

# Run as root, of course. (this might not be necessary, because we have to run the script somehow with root anyway)
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi

#default pass
pass="welcome1"

#check to see if a parameter passed:
if [ $# -eq 1 ]; then

#Input file, aa param now
csvFile=$1

#store the default field seperator
OLDIFS=$IFS

#set delimeter to ,
IFS=","

#check that csv file exists
[ ! -f $csvFile ] && { echo "$csvFile file not found. Please pass a valid csv file with user names"; exit 99; }

#echo each field
while read username
do
   echo "User name: $username"
   sh ./create_an_acct.sh $username $pass
done < "$csvFile"

#restore the original seperator
IFS=$OLDIFS

#if no param, cry
else
  echo "This script expects a  CSV file as a parameter."
fi
