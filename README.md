# Cara Jalankan
1. pip install -r requirements.txt
2. import database **tomcat_elearning.sql** ke mysql
3. ke file **app.py** sesuaikan user mysql, directory, dan mail server
4. jalankan file **app.py**
5. buka *127.0.0.1:5000*
6. login dengan nis untuk masuk sebagai user
7. Selesai

# Fitur User
- Lihat Materi
- Kerjakan Kuis Google Form
- Lihat Kontributor
- Lihat Refrensi Jurnal
<br> ![demo2](https://user-images.githubusercontent.com/67460437/96371103-538f6e80-118a-11eb-933e-8ecab4cd58a7.gif)

# Fitur Admin
- CRUD Materi, Kuis, Kontributor, Notifikasi
<br> ![demo](https://user-images.githubusercontent.com/67460437/96370280-7bc99e00-1187-11eb-9d0f-0db15f384687.gif)

# Fitur Website
- Kirim Email Berhasil Register
- Data Logger
- Panel Admin 
<br> URL : *127.0.0.1:5000/admin* <br> username : tomcat <br> password : tomcat

# Security
- CSRF Token
- Filter Ekstension
- Filter Size Upload Foto
- Input Validation
