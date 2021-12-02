#!/bin/bash

   sudo -i
   apt update
   apt install -y apache2

   echo 'Teste-Apache' > /var/www/html/index.html
