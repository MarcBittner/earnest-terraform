#!/bin/bash

volume_path=$(readlink -f /dev/xvdc)

red=`tput setaf 1`
reset=`tput sgr0`

while [ ! -b $volume_path ]; do
  ((c++)) && ((c==10)) && echo "${red}[-] Could not map after 10 tries. ${reset}" && exit
  echo "[+] Mapping Volume."
  sleep 30;
 done


sudo mkfs -t ext4 $volume_path

sudo mkdir -p /data/splunk/cold
sudo chown ubuntu:ubuntu /data/splunk/cold
sudo chmod 0775 /data/splunk/cold

echo "$volume_path /data/splunk/cold ext4 defaults,nofail,noatime,nodiratime,barrier=0,data=writeback 0 2" | sudo tee -a /etc/fstab > /dev/null
sudo mount $volume_path /data/splunk/cold
