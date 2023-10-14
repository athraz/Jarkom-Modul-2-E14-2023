echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nginx php php-fpm
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
    listen 8003;
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