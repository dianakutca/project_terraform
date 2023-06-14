#!/bin/bash
sudo  yum install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel -y
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
sudo systemctl start httpd
sudo systemctl enable httpd
sudo cp -r wordpress/* /var/www/html/
sudo chown -R apache:apache /var/www/html/
sudo mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

#echo "CREATE DATABASE IF NOT EXISTS wordpress; CREATE USER IF NOT EXISTS 'wordpress'@'localhost' IDENTIFIED BY '${db_password}'; GRANT ALL PRIVILEGES ON *.* TO 'wordpress'@'localhost' WITH GRANT OPTION;" | mysql
