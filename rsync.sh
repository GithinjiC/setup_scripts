#!/bin/bash
# Archive designated files and dirs daily
#DATE=`date +%y%m%d`
#FILE=archive$DATE.tar.gz
CONFIG_FILE=./backup_list
DESTINATION=/copia/dev/data
#CHECKSUM_NUMS=archive/chesumfile
# Check backup config file exists
if [ -f $CONFIG_FILE ]
then
  echo
else
  echo "$CONFIG_FILE does not exist."
  echo "Backup incomplete"
  exit
fi

#TODO Check checksum and commit if changes

FILE_NO=1               # Line 1 of Config file
exec < $CONFIG_FILE     # Redirect STDIN to name of Config file
read FILE_NAME
while [ $? -eq 0 ]
do
  if [ -f $FILE_NAME -o -d $FILE_NAME ]
  then
    # if file exists, add it to the list
    rsync -avzP ubuntu@51.222.240.58:$FILE_NAME $DESTINATION
  else
    echo "$FILE_NAME, does not exist."
    echo "It is listed on line $FILE_NO of the config file"
    echo "Continuing..."
  fi
  FILE_NO=$[$FILE_NO + 1] # inc line/file number by one
  read FILE_NAME  # read next record
done
echo "Starting transfer..."
#rsync -avzP ubuntu@51.222.240.58:$FILE_LIST $DESTINATION
echo "Transfer completed"
echo "Transferred files are in: $DESTINATION"
exit

# postgresql files are owned by postgres
rsync -avzP ubuntu@51.222.240.58:/home/ubuntu/.ssh /copia/dev/home/ubuntu
rsync -avzP ubuntu@51.222.240.58:/etc/nginx/ /copia/dev/etc
rsync -avzP ubuntu@51.222.240.58:/etc/postgresql/ /copia/dev/etc
rsync -avzP ubuntu@51.222.240.58:/data/copia/utilities-confs /copia/dev/data/copia/
rsync -avzP ubuntu@51.222.240.58:/data/copia/erp/qa/qa.conf /copia/dev/data/copia/erp/qa
rsync -avzP ubuntu@51.222.240.58:/data/copia/erp/uat/uat.conf /copia/dev/data/copia/erp/uat
rsync -avzP ubuntu@51.222.240.58:/data/postgresql/12/main/pg_hba.conf /copia/dev/data/postgresql/12/main/

scp -r ubuntu@51.222.240.58:/etc/nginx/sites-available/ /copia/dev/
rsync -avzP ubuntu@51.222.240.58:/etc/nginx/sites-available/ /copia/sites-available

rsync -avzP --stats ubuntu@52.16.241.130:/opt/copia/11-microservices/ordering_microservice/ /data/copia/ordering_microservice/uat_ordering_microservice