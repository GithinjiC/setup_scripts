#!/bin/bash
declare -a DevServerPaths=("/etc/nginx/sites-available/" "/home/ubuntu/.ssh/" "/etc/systemd/system/")
declare -a DevLocalPaths=("/copia/dev/sites-available" "/copia/dev/.ssh" "/copia/dev/systemd/system")
declare -A dev_array

declare -a ProdServerPaths=("/etc/nginx/sites-available/" "/home/ubuntu/.ssh/" "/etc/systemd/system/" "/etc/logrotate.conf" "/etc/logrotate.d/" "/etc/odoo/" "/etc/odoo.conf" "/etc/memcached.conf" "/etc/monit/conf.d/" "/etc/monit/monitrc")
declare -a ProdLocalPaths=("/copia/prod/sites-available" "/copia/prod/.ssh" "/copia/prod/systemd/system" "/copia/prod" "/copia/prod/logrotate.d" "/copia/prod/odoo" "/copia/prod/odoo.conf" "/copia/prod/memcached.conf" "/copia/prod/monit" "/copia/prod/monit/monitrc")
declare -A prod_array

for i in ${!DevServerPaths[@]}; do
  dev_array[${DevServerPaths[i]}]=${DevLocalPaths[i]}
done
for key in "${!dev_array[@]}";do
  rsync -avzP ubuntu@51.222.240.58:"$key" "${dev_array[$key]}"
done

for i in ${!ProdServerPaths[@]}; do
  prod_array[${ProdServerPaths[i]}]=${ProdLocalPaths[i]}
done
for key in "${!prod_array[@]}";do
  rsync -avzP ubuntu@34.242.206.96:"$key" "${prod_array[$key]}"
done

#for key in "${!dev_array[@]}"; do echo "$key - ${dev_array[$key]}"; done
echo $?
exit $?


#rsync -avzP ubuntu@51.222.240.58:/etc/nginx/sites-available/ /copia/sites-available