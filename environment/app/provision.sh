#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
sudo apt-get upgrade -y


# install git
sudo apt-get install git -y

# install nodejs
sudo apt-get install python-software-properties -y
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y

# install pm2
sudo npm install pm2 -g

sudo apt-get install nginx -y

# remove the old file and add our one
cd /etc/nginx/sites-available
sudo rm -rf default
echo "server{
        listen 80;
        server_name _;
        location / {
          proxy_pass http://3.250.79.34:3000;
          proxy_http_version 1.1;
          proxy_set_header Upgrade \$http_upgrade;
          proxy_set_header Connection 'upgrade';
          proxy_set_header Host \$host;
          proxy_cache_bypass \$http_upgrade;
        }
}" | sudo tee default

# finally, restart the nginx service so the new config takes hold
sudo service nginx restart
sudo systemctl enable nginx
