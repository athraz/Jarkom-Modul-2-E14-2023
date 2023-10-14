echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nginx apache2 php php-fpm
service php7.2-fpm start
unlink /etc/nginx/sites-enabled/default

mkdir /var/www/arjuna.E14.com
touch /var/www/arjuna.E14.com/index.php
echo '<?php
$hostname = gethostname();
$date = date("Y-m-d H:i:s");
$php_version = phpversion();
$username = get_current_user();

echo "Hello World!<br>";
echo "Saya adalah: $username<br>";
echo "Saat ini berada di: $hostname<br>";
echo "Versi PHP yang saya gunakan: $php_version<br>";
echo "Tanggal saat ini: $date<br>";
?>' > /var/www/arjuna.E14.com/index.php

touch /etc/nginx/sites-available/arjuna.E14.com
echo 'server {
    listen 8002;
    root /var/www/arjuna.E14.com;
    index index.php index.html index.htm;
    server_name _;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    # pass PHP scripts to FastCGI server
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }

    error_log /var/log/nginx/arjuna.E14.com_error.log;
    access_log /var/log/nginx/arjuna.E14.com_access.log;
}' > /etc/nginx/sites-available/arjuna.E14.com

ln -s /etc/nginx/sites-available/arjuna.E14.com /etc/nginx/sites-enabled
service nginx start

apt update
apt install unzip
wget -O abimanyu.yyy.com.zip "https://drive.google.com/uc?export=download&id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc"
unzip abimanyu.yyy.com.zip
mv abimanyu.yyy.com abimanyu.E14
mv abimanyu.E14 var/www

echo '<VirtualHost *:80>' > /etc/apache2/sites-available/000-default.conf
echo '    ServerAdmin webmaster@localhost' >> /etc/apache2/sites-available/000-default.conf
echo '    DocumentRoot /var/www/abimanyu.E14' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerName abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerAlias www.abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    <Directory /var/www/abimanyu.E14/index.php/home>' >> /etc/apache2/sites-available/000-default.conf
echo '            Options +Indexes' >> /etc/apache2/sites-available/000-default.conf
echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf
echo '    Alias "/home" "/var/www/abimanyu.E14/index.php/home"' >> /etc/apache2/sites-available/000-default.conf
echo '    ErrorLog ${APACHE_LOG_DIR}/error.log' >> /etc/apache2/sites-available/000-default.conf
echo '    CustomLog ${APACHE_LOG_DIR}/access.log combined' >> /etc/apache2/sites-available/000-default.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf

a2enmod rewrite

echo '<VirtualHost *:80>' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerAdmin webmaster@localhost' >> /etc/apache2/sites-available/000-default.conf
echo '    DocumentRoot /var/www/parikesit.abimanyu.E14' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerName parikesit.abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerAlias www.parikesit.abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    <Directory /var/www/parikesit.abimanyu.E14>' >> /etc/apache2/sites-available/000-default.conf
echo '        RewriteEngine On' >> /etc/apache2/sites-available/000-default.conf
echo '        RewriteCond %{REQUEST_URI} \.(jpg|png)$ [NC]' >> /etc/apache2/sites-available/000-default.conf
echo '        RewriteCond %{REQUEST_URI} abimanyu [NC]' >> /etc/apache2/sites-available/000-default.conf
echo '        RewriteCond %{REQUEST_URI} !^/public/images/abimanyu\.png [NC]' >> /etc/apache2/sites-available/000-default.conf
echo '        RewriteRule ^(.*)$ http://www.parikesit.abimanyu.E14.com/public/images/abimanyu.png' >> /etc/apache2/sites-available/000-default.conf
echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf
echo '    <Directory /var/www/parikesit.abimanyu.E14/public>' >> /etc/apache2/sites-available/000-default.conf
echo '        Options +Indexes' >> /etc/apache2/sites-available/000-default.conf
echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf
echo '    Alias "/js" "/var/www/parikesit.abimanyu.E14/public/js"' >> /etc/apache2/sites-available/000-default.conf
echo '    <Directory /var/www/parikesit.abimanyu.E14/secret>' >> /etc/apache2/sites-available/000-default.conf
echo '        Deny from all' >> /etc/apache2/sites-available/000-default.conf
echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf
echo '    ErrorDocument 403 /error/403.html' >> /etc/apache2/sites-available/000-default.conf
echo '    ErrorDocument 404 /error/404.html' >> /etc/apache2/sites-available/000-default.conf
echo '    ErrorLog ${APACHE_LOG_DIR}/error.log' >> /etc/apache2/sites-available/000-default.conf
echo '    CustomLog ${APACHE_LOG_DIR}/access.log combined' >> /etc/apache2/sites-available/000-default.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf

wget -O parikesit.abimanyu.yyy.com.zip "https://drive.google.com/uc?export=download&id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS"
unzip parikesit.abimanyu.yyy.com.zip
mv parikesit.abimanyu.yyy.com parikesit.abimanyu.E14
mv parikesit.abimanyu.E14 var/www

mkdir var/www/parikesit.abimanyu.E14/public/css
mkdir var/www/parikesit.abimanyu.E14/public/images
mkdir var/www/parikesit.abimanyu.E14/public/js
mkdir var/www/parikesit.abimanyu.E14/secret

echo '<!DOCTYPE html>' > var/www/parikesit.abimanyu.E14/secret/index.html
echo '<html>' >> var/www/parikesit.abimanyu.E14/secret/index.html
echo '<head>' >> var/www/parikesit.abimanyu.E14/secret/index.html
echo '    <title>Hello, World!</title>' >> var/www/parikesit.abimanyu.E14/secret/index.html
echo '</head>' >> var/www/parikesit.abimanyu.E14/secret/index.html
echo '<body>' >> var/www/parikesit.abimanyu.E14/secret/index.html
echo '    <h1>Hello, World!</h1>' >> var/www/parikesit.abimanyu.E14/secret/index.html
echo '    <p>This is a basic HTML page that says "Hello, World!"</p>' >> var/www/parikesit.abimanyu.E14/secret/index.html
echo '</body>' >> var/www/parikesit.abimanyu.E14/secret/index.html
echo '</html>' >> var/www/parikesit.abimanyu.E14/secret/index.html

wget -O rjp.baratayuda.abimanyu.yyy.com.zip "https://drive.google.com/uc?export=download&id=1pPSP7yIR05JhSFG67RVzgkb-VcW9vQO6"
unzip rjp.baratayuda.abimanyu.yyy.com.zip
mv rjp.baratayuda.abimanyu.yyy.com rjp.baratayuda.abimanyu.E14
mv rjp.baratayuda.abimanyu.E14 var/www

htpasswd -bc /etc/password Wayang baratayudaE14

echo '<VirtualHost *:14000>' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerAdmin webmaster@localhost' >> /etc/apache2/sites-available/000-default.conf
echo '    DocumentRoot /var/www/rjp.baratayuda.abimanyu.E14' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerName rjp.baratayuda.abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerAlias www.rjp.baratayuda.abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    <Directory /var/www/rjp.baratayuda.abimanyu.E14>' >> /etc/apache2/sites-available/000-default.conf
echo '        AuthType Basic' >> /etc/apache2/sites-available/000-default.conf
echo '        AuthName "Restricted Files"' >> /etc/apache2/sites-available/000-default.conf
echo '        AuthUserFile "/etc/password"' >> /etc/apache2/sites-available/000-default.conf
echo '        Require user Wayang' >> /etc/apache2/sites-available/000-default.conf
echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf
echo '    ErrorLog ${APACHE_LOG_DIR}/error-14000.log' >> /etc/apache2/sites-available/000-default.conf
echo '    CustomLog ${APACHE_LOG_DIR}/access-14000.log combined' >> /etc/apache2/sites-available/000-default.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf

echo '<VirtualHost *:14400>' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerAdmin webmaster@localhost' >> /etc/apache2/sites-available/000-default.conf
echo '    DocumentRoot /var/www/rjp.baratayuda.abimanyu.E14' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerName rjp.baratayuda.abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerAlias www.rjp.baratayuda.abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    <Directory /var/www/rjp.baratayuda.abimanyu.E14>' >> /etc/apache2/sites-available/000-default.conf
echo '        AuthType Basic' >> /etc/apache2/sites-available/000-default.conf
echo '        AuthName "Restricted Files"' >> /etc/apache2/sites-available/000-default.conf
echo '        AuthUserFile "/etc/password"' >> /etc/apache2/sites-available/000-default.conf
echo '        Require user Wayang' >> /etc/apache2/sites-available/000-default.conf
echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf
echo '    ErrorLog ${APACHE_LOG_DIR}/error-14400.log' >> /etc/apache2/sites-available/000-default.conf
echo '    CustomLog ${APACHE_LOG_DIR}/access-14400.log combined' >> /etc/apache2/sites-available/000-default.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf

echo '# If you just change the port or add more ports here, you will likely also' > /etc/apache2/ports.conf
echo '# have to change the VirtualHost statement in' >> /etc/apache2/ports.conf
echo '# /etc/apache2/sites-enabled/000-default.conf' >> /etc/apache2/ports.conf
echo 'Listen 80' >> /etc/apache2/ports.conf
echo 'Listen 14000' >> /etc/apache2/ports.conf
echo 'Listen 14400' >> /etc/apache2/ports.conf
echo '<IfModule ssl_module>' >> /etc/apache2/ports.conf
echo '        Listen 443' >> /etc/apache2/ports.conf
echo '</IfModule>' >> /etc/apache2/ports.conf
echo '<IfModule mod_gnutls.c>' >> /etc/apache2/ports.conf
echo '        Listen 443' >> /etc/apache2/ports.conf
echo '</IfModule>' >> /etc/apache2/ports.conf
echo '# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' >> /etc/apache2/ports.conf

echo '<VirtualHost *:80>' >> /etc/apache2/sites-available/000-default.conf
echo '   ServerName 192.213.3.4' >> /etc/apache2/sites-available/000-default.conf
echo '   Redirect 301 / http://www.abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf

service apache2 start