#!/bin/bash

# apache
sudo yum -y install httpd
sudo service httpd start
sudo chkconfig httpd on

# iptables off
sudo service iptables stop
sudo chkconfig iptables off

sudo yum -y update

sudo rm -rf /var/www/html
sudo ln -fs /vagrant /var/www/html

# repository
sudo yum -y install http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
sudo sed -i -e "s/enabled = 1/enabled = 0/g" /etc/yum.repos.d/rpmforge.repo
sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo sed -i -e "s/enabled = 1/enabled = 0/g" /etc/yum.repos.d/epel.repo
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo sed -i -e "s/enabled = 1/enabled = 0/g" /etc/yum.repos.d/remi.repo

sudo yum -y update --enablerepo=rpmforge,epel,remi,remi-php55

# php
sudo yum -y install --enablerepo=remi,remi-php55 php php-opcache php-devel php-mbstring php-mcrypt php-mysql php-phpunit-PHPUnit php-pecl-xdebug php-cli php-common

# phpmyadmin
sudo yum -y install --enablerepo=remi gd-last
sudo yum -y install --enablerepo=remi-php55 php-gd
sudo yum -y install --enablerepo=remi ImageMagick-last
sudo yum -y install --enablerepo=remi-php55 phpMyAdmin

# mysql
sudo yum -y install mysql mysql-devel mysql-server mysql-utilities --enablerepo=remi
sudo service mysqld start
sudo chkconfig mysqld on

# composer
curl -s https://getcomposer.org/installer | php
sudo -s mv composer.phar /usr/local/bin/composer

# intl
# sudo yum -y install icu libicu-devel
# sudo pecl install intl

