echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nginx php php-fpm
service php7.2-fpm start
unlink /etc/nginx/sites-enabled/default
touch /etc/nginx/sites-available/lb-arjuna.E14.com
echo '# Default menggunakan Round Robin
upstream myweb {
    server 192.213.3.4:8002;
    server 192.213.3.5:8001;
    server 192.213.3.6:8003;
}
server {
    listen 80;
    server_name arjuna.E14.com;

    location / {
        proxy_pass http://myweb;
    }
}' > /etc/nginx/sites-available/lb-arjuna.E14.com
ln -s /etc/nginx/sites-available/lb-arjuna.E14.com /etc/nginx/sites-enabled
service nginx start