#!/bin/bash

volume_path=$(readlink -f /dev/xvds)

red=`tput setaf 1`
reset=`tput sgr0`

while [ ! -b $volume_path ]; do
  ((c++)) && ((c==10)) && echo "${red}[-] Could not map after 10 tries. ${reset}" && exit
  echo "[+] Mapping Volume."
  sleep 30;
 done

sudo mkfs -t ext4 $volume_path

# sudo file -s $volume_path | grep -q ext4
# if [[ 1 == $? && -b $volume_path ]]; then
#  sudo mkfs -t ext4 $volume_path
#fi

sudo mkdir -p /opt/splunk
sudo chown ubuntu:ubuntu /opt/splunk
sudo chmod 0775 /opt/splunk

echo "$volume_path /opt/splunk ext4 defaults,nofail,noatime,nodiratime,barrier=0,data=writeback 0 2" | sudo tee -a /etc/fstab > /dev/null
sudo mount $volume_path /opt/splunk
