#type represents the type of splunk instance to be installed
# search, indexer_peer, deployment_server
type=$1
ds_install=$2
install_path=$3
class=$4
#password=$5
# CLEANUP EXISTING INSTALL
# $install_path/bash_scripts/cleanup.sh

# PERFORM BASE INSTALL
$install_path/bash_scripts/base.sh $ds_install $type $install_path #$password

# DEPLOY APPLICATIONS
for x in `grep $class $install_path/bash_scripts/config.txt`; do
    deploy_path=`echo $x |awk -F\| '{print $2}'`
    app=`echo $x |awk -F\| '{print $3}'`
    echo $path $app
    [ ! -d $deploy_path ] && sudo mkdir -p $deploy_path && sudo chown -R splunk:splunk $deploy_path
    sudo cp -r $install_path/bash_scripts/support/$app $deploy_path
    sudo chown -R splunk:splunk $deploy_path/$app
done

# RESTART SPLUNK
service splunk restart
