sudo yum -y install httpd
sudo service httpd start
sudo chkconfig httpd on
sudo service iptables stop
sudo chkconfig iptables off
sudo rm -rf /var/www/html
sudo ln -fs /vagrant /var/www/html
