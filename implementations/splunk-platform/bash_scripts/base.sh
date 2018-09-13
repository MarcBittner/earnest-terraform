DS_INSTALL=$1
install_path=$3
#password=$4

##MUST BE LOGGED INTO ROOT

##BASE INSTALL
wget -O splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.0.2&product=splunk&filename=splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb&wget=true'
dpkg -i splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb

##FIX PERMISSIONS ON THE SERVER
[ -d /data/splunk/hot ] && chown -R splunk:splunk /data/splunk/hot
[ -d /data/splunk/cold ] && chown -R splunk:splunk /data/splunk/cold

##CONFIGURE init.d
/opt/splunk/bin/splunk enable boot-start -user splunk --accept-license

##UPDATE THP AND ULIMITS
cp $install_path/bash_scripts/support/splunk.initd /etc/init.d/splunk
systemctl daemon-reload


# 20180912 - Commenting the following line out since it will not work but adding 
# a touch to create the key. Someone needs to fix this. Marc.  

#runuser -l splunk -c 'echo $SECRET_KEY > /opt/splunk/etc/auth/splunk.secret'

echo "" > /opt/splunk/etc/auth/splunk.secret

##START SPLUNK AS SPLUNK USER FOR FIRST TIME
runuser -l splunk -c '/opt/splunk/bin/splunk start --accept-license --answer-yes --auto-ports --no-prompt'
[ $DS_INSTALL -eq 1 ] && {
  printf "[deployment-client]\nclientName = $2" > /opt/splunk/etc/system/local/deploymentclient.conf
  runuser -l splunk -c '/opt/splunk/bin/splunk set deploy-poll splunk-deployment.ring.local:8089 -auth admin:changeme'
  #runuser -l splunk -c "/opt/splunk/bin/splunk edit user admin -password $password -role admin -auth admin:changeme"
}

##RESTART SPLUNK
service splunk restart

##CLEANUP
rm splunk-7.0.2-03bbabbd5c0f-linux-2.6-amd64.deb
