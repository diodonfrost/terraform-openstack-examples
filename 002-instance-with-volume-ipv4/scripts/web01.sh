#! /bin/sh -v

sudo -i
sudo apt update
sudo add-apt-repository ppa:ondrej/php
apt install -y apache2 git php php7.2-mcrypt php-mysql libapache2-mod-php
rm -rf /var/www/html
git clone https://github.com/binariocloud/chat.git -l /var/www
touch /var/www/html/assets/chat.txt
chmod 666 /var/www/html/assets/chat.txt
echo  { get_attr: [ web01, first_address ]} web01 >> /etc/hosts
