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

$~$

## Soal 9
> Arjuna merupakan suatu Load Balancer Nginx dengan tiga worker (yang juga menggunakan nginx sebagai webserver) yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Lakukan deployment pada masing-masing worker.

$~$

## Soal 10
> Kemudian gunakan algoritma Round Robin untuk Load Balancer pada Arjuna. Gunakan server_name pada soal nomor 1. Untuk melakukan pengecekan akses alamat web tersebut kemudian pastikan worker yang digunakan untuk menangani permintaan akan berganti ganti secara acak. Untuk webserver di masing-masing worker wajib berjalan di port 8001-8003. Contoh: Prabakusuma 8001, Abimanyu 8002, Wisanggeni 8003

$~$

## Soal 11
> Selain menggunakan Nginx, lakukan konfigurasi Apache Web Server pada worker Abimanyu dengan web server www.abimanyu.yyy.com. Pertama dibutuhkan web server dengan DocumentRoot pada /var/www/abimanyu.yyy

$~$

## Soal 12
> Setelah itu ubahlah agar url www.abimanyu.yyy.com/index.php/home menjadi www.abimanyu.yyy.com/home.

$~$

## Soal 13
> Selain itu, pada subdomain www.parikesit.abimanyu.yyy.com, DocumentRoot disimpan pada /var/www/parikesit.abimanyu.yyy

$~$

## Soal 14
> Pada subdomain tersebut folder /public hanya dapat melakukan directory listing sedangkan pada folder /secret tidak dapat diakses (403 Forbidden).

$~$

## Soal 15
> Buatlah kustomisasi halaman error pada folder /error untuk mengganti error kode pada Apache. Error kode yang perlu diganti adalah 404 Not Found dan 403 Forbidden.

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

