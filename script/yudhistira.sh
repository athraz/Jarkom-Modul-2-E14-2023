echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install bind9 -y
mkdir /etc/bind/jarkom

echo '//' > /etc/bind/named.conf.local
echo '' >> /etc/bind/named.conf.local
echo '// Consider adding the 1918 zones here, if they are not used in your' >> /etc/bind/named.conf.local
echo '// organization' >> /etc/bind/named.conf.local
echo '//include "/etc/bind/zones.rfc1918";' >> /etc/bind/named.conf.local
echo '' >> /etc/bind/named.conf.local
echo 'zone "arjuna.E14.com" {' > /etc/bind/named.conf.local
echo '        type master;' >> /etc/bind/named.conf.local
echo '        file "/etc/bind/jarkom/arjuna.E14.com";' >> /etc/bind/named.conf.local
echo '};' >> /etc/bind/named.conf.local
echo '' >> /etc/bind/named.conf.local
echo 'zone "abimanyu.E14.com" {' >> /etc/bind/named.conf.local
echo '        type master;' >> /etc/bind/named.conf.local
echo '        file "/etc/bind/jarkom/abimanyu.E14.com";' >> /etc/bind/named.conf.local
echo '        notify yes;' >> /etc/bind/named.conf.local
echo '        also-notify { 192.213.3.2; };' >> /etc/bind/named.conf.local
echo '        allow-transfer { 192.213.3.2; };' >> /etc/bind/named.conf.local
echo '};' >> /etc/bind/named.conf.local
echo '' >> /etc/bind/named.conf.local >> /etc/bind/named.conf.local
echo 'zone "2.213.192.in-addr.arpa" {' >> /etc/bind/named.conf.local
echo '    type master;' >> /etc/bind/named.conf.local
echo '    file "/etc/bind/jarkom/2.213.192.in-addr.arpa";' >> /etc/bind/named.conf.local
echo '};' >> /etc/bind/named.conf.local

echo ';' BIND data file for local loopback interface > /etc/bind/jarkom/arjuna.E14.com
echo ';' BIND data file for local loopback interface >> /etc/bind/jarkom/arjuna.E14.com
echo '$TTL    604800' >> /etc/bind/jarkom/arjuna.E14.com
echo '@       IN      SOA     arjuna.E14.com. root.arjuna.E14.com. (' >> /etc/bind/jarkom/arjuna.E14.com
echo '                    2023101001      ; Serial' >> /etc/bind/jarkom/arjuna.E14.com
echo '                     604800         ; Refresh' >> /etc/bind/jarkom/arjuna.E14.com
echo '                      86400         ; Retry' >> /etc/bind/jarkom/arjuna.E14.com
echo '                    2419200         ; Expire' >> /etc/bind/jarkom/arjuna.E14.com
echo '                     604800 )       ; Negative Cache TTL' >> /etc/bind/jarkom/arjuna.E14.com
echo ';' BIND data file for local loopback interface >> /etc/bind/jarkom/arjuna.E14.com
echo '@       IN      NS      arjuna.E14.com.' >> /etc/bind/jarkom/arjuna.E14.com
echo '@       IN      A       192.213.3.3' >> /etc/bind/jarkom/arjuna.E14.com
echo 'www     IN      CNAME   arjuna.E14.com.' >> /etc/bind/jarkom/arjuna.E14.com

echo ';' BIND data file for local loopback interface > /etc/bind/jarkom/abimanyu.E14.com
echo '$TTL    604800' >> /etc/bind/jarkom/abimanyu.E14.com
echo '@       IN      SOA     abimanyu.E14.com. root.abimanyu.E14.com. (' >> /etc/bind/jarkom/abimanyu.E14.com
echo '                              2023101001         ; Serial' >> /etc/bind/jarkom/abimanyu.E14.com
echo '                         604800         ; Refresh' >> /etc/bind/jarkom/abimanyu.E14.com
echo '                          86400         ; Retry' >> /etc/bind/jarkom/abimanyu.E14.com
echo '                        2419200         ; Expire' >> /etc/bind/jarkom/abimanyu.E14.com
echo '                         604800 )       ; Negative Cache TTL' >> /etc/bind/jarkom/abimanyu.E14.com
echo ';' >> /etc/bind/jarkom/abimanyu.E14.com
echo '@       IN      NS      abimanyu.E14.com.' >> /etc/bind/jarkom/abimanyu.E14.com
echo '@       IN      A       192.213.3.4' >> /etc/bind/jarkom/abimanyu.E14.com
echo 'www     IN      CNAME   abimanyu.E14.com.' >> /etc/bind/jarkom/abimanyu.E14.com
echo 'nsl     IN      A       192.213.3.2' >> /etc/bind/jarkom/abimanyu.E14.com
echo 'baratayuda        IN      NS      nsl' >> /etc/bind/jarkom/abimanyu.E14.com
echo 'parikesit       IN      A       192.213.3.4' >> /etc/bind/jarkom/abimanyu.E14.com
echo 'www.parikesit       IN      CNAME       abimanyu.E14.com.' >> /etc/bind/jarkom/abimanyu.E14.com

echo ';' BIND data file for local loopback interface > /etc/bind/jarkom/2.213.192.in-addr.arpa
echo ';' BIND data file for local loopback interface >> /etc/bind/jarkom/2.213.192.in-addr.arpa
echo '$TTL    604800' >> /etc/bind/jarkom/2.213.192.in-addr.arpa
echo '@       IN      SOA     abimanyu.E14.com. root.abimanyu.E14.com. (' >> /etc/bind/jarkom/2.213.192.in-addr.arpa
echo '                    2023101001      ; Serial' >> /etc/bind/jarkom/2.213.192.in-addr.arpa
echo '                     604800         ; Refresh' >> /etc/bind/jarkom/2.213.192.in-addr.arpa
echo '                      86400         ; Retry' >> /etc/bind/jarkom/2.213.192.in-addr.arpa
echo '                    2419200         ; Expire' >> /etc/bind/jarkom/2.213.192.in-addr.arpa
echo '                     604800 )       ; Negative Cache TTL' >> /etc/bind/jarkom/2.213.192.in-addr.arpa
echo '' >> /etc/bind/jarkom/2.213.192.in-addr.arpa
echo '2.213.192.in-addr.arpa.     IN      NS      abimanyu.E14.com.' >> /etc/bind/jarkom/2.213.192.in-addr.arpa
echo '2                       IN      PTR     abimanyu.E14.com.' >> /etc/bind/jarkom/2.213.192.in-addr.arpa

echo 'options {' > /etc/bind/named.conf.options
echo '        directory "/var/cache/bind";' >> /etc/bind/named.conf.options
echo '        dnssec-validation auto;' >> /etc/bind/named.conf.options
echo '  allow-query{any;};' >> /etc/bind/named.conf.options
echo '        auth-nxdomain no;    # conform to RFC1035' >> /etc/bind/named.conf.options
echo '        listen-on-v6 { any; };' >> /etc/bind/named.conf.options
echo '};' >> /etc/bind/named.conf.options

service bind9 restart