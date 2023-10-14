echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

echo 'zone "abimanyu.E14.com" {' > /etc/bind/named.conf.local
echo '    type slave;' >> /etc/bind/named.conf.local
echo '    masters { 192.213.2.2; };' >> /etc/bind/named.conf.local
echo '    file "/var/lib/bind/abimanyu.E14.com";' >> /etc/bind/named.conf.local
echo '};' >> /etc/bind/named.conf.local
echo 'zone "baratayuda.abimanyu.E14.com" {' >> /etc/bind/named.conf.local
echo '    type master;' >> /etc/bind/named.conf.local
echo '    file "/etc/bind/Baratayuda/baratayuda.abimanyu.E14.com";' >> /etc/bind/named.conf.local
echo '};' >> /etc/bind/named.conf.local

echo 'options {' > /etc/bind/named.conf.options
echo '        directory "/var/cache/bind";' >> /etc/bind/named.conf.options
echo '        dnssec-validation auto;' >> /etc/bind/named.conf.options
echo '  allow-query{any;};' >> /etc/bind/named.conf.options
echo '        auth-nxdomain no;    # conform to RFC1035' >> /etc/bind/named.conf.options
echo '        listen-on-v6 { any; };' >> /etc/bind/named.conf.options
echo '};' >> /etc/bind/named.conf.options

mkdir /etc/bind/Baratayuda
cp /etc/bind/db.local /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com

echo ';' BIND data file for local loopback interface > /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo '$TTL    604800' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo '@       IN      SOA     baratayuda.abimanyu.E14.com. root.baratayuda.abimanyu.E14.com. (' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo '                              2023101001         ; Serial' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo '                         604800         ; Refresh' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo '                          86400         ; Retry' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo '                        2419200         ; Expire' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo '                         604800 )       ; Negative Cache TTL' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo ';' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo '@       IN      NS      baratayuda.abimanyu.E14.com.' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo '@       IN      A       192.213.3.4' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo 'www     IN      CNAME   baratayuda.abimanyu.E14.com.' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo 'rjp     IN      A       192.213.3.4' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo 'www.rjp IN      CNAME   rjp.baratayuda.abimanyu.E14.com.' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com

service bind9 restart