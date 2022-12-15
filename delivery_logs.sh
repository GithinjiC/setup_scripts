#!/bin/bash

delivery_log_file="/home/cos/delivery_app.log"
current_date=`date +%Y-%m-%d`
previous_date=$(date -d "- 1 day" '+%Y-%m-%d')
day_before_previous_date=$(date -d "- 2 day" '+%Y-%m-%d')

echo $delivery_log_file.$day_before_previous_date

if [ 1 ]; then
  echo "removing file"
  rm -f $delivery_log_file
  tail -f /var/log/copia_endpoints_staging/copia_endpoints.log | grep -i -E -A6 "/delivery/v2"  > $delivery_log_file.$current_date
else
  echo "file does not exist"
fi



#nohup delivery_logs.sh &
