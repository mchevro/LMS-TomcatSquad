from flask import (Flask, redirect, url_for, request, 
                    render_template, abort, session, flash)
from flask_mysql_connector import MySQL
from flask_wtf.csrf import CSRFProtect
from flask_mail import Mail, Message
from static.TOKEN import RegistrationForm
from werkzeug.utils import secure_filename
import bcrypt
import os
import datetime
import requests
import bs4
from bs4 import BeautifulSoup

csrf = CSRFProtect()
app = Flask(__name__)
app.secret_key = os.urandom(24)
csrf.init_app(app)
app.config['MAX_CONTENT_LENGTH'] = 3 * 1024 * 1024

'''
UPLOAD GAMBAR
'''
UPLOAD_THUMBNAIL = 'static/assets/img/'                 #SESUAIKAN DENGAN DIRECTORY HOSTING
ALLOWED_EXTENSIONS = set(['jpeg', 'png', 'jpg'])
app.config['UPLOAD_THUMBNAIL'] = UPLOAD_THUMBNAIL

'''
DATABASE MYSQL
'''
#Mysql Konfigurasi
app.config['MYSQL_HOST']        = 'localhost'
app.config['MYSQL_USER']        = 'root'
app.config['MYSQL_PASSWORD']    = ''
app.config['MYSQL_DATABASE']    = 'tomcat_flask_elearning'
mysql = MySQL(app)


'''
MAIL KONFIGURASI
'''
#SMTP Konfigurasi
app.config['MAIL_SERVER']='smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USERNAME'] = 'USER_EMAIL'
app.config['MAIL_PASSWORD'] = 'PASSWORD_USER'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True
mail = Mail(app)


'''
A D M I N
'''
@app.route('/admin')
def index_admin():
    form = RegistrationForm()
    return  render_template('admin/index.html', form=form)

@app.route('/login_admin', methods = ['POST'])
def login_admin():
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        admin_username = request.form['username']
        admin_password = request.form['password']
        cur = mysql.new_cursor(dictionary=True)
        cur.execute("SELECT * FROM admin WHERE username=%s AND password=%s" , (admin_username, admin_password))
        account = cur.fetchone()
        if account:
            session['admin'] = True
            session['id'] = account['id']
            session['username'] = account['username']
            session['nama'] = account['nama']
            return redirect(url_for('index_admin_dashboard'))
        else:
            form = RegistrationForm()
            flash('Username Atau Password Salah')
            return render_template('admin/index.html',form=form)

@app.route('/logout_admin')
def logout_admin():
    session.pop('admin', None)
    session.pop('id', None)
    session.pop('username', None)
    session.pop('nama', None)
    flash('Anda Telah Keluar', 'logout')
    return redirect(url_for('index_admin')) 

@app.route('/admin/dashboard')
def index_admin_dashboard():
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT nama, email FROM user ORDER BY nama ASC")
        result = cur.fetchall()
        nama = session['nama']
        form = RegistrationForm()
        return render_template('admin/BerhasilLogin/dashboard.html',len = len(result) ,data_user=result, nama=nama, form=form)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/admin/materi')
def index_admin_materi():
    if 'admin' in session:
        conn = mysql.connection
        #Materi
        cur = conn.cursor()
        cur.execute("SELECT * FROM materi")
        result = cur.fetchall()
        #Notifikasi
        cur2 = conn.cursor()
        cur2.execute("SELECT * FROM notifikasi")
        result2 = cur2.fetchall()
        nama = session['nama']
        form = RegistrationForm()
        return render_template('admin/BerhasilLogin/materi.html', materi = result, notifikasi=result2, nama = nama, form=form)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/edit_materi', methods = ['POST'])
def edit_materi():
    if 'admin' in session:
        if request.method == 'POST':
            data_id = request.form['id']
            data_thumbnail = request.form['thumbnail']
            data_judul = request.form['judul']
            data_deskripsi = request.form['deskripsi']
            data_youtube = request.form['youtube']
            data_modul = request.form['modul']
            data_waktu = datetime.datetime.now()
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("UPDATE materi SET thumbnail=%s, judul=%s, deskripsi=%s, youtube=%s,  modul=%s,waktu=%s WHERE id=%s", (data_thumbnail, data_judul, data_deskripsi, data_youtube, data_modul,data_waktu, data_id))
            conn.commit()
            return redirect(url_for('index_admin_materi'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/add_materi', methods = ['POST'])
def add_materi():
    if 'admin' in session:
        if request.method == 'POST':
            data_thumbnail = request.form['thumbnail']
            data_judul = request.form['judul']
            data_deskripsi = request.form['deskripsi']
            data_youtube = request.form['youtube']
            data_modul = request.form['modul']
            data_waktu = datetime.datetime.now()
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("INSERT INTO materi (thumbnail, judul, deskripsi, youtube, modul, waktu) VALUES (%s,%s,%s,%s,%s,%s)", (data_thumbnail, data_judul, data_deskripsi, data_youtube, data_modul, data_waktu))
            conn.commit()
            return redirect(url_for('index_admin_materi'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/edit_notifikasi', methods = ['POST'])
def edit_notifikasi():
    if 'admin' in session:
        if request.method == 'POST':
            data_id = request.form['id']
            data_judul = request.form['judul']
            data_link = request.form['link']
            data_waktu = datetime.datetime.now()
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("UPDATE notifikasi SET judul=%s, link=%s, jam=%s WHERE id=%s", (data_judul, data_link, data_waktu, data_id))
            conn.commit()
            return redirect(url_for('index_admin_materi'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/admin/kuis')
def index_admin_kuis():
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM kuis")
        result = cur.fetchall()
        nama = session['nama']
        form = RegistrationForm()
        return render_template('admin/BerhasilLogin/kuis.html', kuis = result, nama = nama, form=form)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/edit_kuis', methods = ['POST'])
def edit_kuis():
    if 'admin' in session:
        if request.method == 'POST':
            data_id = request.form['id']
            data_thumbnail = request.form['thumbnail']
            data_materi = request.form['materi']
            data_deskripsi = request.form['deskripsi']
            data_embed = request.form['embed']
            data_soal = request.form['jumlah']
            data_waktu = datetime.datetime.now()
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("UPDATE kuis SET thumbnail=%s, materi=%s, deskripsi=%s, embed=%s,  jumlah=%s, waktu=%s WHERE id=%s", (data_thumbnail, data_materi, data_deskripsi, data_embed, data_soal, data_waktu, data_id))
            conn.commit()
            return redirect(url_for('index_admin_kuis'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/add_kuis', methods = ['POST'])
def add_kuis():
    if 'admin' in session:
        if request.method == 'POST':
            data_thumbnail = request.form['thumbnail']
            data_materi = request.form['materi']
            data_deskripsi = request.form['deskripsi']
            data_embed = request.form['embed']
            data_soal = request.form['jumlah']
            data_waktu = datetime.datetime.now()
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("INSERT INTO kuis (thumbnail, materi, deskripsi, embed, jumlah, waktu) VALUES (%s,%s,%s,%s,%s,%s)", (data_thumbnail, data_materi, data_deskripsi, data_embed, data_soal, data_waktu))
            conn.commit()
            return redirect(url_for('index_admin_kuis'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/delete_kuis/<int:data_id>', methods = ['GET'])
def delete_kuis(data_id):
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("DELETE FROM kuis WHERE id=%s" %(data_id))
        conn.commit()
        return redirect(url_for('index_admin_kuis'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/admin/kontributor')
def index_admin_kontributor():
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM kontributor")
        result = cur.fetchall()
        nama = session['nama']
        form = RegistrationForm()
        return render_template('admin/BerhasilLogin/kontributor.html', kontributor = result, nama = nama, form=form)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/edit_kontributor', methods = ['POST'])
def edit_kontributor():
    if 'admin' in session:
        if request.method == 'POST':
            data_id = request.form['id']
            data_foto = request.form['foto']
            data_nama = request.form['nama']
            data_materi = request.form['materi']
            data_instagram = request.form['instagram']
            data_whatsapp = request.form['whatsapp']
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("UPDATE kontributor SET foto=%s, nama=%s, materi=%s, instagram=%s, whatsapp=%s WHERE id=%s", (data_foto, data_nama, data_materi, data_instagram, data_whatsapp, data_id))
            conn.commit()
            return redirect(url_for('index_admin_kontributor'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/add_kontributor', methods = ['POST'])
def add_kontributor():
    if 'admin' in session:
        if request.method == 'POST':
            data_foto = request.form['foto']
            data_nama = request.form['nama']
            data_materi = request.form['materi']
            data_instagram = request.form['instagram']
            data_whatsapp = request.form['whatsapp']
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("INSERT INTO kontributor (foto, nama, materi, instagram, whatsapp) VALUES (%s,%s,%s,%s,%s)", (data_foto, data_nama, data_materi, data_instagram, data_whatsapp))
            conn.commit()
            return redirect(url_for('index_admin_kontributor'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/delete_kontributor/<int:data_id>', methods = ['GET'])
def delete_kontributor(data_id):
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("DELETE FROM kontributor WHERE id=%s" %(data_id))
        conn.commit()
        return redirect(url_for('index_admin_kontributor'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

@app.route('/upload', methods = ['POST'])
def upload_foto():
    if 'admin' in session:
        if request.method == 'POST':
            konfirmasi_thumbnail = request.files['Thumbnail']
            if konfirmasi_thumbnail and allowed_file(konfirmasi_thumbnail.filename):
                filename = konfirmasi_thumbnail.filename
                konfirmasi_thumbnail.save(os.path.join(app.config['UPLOAD_THUMBNAIL'], filename))
                return 'Upload Berhasil <br><a href="/admin/dashboard">Kembali Ke Dashboard</a>'
            else:
                flash('Gagal Upload Foto ! | Format : JPG, PNG, JPEG')
                return redirect(url_for('index_admin_dashboard'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/delete_materi/<int:data_id>', methods = ['GET'])
def delete_materi(data_id):
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("DELETE FROM materi WHERE id=%s" %(data_id))
        conn.commit()
        return redirect(url_for('index_admin_materi'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))
    

'''
U S E R
'''
@app.route('/')
def index():
    form = RegistrationForm()
    return  render_template('user/index.html', form=form)

@app.route('/login', methods = ['POST'])
def login():
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password'].encode('utf-8')
        cur = mysql.new_cursor(dictionary=True)
        cur.execute("SELECT * FROM user WHERE username=%s", (username,))
        account = cur.fetchone()
        if account:
            if bcrypt.hashpw(password, account["password"].encode('utf-8')) == account["password"].encode('utf-8'):
                session['login'] = True
                session['id'] = account['id']
                session['username'] = account['username']
                session['nama'] = account['nama']
                return redirect(url_for('index_dashboard'))
            else:
                flash('Password Salah')
                return redirect(url_for('index'))
        else:
            flash('User Tidak Terdaftar')
            return redirect(url_for('index'))

@app.route('/logout')
def logout():
    session.pop('login', None)
    session.pop('id', None)
    session.pop('username', None)
    session.pop('nama', None)
    flash('Anda Telah Keluar', 'logout')
    return redirect(url_for('index')) 

@app.route('/register', methods = ['POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        full_name = request.form['nama']
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        #SMTP
        msg = Message('Register Elearning Tomcat Squad', sender='USER_EMAIL',
                                    recipients=[f'{email}'])
        msg.body = f'Hallo {full_name},\n\nBerikut kami informasikan user akses anda di Portal LMS Tomcat Squad https://elearning.tomcatsquad.web.id\n\nUsername : {username}\nPassword  : {password}\n\nAnda bisa langsung mengunjungi Portal https://elearning.tomcatsquad.web.id kemudian masuk dengan username dan password tersebut.\n\nSekian informasi dari kami, jika ada masalah saat masuk bisa hubungi 0813 8166 2912\n\nTerima Kasih :)'
        mail.send(msg)
        #END SMTP
        password_mysql = password.encode('utf-8')
        hash_password = bcrypt.hashpw(password_mysql, bcrypt.gensalt())
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("INSERT INTO user (nama, email, username, password) VALUES (%s,%s,%s,%s)",(full_name,email,username,hash_password))
        conn.commit()
        flash('Register Berhasil, Silahkan Cek Email')
        return redirect(url_for('index'))
    else:
        flash('Data Tidak Lengkap')
        return redirect(url_for('index'))

@app.route('/dashboard')
def index_dashboard():
    if 'login' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM notifikasi")
        result = cur.fetchall()
        nama = session['nama']
        #WRITE LOG AKSES WEBSITE
        f = open("/log_akses.txt", "a") #SESUAIKAN DENGAN DIRECTORY HOSTING
        ip = request.environ['REMOTE_ADDR']
        time = datetime.datetime.now()
        get_time = time.strftime("%c")
        f.write(f'{get_time} {ip} {nama}\n')
        f.close
        return render_template('user/BerhasilLogin/dashboard.html', notifikasi=result, nama=nama)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/materi')
def index_materi():
    if 'login' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM materi ORDER BY id DESC")
        result = cur.fetchall()
        return render_template('user/BerhasilLogin/materi.html', materi = result)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/materi/<int:m_id>/<string:judul>', methods = ['GET'])
def index_materi2(m_id,judul):
    if 'login' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM materi WHERE id=%s" %(m_id))
        result = cur.fetchall()
        return render_template('user/BerhasilLogin/tutorial.html', tutorial = result)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/kuis')
def index_kuis():
    if 'login' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM kuis ORDER BY waktu DESC")
        result = cur.fetchall()
        return render_template('user/BerhasilLogin/kuis.html', kuis = result)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/kuis/<int:m_id>/<string:judul>', methods = ['GET'])
def index_kuis2(m_id,judul):
    if 'login' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM kuis WHERE id=%s" %(m_id))
        result = cur.fetchall()
        return render_template('user/BerhasilLogin/take_kuis.html', kuis = result)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))
'''
IP CALCULATOR
'''
def kelasA(i_ip, i_prefix):
    r = requests.get(f'http://jodies.de/ipcalc?host={i_ip}&mask1={i_prefix}&mask2=')
    soup = bs4.BeautifulSoup(r.text, 'html.parser')
    result = soup.find('pre').text
    ip = i_ip
    subnetmask = (result[83:95]).replace('=','')
    wildcard = (result[152:164])
    prefix = (result[97:105])
    return (f'IP Address : {ip}\nSubnetmask : {subnetmask}\nPrefix : {prefix}\nWildcard : {wildcard}')

def kelasB(i_ip, i_prefix):
    r = requests.get(f'http://jodies.de/ipcalc?host={i_ip}&mask1={i_prefix}&mask2=')
    soup = bs4.BeautifulSoup(r.text, 'html.parser')
    result = soup.find('pre').text
    ip = i_ip
    subnetmask = (result[83:97]).replace('=','')
    wildcard = (result[152:164])
    prefix = (result[97:105])
    return (f'IP Address : {ip}\nSubnetmask : {subnetmask}\nPrefix : {prefix}\nWildcard : {wildcard}')

def kelasC(i_ip, i_prefix):
    r = requests.get(f'http://jodies.de/ipcalc?host={i_ip}&mask1={i_prefix}&mask2=')
    soup = bs4.BeautifulSoup(r.text, 'html.parser')
    result = soup.find('pre').text
    ip = i_ip
    subnetmask = (result[83:98]).replace('=','')
    wildcard = (result[152:164])
    prefix = i_prefix
    return (f'IP Address : {ip}\nSubnetmask : {subnetmask}\nPrefix : {prefix}\nWildcard : {wildcard}')
    
@app.route('/tools')
def index_tools():
    if 'login' in session:
        form = RegistrationForm()
        return render_template('user/BerhasilLogin/subnet.html',form = form)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/subnet_kelasA', methods=['POST'])
def subnet_kelasA():
    if 'login' in session:
        req_ip = request.form['ipaddress']
        req_prefix = request.form['prefix']
        result = kelasA(req_ip, req_prefix)
        flash (f'{result}', 'kelasA')
        return redirect(url_for('index_tools'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/subnet_kelasB', methods=['POST'])
def subnet_kelasB():
    if 'login' in session:
        req_ip = request.form['ipaddress']
        req_prefix = request.form['prefix']
        result = kelasB(req_ip, req_prefix)
        flash (f'{result}', 'kelasB')
        return redirect(url_for('index_tools'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/subnet_kelasC', methods=['POST'])
def subnet_kelasC():
    if 'login' in session:
        req_ip = request.form['ipaddress']
        req_prefix = request.form['prefix']
        result = kelasC(req_ip, req_prefix)
        flash (f'{result}', 'kelasC')
        return redirect(url_for('index_tools'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))
'''
END IP CALCULATOR
'''

@app.route('/modul/<int:m_id>', methods = ['GET'])
def index_modul(m_id):
    if 'login' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM materi WHERE id=%s" %(m_id))
        result = cur.fetchall()
        return render_template('user/BerhasilLogin/modul.html', modul = result)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))
        
@app.route('/jurnal')
def index_jurnal():
    if 'login' in session:
        return render_template('user/BerhasilLogin/jurnal.html')
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/support')
def index_kontributor():
    if 'login' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM kontributor ORDER BY nama")
        result = cur.fetchall()
        return render_template('user/BerhasilLogin/support.html', kontributor = result)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')