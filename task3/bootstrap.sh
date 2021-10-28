#!/bin/bash

apt-get update
apt-get install -y apache2
service apache2 start

mv /vagrant/apache2.conf /etc/apache2/apache2.conf

apachectl -k graceful
