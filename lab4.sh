#!/bin/sh

#######
#Adapted from Lab3 solution Uploaded by Nic Sajadi

#Jordan Macpherson 214603518
#######

if [ $# -eq 0 ]
then
  echo You should enter the path name for class files
  echo Use: lab3.sh path
  echo 'Example lab3.sh ~'
  exit 1
fi

path=$1

# find files with read permission in the defined path
class_files=`find $path -type f -name '*.rec' `
#counts the number of found files
count=$(find $path -type f -name '*.rec' | wc -l)
# check if we find at least one file
if [ "X${class_files}" = "X" ]
then
  echo 'There is not readable *.rec file exists in the specified path or its subdirectories!'
  exit 1
fi


readfile.sh ${class_files[0]} | sed -n -e 3,4p -e 6p > ci.txt
readfile.sh ${class_files[1]} | sed -n -e 3,4p -e 6p > ci2.txt

#while read line
#do

  #words+= $line
#done < ci.txt

# main loop
clear
prompt="command: "
printf "$prompt"
while true
do
  read command
  case $command in
    l | list) echo 'Here is the list of found class files:'
              echo $class_files;;
    h | help) echo 'l or list: lists found courses
ci: gives the name of all courses plus number of credits
sl: gives a unique list of all students registered in all courses
sc: gives the total number of unique students registered in all courses
cc: gives the total numbers of found course files.
h or help: prints the current message.
q or quit: exits from the script';;

    #ci ) echo 'these are the courses and these are their credit values'
      #   echo $words ;;
    cc ) echo "There are $count course files";;

    q | quit) echo goodbye
	         break;;
    *) echo 'Unrecognized command!';;
  esac

  printf "$prompt"
done


exit 0
