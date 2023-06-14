#!/bin/bash
sudo  yum install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel -y
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
sudo systemctl start httpd
sudo systemctl enable httpd
sudo cp -r wordpress/* /var/www/html/