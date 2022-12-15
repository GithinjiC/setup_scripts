#!/bin/bash

#set -x

DATE=`date +%y-%m-%d`
ARCHIVE=${1-"archive$DATE.tar.gz"}
# provide a default value
CONFIG_FILE=${1-"./backup_list"}
DESTINATION="./archive/$ARCHIVE"

read_from_conf_file(){
  FILE_NO=1
  exec < $CONFIG_FILE
  read FILE
  while [ $? -eq 0 ]; do
    if [ -s $FILE -o -d $FILE ]
    then
      FILE_LIST="$FILE_LIST $FILE"
    else
      echo "$FILE, does not exist."
      echo "It is listed on line $FILE_NO of the config file"
    fi
    FILE_NO=$[$FILE_NO + 1] # inc line number of conf file by one
    read FILE# read next record
  done
#done
#  echo "Starting archive..."
#  tar -czf $DESTINATION $FILE_LIST 2> /dev/null
#  echo "Archive completed"
#  echo "Resulting archive file is: $DESTINATION"
#  exit
rsync
}

read_from_cmd_line(){
  local DESTINATION="$1"
  shift
  for file in "$@"; do
    file_name="$(basename $file)"
    if [ -f $file ]; then
      echo "File"
    elif [ -d $file ];then
      Archive_Destination="$DESTINATION/$file_name$DATE.tar.gz"
      echo "New_Destination: $Archive_Destination"
      tar -czf $Archive_Destination $file 2> /dev/null
#      echo "$file"
    elif [ -s $file ]; then
      echo "Dir/File has zero bytes and won't be archived"
    fi
  done
#  echo $FILE_LIST
#  echo "Destination: $DESTINATION"
}
#read_from_cmd_line $@
read_from_conf_file
while getopts :p:b opt
do
  case $opt in
  b)
      read_from_conf_file
    ;;
  p) echo "Second";;
  *) echo "Unknown option: $opt";;
  esac
done
echo $opt
echo $OPTIND
shift 2
echo $@
echo $#
shift $[ $OPTIND - 1 ]


#CHecksum
$ cat checksum.sh
#!/bin/bash
for f in "$@"; do
        (printf "%s\0" "$f" ; cat "$f") | sha256sum -
done


sha512sum filename > sha512sums.txt

# unzip archive --> tar -xvf <path>

#
#if [ $# -lt 5 ]
#then
#  echo $#
#  echo "Usage: interactive.sh -a -b value -c -d [optional parameters]"
#  exit
#else
#  while getopts :ab:c:d opt
#  do
#    case "$opt" in
#    a)
#      echo "Found the -a option"
#      # path
#      if [ -f $OPTARG ]; then echo "FIle"; else [ -d $OPTARG ];  echo "Dir"; fi
#      echo "Yes sir"
#      ;;
##      if [ $@ > 1]; then echo "yes sir" fi
##      ;;
#    b) echo "Found the -b option, with value $OPTARG"
#      echo "Usage: interactive.sh -a -b value -c -d [optional parameters]"
#      echo "h ---help "
#      echo "p --path"
#      ;;
#    c) echo "Found the -c option, with value $OPTARG";;
#    d) echo "Found the -d option";;
#    *) echo "Unknown option: $opt";;
#    esac
#  done
#fi