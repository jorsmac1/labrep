#this is a random addition mostly just to change the hashcode
#######
# The purpose of the lab are to learn:
# * implementing loops
X# * reading from standard input
# * checking input parameters
# * checking condition
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
class_files=`find $path -type f -name '*.rec' -perm /444`

# check if we find at least one file
if [ "X${class_files}" = "X" ]
then
  echo 'There is not readable *.rec file exists in the specified path or its subdirectories!'
  exit 1
fi

course_info(){
  for file in $class_files
  do

    read d1 d2 course_name < $file
    credits=`grep "CREDITS" $file | grep -o [0-9]`
    echo $course_name has $credits credits


  done
}
student_list(){
  ans=ans.txt
  for file in $class_files
  do

    grep -o "[0-9]\{6\}" $file >> ans.txt


  done
  sort $ans | uniq

  rm $ans

}


prompt="command: "
printf "$prompt"

while true
do
  read command
  case $command in
    l | list) echo 'Here is the list of found course files:'
              echo $class_files;;
    ci) echo 'Found courses are:'
        course_info;;
    sl) echo 'Here is the unique list of student numbers in all courses:'
        student_list;;
    sc) echo 'There are' `student_list | wc -l` 'registered students in all courses.';;
    cc) echo 'There are' `echo -n $class_files | wc -w` course files.;;
    h | help) echo 'Here are defined commands: '
    echo 'l or list: lists found courses'
    echo 'ci: gives the name of all courses plus number of credits'
    echo 'sl: gives a unique list of all students registered in all courses'
    echo 'sc: gives the total number of unique students registered in all courses'
    echo 'cc: gives the total numbers of found course files.'
    echo 'h or help: prints the current message.'
    echo 'q or quit: exits from the script'
  ;;
    q | quit) echo goodbye
              break;;
    *) echo 'Unrecognized command!';;
  esac

  printf "$prompt"
done


exit 0
