#!/bin/bash

apt-get update
apt-get install -y apache2
service apache2 start

sudo a2enmod cgid

cp /vagrant/apache2.conf /etc/apache2/apache2.conf

apachectl -k graceful
