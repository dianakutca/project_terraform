#!/bin/bash
sudo  sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 
sudo yum install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip}
sudo amazon-linux-extras install php8.0 -y
sudo yum install -y httpd mariadb-server
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
sudo systemctl start httpd
sudo systemctl enable httpd
sudo cp -r wordpress/* /var/www/html/
sudo chown -R apache:apache /var/www/html/
sudo mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo sed -i 's/username_here/admin/g' /var/www/html/wp-config.php
sudo sed -i 's/localhost/${aws_rds_cluster.diana.endpoint}/g' /var/www/html/wp-config.php
sudo sed  -i 's/database_name_here/my_database/g' /var/www/html/wp-config.php
sudo sed -i 's/database_name_here/my_database/g' /var/www/html/wp-config.php
sudo sed  -i 's/password_here/barbut8chars/g' /var/www/html/wp-config.php
#echo "CREATE DATABASE IF NOT EXISTS wordpress; CREATE USER IF NOT EXISTS 'wordpress'@'localhost' IDENTIFIED BY '${db_password}'; GRANT ALL PRIVILEGES ON *.* TO 'wordpress'@'localhost' WITH GRANT OPTION;" | mysql
