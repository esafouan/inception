#!/bin/sh

sed -i 's#listen = /run/php/php8.2-fpm.sock#listen = 9000#g' /etc/php/8.2/fpm/pool.d/www.conf

sleep 30

#install cli tool

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp


cd /var/www/wordpress

cp wp-config-sample.php wp-config.php

#sed -i 's/old_content/new_content/g' example.txt
sed -i "s/votre_nom_de_bdd/$DATABASE_NAME/g" wp-config.php
sed -i "s/votre_utilisateur_de_bdd/$MYSQL_USER/g" wp-config.php
sed -i "s/votre_mdp_de_bdd/$MYSQL_PASSWORD/g" wp-config.php
sed -i "s/localhost/mariadb/g" wp-config.php


wp core install --url="https://esafouan.42.fr" \
                --title="$WP_TITLE" \
                --admin_name="$WP_ADMIN_USR" \
                --admin_password="$WP_ADMIN_PASS" \
                --admin_email="$WP_ADMIN_EMAIL" \
                --path="/var/www/wordpress" --allow-root

wp user create $WP_USR $WP_EMAIL --role=contributor --user_pass=$WP_PASS --allow-root

exec  /usr/sbin/php-fpm8.2 -F