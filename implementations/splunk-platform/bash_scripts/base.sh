DS_INSTALL=$1
install_path=$3
password=$4
SECRET_KEY=$5
url=$6

##MUST BE LOGGED INTO ROOT

##BASE INSTALL
wget -O splunk.deb "$url"
dpkg -i splunk.deb

##FIX PERMISSIONS ON THE SERVER
[ -d /data/splunk/hot ] && chown -R splunk:splunk /data/splunk/hot
[ -d /data/splunk/cold ] && chown -R splunk:splunk /data/splunk/cold

##CONFIGURE init.d
##Generate initial password for SPLUNK user
/opt/splunk/bin/splunk enable boot-start -user splunk --accept-license --answer-yes --auto-ports --no-prompt --seed-passwd $password

##UPDATE THP AND ULIMITS
cp $install_path/bash_scripts/support/splunk.initd /etc/init.d/splunk
systemctl daemon-reload

runuser -l splunk -c "echo $SECRET_KEY > /opt/splunk/etc/auth/splunk.secret"

##START SPLUNK AS SPLUNK USER FOR FIRST TIME
runuser -l splunk -c "/opt/splunk/bin/splunk start --accept-license --answer-yes --auto-ports --no-prompt"
[ $DS_INSTALL -eq 1 ] && {
  printf "[deployment-client]\nclientName = $2" > /opt/splunk/etc/system/local/deploymentclient.conf
  runuser -l splunk -c "/opt/splunk/bin/splunk set deploy-poll splunk-deployment.ring.local:8089 -auth admin:${password}"
}

##RESTART SPLUNK
service splunk restart

##CLEANUP
rm splunk.deb
