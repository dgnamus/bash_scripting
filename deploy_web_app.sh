#!/bin/bash

function firewalld_setup(){
    sudo yum install -y firewalld
    sudo systemctl start firewalld
    sudo systemctl enable firewalld
    sudo systemctl status firewalld

    sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
    sudo firewall-cmd --reload
}

function mariadb_setup(){
    sudo yum install -y mariadb-server
    #sudo vi /etc/my.cnf
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
}

function mariadb_configure() {
    # Execute MySQL commands directly
    mysql -u root <<EOF
    CREATE DATABASE IF NOT EXISTS ecomdb;
    CREATE USER IF NOT EXISTS 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword';
    GRANT ALL PRIVILEGES ON ecomdb.* TO 'ecomuser'@'localhost';
    FLUSH PRIVILEGES;
EOF

    # Create and load the database table
    mysql -u root ecomdb <<EOF
    CREATE TABLE IF NOT EXISTS products (
        id mediumint(8) unsigned NOT NULL auto_increment,
        Name varchar(255) DEFAULT NULL,
        Price varchar(255) DEFAULT NULL,
        ImageUrl varchar(255) DEFAULT NULL,
        PRIMARY KEY (id)
    ) AUTO_INCREMENT=1;

    INSERT INTO products (Name, Price, ImageUrl) VALUES 
    ("Laptop", "100", "c-1.png"),
    ("Drone", "200", "c-2.png"),
    ("VR", "300", "c-3.png"),
    ("Tablet", "50", "c-5.png"),
    ("Watch", "90", "c-6.png"),
    ("Phone Covers", "20", "c-7.png"),
    ("Phone", "80", "c-8.png"),
    ("Laptop", "150", "c-4.png");
EOF
}


function deploy_web() {
    # Remove existing PHP packages to avoid conflicts
    sudo yum remove -y php* httpd

    # Enable the EPEL and Remi repositories
    sudo yum install -y epel-release
    sudo yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm

    # Enable the Remi PHP repository
    sudo yum-config-manager --enable remi-php74

    # Install httpd, PHP, and required modules
    sudo yum install -y httpd php php-mysql
    if [ $? -ne 0 ]; then
        echo "Failed to install httpd and PHP packages."
        return 1
    fi

    # Configure firewall to allow HTTP traffic
    sudo systemctl status firewalld > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
        sudo firewall-cmd --reload
    fi

    # Update httpd configuration
    sudo sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php/g' /etc/httpd/conf/httpd.conf

    # Start and enable httpd service
    sudo systemctl start httpd
    if [ $? -ne 0 ]; then
        echo "Failed to start httpd service."
        return 1
    fi
    sudo systemctl enable httpd

    # Install git and clone the repository
    sudo yum install -y git
    if [ $? -ne 0 ]; then
        echo "Failed to install git."
        return 1
    fi
    sudo git clone https://github.com/kodekloudhub/learning-app-ecommerce.git /var/www/html/
    if [ $? -ne 0 ]; then
        echo "Failed to clone the repository."
        return 1
    fi

    # Update configuration in cloned repository
    sudo sed -i 's/172.20.1.101/localhost/g' /var/www/html/index.php

    # Test the setup
    curl http://localhost
    if [ $? -ne 0 ]; then
        echo "Failed to access http://localhost. Please check the httpd service and firewall settings."
        return 1
    fi
}


firewalld_setup
mariadb_setup
mariadb_configure
deploy_web




