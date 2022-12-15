#!/bin/bash
#declare -a ContainerNames=("api_end_points_v11" "payment_allocation_consumer" "payments_gateway" "payments_consumer" "payments_rabbitmq" "delivery_microservice_redis_1" "delivery_microservice_web_1" "rabbitmq")
declare -a ContainerNames=("onpremise_worker_1" "onpremise_cron_1" "onpremise_web_1")
#for container in "${ContainerNames[@]}"; do
#  #echo $container
#  docker top $container 2> error.txt
#  if [ $? != 0 ]; then
#    docker restart $container
#  fi
#done
##echo $?
#exit $?

for container in "${ContainerNames[@]}"; do
  #echo $container
  docker top $container 2> error.txt
  status="$?"
#  echo $status
  if [[ $status != 0 ]]; then
    echo $status
  fi
done
