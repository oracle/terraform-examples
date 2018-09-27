variable "user-data-webservers" {
  default = <<EOF
#!/bin/bash -x
#
echo '################### webserver userdata begins #####################'
touch ~opc/userdata.`date +%s`.start

# echo '########## yum update all ###############'
# yum update -y

echo '########## basic webserver ##############'
yum install -y httpd
systemctl enable  httpd.service
systemctl start  httpd.service

echo '<html><head></head><body><pre><code>' > /var/www/html/index.html

hostname >> /var/www/html/index.html
echo '' >> /var/www/html/index.html
cat /etc/os-release >> /var/www/html/index.html
echo '<p>' >> /var/www/html/index.html
ip addr show >> /var/www/html/index.html 2>&1
echo '<p>' >> /var/www/html/index.html
ifconfig -a | grep -ie flags -ie netmask
echo '<p>' >> /var/www/html/index.html
echo '</code></pre></body></html>' >> /var/www/html/index.html

firewall-offline-cmd --add-service=http
systemctl enable  firewalld
systemctl restart  firewalld
# systemctl stop firewalld

touch ~opc/userdata.`date +%s`.finish
echo '################### webserver userdata ends #######################'
EOF
}

# curl ifconfig.co >> /var/www/html/index.html
# curl ifconfig.co >> /var/www/html/index.html

