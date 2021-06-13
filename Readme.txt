MySunShine Website

Website ini merupakan website e-commerce yang digunakan sebagai sarana transaksi toko kebutuhan bayi yang dinamakan
MySunShine. Pada website ini akan ada dua jalur akses, yaitu sebagai user biasa dan sebagai admin. Berikut merupakan
langkah-langkah untuk memulai mengakses website MySunShine :

1. Diperlukan folder source file website MySunShine untuk tersimpan di perangkat anda
2. Kemudian anda perlu menyesuaikan isi kode pada index.js (line 8-14) untuk sesuai dengan konfigurasi login
ke client postgreSQL anda
3. Lalu, anda perlu mengimport file database mysun_shines_db.sql atau membuat database baru (dengan nama dan isi 
yang sama) supaya data dapat dibaca dan terhubung ke website
4. Sekarang anda dapat memulai menyalakan website agar terhubung ke local host anda dengan menjalankan file index.js
pada Command Prompt yang sudah terhubung ke direktori penyimpanan folder. Command yang anda perlu beri ke cmd adalah
'node index.js'
5. Anda dapat mulai menampilkan dan mengakses website dengan membuka browser pilihan anda dan memasukkan url 'localhost:5000'

Sekarang anda sudah dapat mengakses halaman admin dan halaman user dari website, berikut panduan untuk setiap sisi

- Sebagai user
Halaman user diakses dengan 'localhost:5000/', yang merupakan halaman default dari website ini. User akan mendapat 
akses untuk melakukan transaksi produk jika memiliki akun yang pertama harus dibuat dengan registrasi akun website. 
Setelah itu langsung dapat memilih produk yang ingin dibeli dan memasukkan nama akun yang telah anda buat beserta 
dengan informasi lain yang diminta. Pada UI user, user hanya dapat melihat ada produk apa saja dan tidak dapat 
merubah apapun kecuali informasi user sendiri ketika transaksi mau dilakukan.

- Sebagai admin
Admin akan memiliki UI yang berbeda dengan user dan diakses dengan 'localhost:5000/admin', dan akan mendapat akses 
untuk membuat produk, menghapus produk,dan mengubah/mengedit data produk. Admin tidak dapat melakukan transaksi 
dengan UI-nya sehingga harus masuk sebagai user biasa untuk melihat UI user dan melakukan transaksi. Pada awalnya, 
tampilan web akan terlihat sama namun akan ada tombol tambahan yang terletak di bawah tiap produk untuk edit dan 
delete produk. Untuk membuat/menambah produk, akan perlu masuk ke halaman yang berbeda dengan mengklik tombol 
"Add New Product" di paling bawah dari halaman admin.