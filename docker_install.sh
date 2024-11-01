#!/bin/bash

set -x

apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

apt-cache policy docker-ce
if [ $? -eq 0 ]; then
  apt-install docker-ce
  usermod -aG docker {USER}
  echo "Done."
else
  echo "Installation not from docker repository"
exit