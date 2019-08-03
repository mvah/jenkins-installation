echo "*********************************** Start jenkins installation *********************************"
#!/bin/sh
# Jenkins installation
sudo apt update
sudo apt install openjdk-8-jdk

# Import the GPG key of the jenkins repository
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

# Add the jenkins repository to the system
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Install jenkins
sudo apt update
sudo apt install jenkins
systemctl status jenkins
sudo ufw allow 8080
sudo ufw status

# if the firewall is inactive the following commands will be important
sudo ufw allow OpenSSH
sudo ufw enable 
sudo ufw status

# Now you can access jenkins web interface by using http://ip_address:8080
# The following command allow to display password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "******** Copy this password and paste it in the field of first jenkins page to continuous ********"
# After this choice a suggested plugins and create admin user
echo "*********************************** End of jenkins installation **********************************"



echo "******************************** Start chartmuseum installation *************************************"
curl -LO https://s3.amazonaws.com/chartmuseum/release/latest/bin/linux/amd64/chartmuseum 
chmod +x ./chartmuseum
mv ./chartmuseum /usr/local/bin

# create a local chart directory in a chart server
mkdir chartstorage
chartmuseum --port=8080 --storage="local" --storage-local-rootdir="./chartstorage"
# After running the command, chartmuseum showing that it is start.

# Now we will add chartmuseum as a repository in the host who have Helm installation
# helm repo add chartmuseum http://116.203.125.88:8080
# helm repo update

# use the four following commands to install Helm on kubernetes master
# 1) curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
# 2) chmod 700 get_helm.sh
# 3) ./get_helm.sh
# 4) helm init

# package the chart in .tgz file (stay in a chart directory)
# helm package .
# use the following command to send chart to chartmuseum server
# curl --data-binary "@app-0.1.0.tgz" http://116.203.125.88:8080/api/charts
echo "******************************** End chartmuseum installation *************************************"



echo "*********************** Start unsecure  docker registry installation *******************************"
echo "*********************** End unsecure  docker registry installation *******************************"




