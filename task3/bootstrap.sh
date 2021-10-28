#!/bin/bash

apt-get update
apt-get install -y apache2

service apache2 start

sudo a2enmod cgid

cp /vagrant/apache2.conf /etc/apache2/apache2.conf

sudo chmod +x /vagrant/dynamic/server.py

service apache2 stop
service apache2 start
