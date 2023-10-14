# Jarkom-Modul-2-E14-2023

| Nama                      | NRP           |Username      |
|---------------------------|---------------|--------------|
|Muhammad Razan Athallah    |5025211008     |athraz        |
|Moh rosy haqqy aminy       |5025211012     |hqlco         |

## Soal 1
> Yudhistira akan digunakan sebagai DNS Master, Werkudara sebagai DNS Slave, Arjuna merupakan Load Balancer yang terdiri dari beberapa Web Server yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Buatlah topologi dengan pembagian [sebagai berikut](https://docs.google.com/spreadsheets/d/1OqwQblR_mXurPI4gEGqUe7v0LSr1yJViGVEzpMEm2e8/edit?usp=sharing). Folder topologi dapat diakses pada [drive berikut](https://drive.google.com/drive/folders/1Ij9J1HdIW4yyPEoDqU1kAwTn_iIxg3gk?usp=sharing)

Berikut topologi yang digunakan:
![Screenshot 2023-10-14 212736](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/6ed48f50-55c6-440b-9cbb-6b334f55a7c9)

$~$

## Soal 2
> Buatlah website utama pada node arjuna dengan akses ke arjuna.yyy.com dengan alias www.arjuna.yyy.com dengan yyy merupakan kode kelompok.

$~$

## Soal 3
> Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke abimanyu.yyy.com dan alias www.abimanyu.yyy.com.

$~$

## Soal 4
> Kemudian, karena terdapat beberapa web yang harus di-deploy, buatlah subdomain parikesit.abimanyu.yyy.com yang diatur DNS-nya di Yudhistira dan mengarah ke Abimanyu.

$~$

## Soal 5
> Buat juga reverse domain untuk domain utama. (Abimanyu saja yang direverse)

$~$

## Soal 6
> Agar dapat tetap dihubungi ketika DNS Server Yudhistira bermasalah, buat juga Werkudara sebagai DNS Slave untuk domain utama.

$~$

## Soal 7
> Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu baratayuda.abimanyu.yyy.com dengan alias www.baratayuda.abimanyu.yyy.com yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.

Pada node Yudhistira, pada file /etc/bind/jarkom/abimanyu.E14.com ditambahkan nameserver baru `ns1` . 
```sh
echo 'ns1     IN      A       192.213.3.2' >> /etc/bind/jarkom/abimanyu.E14.com
echo 'baratayuda        IN      NS      ns1' >> /etc/bind/jarkom/abimanyu.E14.com
```
Selain itu, pada file /etc/bind/named.conf.options ditambahkan potongan kode `allow-query{any;};`.
```sh
echo 'options {' > /etc/bind/named.conf.options
echo '        directory "/var/cache/bind";' >> /etc/bind/named.conf.options
echo '        dnssec-validation auto;' >> /etc/bind/named.conf.options
echo '        allow-query{any;};' >> /etc/bind/named.conf.options
echo '        auth-nxdomain no;    # conform to RFC1035' >> /etc/bind/named.conf.options
echo '        listen-on-v6 { any; };' >> /etc/bind/named.conf.options
echo '};' >> /etc/bind/named.conf.options
```

Pada Werkudara, pada file /etc/bind/named.conf.options ditambahkan potongan `allow-query{any;};`.
```sh
echo 'options {' > /etc/bind/named.conf.options
echo '        directory "/var/cache/bind";' >> /etc/bind/named.conf.options
echo '        dnssec-validation auto;' >> /etc/bind/named.conf.options
echo '        allow-query{any;};' >> /etc/bind/named.conf.options
echo '        auth-nxdomain no;    # conform to RFC1035' >> /etc/bind/named.conf.options
echo '        listen-on-v6 { any; };' >> /etc/bind/named.conf.options
echo '};' >> /etc/bind/named.conf.options
```
Kemudian, dibuat direktori baru /etc/bind/Baratayuda dan file /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com diisi dengan konfigurasi nameserver baratayuda.
```sh
mkdir /etc/bind/Baratayuda
cp /etc/bind/db.local /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
```
```sh
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
```
Terakhir, masukkan zone baru `baratayuda.abimanyu.E14.com` pada file /etc/bind/named.conf.local dengan type `master`.
```sh
echo 'zone "baratayuda.abimanyu.E14.com" {' >> /etc/bind/named.conf.local
echo '    type master;' >> /etc/bind/named.conf.local
echo '    file "/etc/bind/Baratayuda/baratayuda.abimanyu.E14.com";' >> /etc/bind/named.conf.local
echo '};' >> /etc/bind/named.conf.local
```

Berikut hasil delegasi subdomain baratayuda:
![Screenshot 2023-10-14 215408](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/a1eefc97-918e-4b94-a1db-6eaa1eef451a)
![Screenshot 2023-10-14 215427](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/dd8eccc9-0a94-4505-a2d0-aa7bf9606a19)

$~$

## Soal 8
> Untuk informasi yang lebih spesifik mengenai Ranjapan Baratayuda, buatlah subdomain melalui Werkudara dengan akses rjp.baratayuda.abimanyu.yyy.com dengan alias www.rjp.baratayuda.abimanyu.yyy.com yang mengarah ke Abimanyu.

Untuk membuat subdomain rjp.baratayuda.abimanyu.yyy.com, ditambahkan A dan CNAME pada file /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com.
```sh
echo 'rjp     IN      A       192.213.3.4' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
echo 'www.rjp IN      CNAME   rjp.baratayuda.abimanyu.E14.com.' >> /etc/bind/Baratayuda/baratayuda.abimanyu.E14.com
```

Berikut hasil pembuatan subdomain rjp.baratayuda:
![Screenshot 2023-10-14 220114](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/6976698c-8f72-4209-b38d-8e6c72635bd3)
![Screenshot 2023-10-14 220136](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/e5f794eb-36c9-4640-b96c-448f89c85a87)

$~$

## Soal 9
> Arjuna merupakan suatu Load Balancer Nginx dengan tiga worker (yang juga menggunakan nginx sebagai webserver) yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Lakukan deployment pada masing-masing worker.

$~$

## Soal 10
> Kemudian gunakan algoritma Round Robin untuk Load Balancer pada Arjuna. Gunakan server_name pada soal nomor 1. Untuk melakukan pengecekan akses alamat web tersebut kemudian pastikan worker yang digunakan untuk menangani permintaan akan berganti ganti secara acak. Untuk webserver di masing-masing worker wajib berjalan di port 8001-8003. Contoh: Prabakusuma 8001, Abimanyu 8002, Wisanggeni 8003

$~$

## Soal 11
> Selain menggunakan Nginx, lakukan konfigurasi Apache Web Server pada worker Abimanyu dengan web server www.abimanyu.yyy.com. Pertama dibutuhkan web server dengan DocumentRoot pada /var/www/abimanyu.yyy

Pertama-tama download file zip untuk abimanyu dari drive yang disediakan. Kemudian dilakukan unzip, rename dan move ke direktori var/www.
```sh
wget -O abimanyu.yyy.com.zip "https://drive.google.com/uc?export=download&id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc"
unzip abimanyu.yyy.com.zip
mv abimanyu.yyy.com abimanyu.E14
mv abimanyu.E14 var/www
```
Selanjutnya, pada file konfigurasi /etc/apache2/sites-available/000-default.conf, ditambahkan potongan kode berikut: 
```sh
echo '<VirtualHost *:80>' > /etc/apache2/sites-available/000-default.conf
echo '    ServerAdmin webmaster@localhost' >> /etc/apache2/sites-available/000-default.conf
echo '    DocumentRoot /var/www/abimanyu.E14' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerName abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerAlias www.abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    ErrorLog ${APACHE_LOG_DIR}/error.log' >> /etc/apache2/sites-available/000-default.conf
echo '    CustomLog ${APACHE_LOG_DIR}/access.log combined' >> /etc/apache2/sites-available/000-default.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf
```

Berikut hasil dari web server abimanyu pada client:
![Screenshot 2023-10-14 221020](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/4057c316-14e8-44d3-add1-576c0d1683fe)
![Screenshot (355)](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/d42a5f6c-827f-4f52-bf5d-5e315ec573fb)

$~$

## Soal 12
> Setelah itu ubahlah agar url www.abimanyu.yyy.com/index.php/home menjadi www.abimanyu.yyy.com/home.

Pada file /etc/apache2/sites-available/000-default.conf, ditambahkan Directory listing dan alias pada VirtualHost abimanyu sebagai berikut:
```sh
echo '    <Directory /var/www/abimanyu.E14/index.php/home>' >> /etc/apache2/sites-available/000-default.conf
echo '            Options +Indexes' >> /etc/apache2/sites-available/000-default.conf
echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf
echo '    Alias "/home" "/var/www/abimanyu.E14/index.php/home"' >> /etc/apache2/sites-available/000-default.conf
```

Berikut hasil sebelum dan sesudah ditambahkan potongan kode diatas:
![Screenshot 2023-10-14 221509](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/e30461a5-6b44-4e4f-89a4-75ca8a27c223)
![Screenshot 2023-10-14 221645](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/8d4c840b-cc21-4942-bda5-3215f4077435)
![Screenshot (356)](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/3d965c59-9907-4bef-93b3-6219db981927)

$~$

## Soal 13
> Selain itu, pada subdomain www.parikesit.abimanyu.yyy.com, DocumentRoot disimpan pada /var/www/parikesit.abimanyu.yyy

Pertama-tama download file zip untuk abimanyu dari drive yang disediakan. Kemudian dilakukan unzip, rename dan move ke direktori var/www.
```sh
wget -O parikesit.abimanyu.yyy.com.zip "https://drive.google.com/uc?export=download&id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS"
unzip parikesit.abimanyu.yyy.com.zip
mv parikesit.abimanyu.yyy.com parikesit.abimanyu.E14
mv parikesit.abimanyu.E14 var/www
```
Selanjutnya, pada file konfigurasi /etc/apache2/sites-available/000-default.conf, ditambahkan VirtualHost untuk parikesit.abimanyu berikut: 
```sh
echo '<VirtualHost *:80>' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerAdmin webmaster@localhost' >> /etc/apache2/sites-available/000-default.conf
echo '    DocumentRoot /var/www/parikesit.abimanyu.E14' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerName parikesit.abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    ServerAlias www.parikesit.abimanyu.E14.com' >> /etc/apache2/sites-available/000-default.conf
echo '    ErrorLog ${APACHE_LOG_DIR}/error.log' >> /etc/apache2/sites-available/000-default.conf
echo '    CustomLog ${APACHE_LOG_DIR}/access.log combined' >> /etc/apache2/sites-available/000-default.conf
echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf
```
Berikut hasil subdomain parikesit.abimanyu:
![Screenshot 2023-10-14 222512](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/48e4ca6e-f442-4b6c-b5c0-40ec6d9435b7)
![Screenshot (358)](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/9a5dc525-5ce0-4431-9319-5d31705040ba)

$~$

## Soal 14
> Pada subdomain tersebut folder /public hanya dapat melakukan directory listing sedangkan pada folder /secret tidak dapat diakses (403 Forbidden).

Supaya dapat melakukan directory listing pada folder public cukup ditambahkan `Option +Indexes` pada VirtualHost parikesit.abimanyu.
```sh
echo '    <Directory /var/www/parikesit.abimanyu.E14/public>' >> /etc/apache2/sites-available/000-default.conf
echo '        Options +Indexes' >> /etc/apache2/sites-available/000-default.conf
echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf
```
Kemudian folder secret dibuat dan ditambahkan html sederhana.
```sh
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
```
Untuk membatasi folder secret agak tidak dapat diakses, ditambahkan `Deny from all` pada VirtualHost parikesit.abimanyu.
```sh
echo '    <Directory /var/www/parikesit.abimanyu.E14/secret>' >> /etc/apache2/sites-available/000-default.conf
echo '        Deny from all' >> /etc/apache2/sites-available/000-default.conf
echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf
```

Berikut hasil dari directory listing folder public:
![Screenshot 2023-10-14 223228](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/37757049-d816-4b6e-9214-6e5e1a70ff1e)
![Screenshot (359)](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/3a37d205-35dd-4ccc-bfe0-35a2a556efe9)
Berikut hasil dari akses folder secret:
![Screenshot 2023-10-14 223233](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/ce62ed7f-eb06-4ee3-bfff-50f30fba293f)
![Screenshot (361)](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/0c3fc254-214a-496d-b8e6-64842f602028)

$~$

## Soal 15
> Buatlah kustomisasi halaman error pada folder /error untuk mengganti error kode pada Apache. Error kode yang perlu diganti adalah 404 Not Found dan 403 Forbidden.

Pada VirtualHost parikesit.abimanyu ditambahkan `ErrorDocument` 403 dan 404 yang diarahkan pada html masing-masing.
```sh
echo '    ErrorDocument 403 /error/403.html' >> /etc/apache2/sites-available/000-default.conf
echo '    ErrorDocument 404 /error/404.html' >> /etc/apache2/sites-available/000-default.conf
```

Berikut hasil dari error 403:
![Screenshot 2023-10-14 223233](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/ce62ed7f-eb06-4ee3-bfff-50f30fba293f)
![Screenshot (360)](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/e5718bdc-3ac4-4ab6-b17b-cdb9b81e3e52)
Berikut hasil dari error 404:
![Screenshot 2023-10-14 223701](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/49683448-0f3c-48e6-bc00-261e9389b12a)
![Screenshot (362)](https://github.com/athraz/Jarkom-Modul-2-E14-2023/assets/96050618/e83db9cc-48f1-4735-8729-952bbe4ea746)

$~$

## Soal 16
> Buatlah suatu konfigurasi virtual host agar file asset www.parikesit.abimanyu.yyy.com/public/js menjadi www.parikesit.abimanyu.yyy.com/js 

$~$

## Soal 17
> Agar aman, buatlah konfigurasi agar www.rjp.baratayuda.abimanyu.yyy.com hanya dapat diakses melalui port 14000 dan 14400.

$~$

## Soal 18
> Untuk mengaksesnya buatlah autentikasi username berupa “Wayang” dan password “baratayudayyy” dengan yyy merupakan kode kelompok. Letakkan DocumentRoot pada /var/www/rjp.baratayuda.abimanyu.yyy.

$~$

## Soal 19
> Buatlah agar setiap kali mengakses IP dari Abimanyu akan secara otomatis dialihkan ke www.abimanyu.yyy.com (alias)

$~$

## Soal 20
> Karena website www.parikesit.abimanyu.yyy.com semakin banyak pengunjung dan banyak gambar gambar random, maka ubahlah request gambar yang memiliki substring “abimanyu” akan diarahkan menuju abimanyu.png.

