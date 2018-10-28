#!/bin/sh

# install epel-release
echo "setting up EPEL in yum ... "
yum clean all
rm -rf /var/cache/yum/*0
yum -y install epel-release
yum clean all
yum -y update

# updates and general installs
yum -y update
yum -y install wget ftp gcc libpng-dev autoconf automake make g++ libtool nasm zip zlib-devel libpng-devel.x86_64 libpng12-devel.x86_64 libpng12.x86_64 htop php-gd

# install gcc
yum install -y gcc-c++ make

# install firewall
systemctl restart firewalld

firewall-cmd --zone=public --permanent --add-service=ssh
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https

echo "reloading firewall and starting on reboot ... "
firewall-cmd --reload
systemctl enable firewalld
systemctl status firewalld

# install nginx
yum install epel-release -y
yum install nginx -y
systemctl start nginx
systemctl enable nginx
	
# set php7 variables
PHP7VER="php71"
PHP7REPO="remi-${PHP7VER}"

# intall mariaDB
yum install mariadb-server mariadb -y
systemctl enable mariadb
systemctl start mariadb

# stop NGINX and PHP-FPM
systemctl stop php-fpm
systemctl stop nginx

# remove all PHP packages
yum -y remove '*php*'

# download/install RPM
echo "Installing rpms for PHP"
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm

# toggle remi PHP7 repo
yum-config-manager --enable remi
yum-config-manager --enable ${PHP7REPO}

# install new PHP
yum -y install php php-fpm php-mcrypt php-mbstring php-common php-devel php-bcmath php-mysqlnd php-opcache php-xml php-tidy

# installing PHP PECL libraries
echo "installing PHP PECL libraries ... \n"
yum -y install php-pecl-yaml php-pecl-memcached php-pecl-http php-pecl-zip

cp -f ./config/www.conf /etc/php-fpm.d/
cp -f ./config/josephwatkin.com.conf /etc/nginx/conf.d/
cp -f ./config/nginx.conf /etc/nginx/
cp -f ./config/nginx-php.conf /etc/nginx/
cp -f ./config/nginx-php-laravel.conf /etc/nginx/

# start NGINX and PHP-FPM
echo "starting services and enable on startup ... \n"
systemctl enable php-fpm
systemctl enable nginx
systemctl start php-fpm
systemctl start nginx
systemctl status php-fpm
systemctl status nginx

# PHP version
echo "[$PHP7REPO]: PHP installation complete!"
php --version

# Set the passwords for MySQL users:
read -p "Set root password: " ROOT_PASSWORD
read -p "Production Password :" PR_PASSWORD
read -p "Dev Password :" DEV_PASSWORD
read -p "Read Only Password :" RO_PASSWORD
read -p "QA Password :" QA_PASSWORD

export $ROOT_PASSWORD
export $PR_PASSWORD
export $DEV_PASSWORD
export $QA_PASSWORD
export $RO_PASSWORD

echo "creating My SQL users and DBs:"
source './create-mysql-users.sh'

echo "Enabling mariadb .. \n"
systemctl enable mariadb

# create my user
usermod -aG wheel jwatkin

# install git and curl
yum -y install git curl

# install composer
echo  "installing composer ... "
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer self-update

# intsall npm
curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -

echo  "installing NodeJS and NPM packages ... \n"
yum clean all
yum -y install nodejs

# download yum repo
echo "installing yum repo ... \n"
wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo

# install yarn
echo "installing yarn ... \n"
yum -y install yarn

# install vim
yum -y install vim




echo "Going down for a reboot"
reboot
