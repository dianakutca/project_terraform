# #!/bin/bash
# sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2
# sudo yum install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip} -y
# sudo amazon-linux-extras install php8.0 -y
# sudo yum install -y httpd mariadb-server
# sudo wget https://wordpress.org/latest.tar.gz
# sudo tar -xzf latest.tar.gz
# sudo systemctl start httpd
# sudo systemctl enable httpd
# sudo cp -r wordpress/* /var/www/html/
# sudo chown -R apache:apache /var/www/html/
# sudo mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
# sudo sed -i 's/username_here/${var.master_username}/g' /var/www/html/wp-config.php
# sudo sed -i 's/localhost/${aws_rds_cluster.db_instance.endpoint}/g' /var/www/html/wp-config.php
# sudo sed  -i 's/database_name_here/${var.database_name}/g' /var/www/html/wp-config.php
# sudo sed  -i 's/password_here/${var.master_password}/g' /var/www/html/wp-config.php
