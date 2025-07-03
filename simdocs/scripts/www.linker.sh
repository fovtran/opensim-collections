#!/bin/tcsh
#
ln -s ./drupal-7.0 /media/mirror/wwwroot/drupal-7.0
ln -s ./drupal-6.20 /media/mirror/wwwroot/drupal-6.20
ln -s elpaine /media/mirror/wwwroot/elpaine
chown -R www:www ./
mkdir /media/mirror/wwwroot/conf
mv ./Includes/mod_alias.conf /media/mirror/wwwroot/conf/vhost.conf

