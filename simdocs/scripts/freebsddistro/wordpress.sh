curl -o WP.tar.gz http://es.wordpress.org/wordpress-3.3.2-es_ES.tar.gz
tar xvfz WP.tar.gz
curl -o pdo-sqlite.zip http://downloads.wordpress.org/plugin/pdo-for-wordpress.2.7.0.zip
unzip pdo-sqlite.zip
cd pdo-for-wordpress 
cp -R * ../wordpress/wp-content
cd ../wordpress
mkdir database

chmod 777 database
chown -R www:www /media/mirror/wwwroot

# convert mysqle databases to sqlite
# git clone	git://gist.github.com/943776.gi
