#!/bin/bash
yum install httpd -y
systemctl start httpd
systemctl stop firewalld
sudo echo "Hello World from $(hostname -f)" > /var/www/html/index.html



