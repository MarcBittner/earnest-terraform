for x in `ps -ef |grep splunk |awk '{print $2}'`; do
    kill -9 $x
done

rm -rf /opt/splunk/*
rm /etc/init.d/splunk
