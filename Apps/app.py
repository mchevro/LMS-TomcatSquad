from flask import (Flask, redirect, url_for, request, 
                    render_template, abort, session, flash)
from flask_mysql_connector import MySQL
from flask_wtf.csrf import CSRFProtect
from static.FTP import Ftp
from static.TOKEN import RegistrationForm
from werkzeug.utils import secure_filename
import os
import datetime
import time

csrf = CSRFProtect()
app = Flask(__name__)
app.secret_key = os.urandom(24)
csrf.init_app(app)
app.config['MAX_CONTENT_LENGTH'] = 25 * 1024 * 1024

#===================
# KONFIG GAMBAR START
#===================
ALLOWED_EXTENSIONS = set(['jpeg', 'png', 'jpg', 'pdf'])
UPLOAD_THUMBNAIL = '/home/tomcatsq/public_html/elearning.tomcatsquad.web.id/static/assets/img/'                 #SESUAIKAN DENGAN DIRECTORY HOSTING
app.config['UPLOAD_THUMBNAIL'] = UPLOAD_THUMBNAIL
UPLOAD_JURNAL = '/home/tomcatsq/public_html/elearning.tomcatsquad.web.id/'               #SESUAIKAN DENGAN DIRECTORY HOSTING
app.config['UPLOAD_JURNAL'] = UPLOAD_JURNAL
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS
#===================
# KONFIG GAMBAR END
#===================

#===================
# DATABASE START
#===================
app.config['MYSQL_HOST']        = 'localhost'
app.config['MYSQL_USER']        = 'root'
app.config['MYSQL_PASSWORD']    = ''
app.config['MYSQL_DATABASE']    = 'tomcatsq_elearning'
mysql = MySQL(app)
#===================
# DATABASE END
#===================

#====================================
# VIEW ADMIN START
#====================================
@app.route('/admin', methods = ['GET', 'POST'])
def index_admin():
    form = RegistrationForm()
    if request.method == 'POST' and 'username' in request.form:
        admin_nis = request.form['username']
        cur = mysql.new_cursor(dictionary=True)
        cur.execute("SELECT * FROM user WHERE nis=%s AND level='admin'" %(admin_nis))
        account = cur.fetchone()
        if account:
            session['admin'] = True
            session['nama'] = account['nama']
            return redirect(url_for('index_admin_dashboard'))
        else:
            form = RegistrationForm()
            flash('Username Atau Password Salah')
            return render_template('admin/index.html',form=form)
    if 'admin' in session:
        return redirect(url_for('index_admin_dashboard'))
        
    return  render_template('admin/index.html', form=form)

@app.route('/logout_admin')
def logout_admin():
    session.pop('admin', None)
    session.pop('nama', None)
    flash('Anda Telah Keluar', 'logout')
    return redirect(url_for('index_admin')) 

@app.route('/admin/dashboard')
def index_admin_dashboard():
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT nis, nama, kelas FROM user ORDER BY kelas ASC")
        result = cur.fetchall()
        nama = session['nama']
        form = RegistrationForm()
        return render_template('admin/BerhasilLogin/dashboard.html',len = len(result) ,data_user=result, nama=nama, form=form)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

#===================
# DASHBOARD MATERI START
#===================
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

@app.route('/add_materi', methods = ['POST'])
def add_materi():
    if 'admin' in session:
        if request.method == 'POST':
            data_thumbnail = request.files['thumbnail']
            data_judul = request.form['judul']
            data_deskripsi = request.form['deskripsi']
            data_youtube = request.form['youtube']
            data_modul = request.form['modul']
            data_waktu = datetime.datetime.now()
            if data_thumbnail and allowed_file(data_thumbnail.filename):
                try:
                    filename = data_thumbnail.filename
                    data_thumbnail.save(os.path.join(app.config['UPLOAD_THUMBNAIL'], data_judul + '.jpg'))
                except:
                    abort(403)
                conn = mysql.connection
                cur = conn.cursor()
                cur.execute("INSERT INTO materi (thumbnail, judul, deskripsi, youtube, modul, waktu) VALUES (%s,%s,%s,%s,%s,%s)", (data_judul + '.jpg', data_judul, data_deskripsi, data_youtube, data_modul, data_waktu))
                conn.commit()
                flash('BERHASIL BUAT MATERI')
                return redirect(url_for('index_admin_materi'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/edit_materi', methods = ['POST'])
def edit_materi():
    if 'admin' in session:
        if request.method == 'POST':
            data_id = request.form['id']
            data_judul = request.form['judul']
            data_deskripsi = request.form['deskripsi']
            data_youtube = request.form['youtube']
            data_modul = request.form['modul']
            data_waktu = datetime.datetime.now()
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("UPDATE materi SET judul=%s, deskripsi=%s, youtube=%s,  modul=%s,waktu=%s WHERE id=%s", (data_judul, data_deskripsi, data_youtube, data_modul,data_waktu, data_id))
            conn.commit()
            flash('BERHASIL EDIT MATERI')
            return redirect(url_for('index_admin_materi'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/delete_materi/<int:data_id>', methods = ['GET'])
def delete_materi(data_id):
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("DELETE FROM materi WHERE id=%s" %(data_id))
        conn.commit()
        flash('MATERI TELAH DIHAPUS')
        return redirect(url_for('index_admin_materi'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))
#===================
# DASHBOARD MATERI END
#===================

#===================
# DASHBOARD NOTIFIKASI START
#===================
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
            flash('NOTIFIKASI TELAH DIPERBARUI')
            return redirect(url_for('index_admin_materi'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))
#===================
# DASHBOARD NOTIFIKASI END
#===================

#===================
# DASHBOARD KUIS START
#===================
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

@app.route('/add_kuis', methods = ['POST'])
def add_kuis():
    if 'admin' in session:
        if request.method == 'POST':
            data_thumbnail = request.files['thumbnail']
            data_materi = request.form['materi']
            data_deskripsi = request.form['deskripsi']
            data_embed = request.form['embed']
            data_soal = request.form['jumlah']
            data_waktu = datetime.datetime.now()
            if data_thumbnail and allowed_file(data_thumbnail.filename):
                try:
                    filename = data_thumbnail.filename
                    data_thumbnail.save(os.path.join(app.config['UPLOAD_THUMBNAIL'], data_materi + '.jpg'))
                except:
                    abort(403)
                conn = mysql.connection
                cur = conn.cursor()
                cur.execute("INSERT INTO kuis (thumbnail, materi, deskripsi, embed, jumlah, waktu) VALUES (%s,%s,%s,%s,%s,%s)", (data_materi + '.jpg', data_materi, data_deskripsi, data_embed, data_soal, data_waktu))
                conn.commit()
                flash('BERHASIL BUAT KUIS')
                return redirect(url_for('index_admin_kuis'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/edit_kuis', methods = ['POST'])
def edit_kuis():
    if 'admin' in session:
        if request.method == 'POST':
            data_id = request.form['id']
            data_materi = request.form['materi']
            data_deskripsi = request.form['deskripsi']
            data_embed = request.form['embed']
            data_soal = request.form['jumlah']
            data_waktu = datetime.datetime.now()
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("UPDATE kuis SET materi=%s, deskripsi=%s, embed=%s,  jumlah=%s, waktu=%s WHERE id=%s", (data_materi, data_deskripsi, data_embed, data_soal, data_waktu, data_id))
            conn.commit()
            flash('BERHASIL EDIT KUIS')
            return redirect(url_for('index_admin_kuis'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/delete_kuis/<int:data_id>', methods = ['GET'])
def delete_kuis(data_id):
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("DELETE FROM kuis WHERE id=%s" %(data_id))
        conn.commit()
        flash('KUIS TELAH DIHAPUS')
        return redirect(url_for('index_admin_kuis'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))
#===================
# DASHBOARD KUIS END
#===================

#===================
# DASHBOARD JURNAL START
#===================
@app.route('/admin/jurnal')
def index_admin_jurnal():
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM jurnal")
        result = cur.fetchall()
        nama = session['nama']
        form = RegistrationForm()
        return render_template('admin/BerhasilLogin/jurnal.html', jurnal = result, nama = nama, form=form)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/add_jurnal', methods = ['POST'])
def add_jurnal():
    if 'admin' in session:
        if request.method == 'POST':
            data_file = request.files['file']
            data_nama = request.form['nama']
            data_judul = request.form['judul']
            data_tahun = request.form['tahun']
            if data_file and allowed_file(data_file.filename):
                try:
                    filename = data_file.filename
                    data_file.save(os.path.join(app.config['UPLOAD_JURNAL'], data_nama + '.pdf'))
                    time.sleep(3)
                    jurnal = Ftp('asd', 'asd', 'asd')
                    jurnal.send(f'{data_nama}.pdf')
                    time.sleep(2)
                    os.remove(data_nama + '.pdf')
                except:
                    abort(403)
                conn = mysql.connection
                cur = conn.cursor()
                cur.execute("INSERT INTO jurnal (nama, judul, tahun, file) VALUES (%s,%s,%s,%s)", (data_nama, data_judul, data_tahun, data_nama + '.pdf'))
                conn.commit()
                flash('BERHASIL TAMBAH JURNAL')
                return redirect(url_for('index_admin_jurnal'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/edit_jurnal', methods = ['POST'])
def edit_jurnal():
    if 'admin' in session:
        if request.method == 'POST':
            data_id = request.form['id']
            data_nama = request.form['nama']
            data_judul = request.form['judul']
            data_tahun = request.form['tahun']
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("UPDATE jurnal SET nama=%s, judul=%s, tahun=%s WHERE id=%s", (data_nama, data_judul, data_tahun, data_id))
            conn.commit()
            flash('BERHASIL EDIT JURNAL')
            return redirect(url_for('index_admin_jurnal'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/delete_jurnal/<string:data_file>', methods = ['GET'])
def delete_jurnal(data_file):
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("DELETE FROM jurnal WHERE file='%s'" %(data_file))
        conn.commit()
        time.sleep(1)
        delete_jurnal = Ftp('ftp.tomcatsquad.web.id', 'mchevro@files.tomcatsquad.web.id', 'Mahendra@123')
        delete_jurnal.delete(data_file)
        flash('JURNAL TELAH DIHAPUS')
        return redirect(url_for('index_admin_jurnal'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))
#===================
# DASHBOARD JURNAL END
#===================

#===================
# DASHBOARD KONTRIBUTOR START
#===================
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

@app.route('/add_kontributor', methods = ['POST'])
def add_kontributor():
    if 'admin' in session:
        if request.method == 'POST':
            data_foto = request.files['foto']
            data_nama = request.form['nama']
            data_materi = request.form['materi']
            data_instagram = request.form['instagram']
            data_whatsapp = request.form['whatsapp']
            if data_foto and allowed_file(data_foto.filename):
                try:
                    filename = data_foto.filename
                    data_foto.save(os.path.join(app.config['UPLOAD_THUMBNAIL'], data_nama + '.jpg'))
                except:
                    abort(403)
                conn = mysql.connection
                cur = conn.cursor()
                cur.execute("INSERT INTO kontributor (foto, nama, materi, instagram, whatsapp) VALUES (%s,%s,%s,%s,%s)", (data_nama + '.jpg', data_nama, data_materi, data_instagram, data_whatsapp))
                conn.commit()
                flash('BERHASIL TAMBAH KONTRIBUTOR')
                return redirect(url_for('index_admin_kontributor'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))

@app.route('/edit_kontributor', methods = ['POST'])
def edit_kontributor():
    if 'admin' in session:
        if request.method == 'POST':
            data_id = request.form['id']
            data_nama = request.form['nama']
            data_materi = request.form['materi']
            data_instagram = request.form['instagram']
            data_whatsapp = request.form['whatsapp']
            conn = mysql.connection
            cur = conn.cursor()
            cur.execute("UPDATE kontributor SET nama=%s, materi=%s, instagram=%s, whatsapp=%s WHERE id=%s", (data_nama, data_materi, data_instagram, data_whatsapp, data_id))
            conn.commit()
            flash('BERHASIL EDIT KONTRIBUTOR')
            return redirect(url_for('index_admin_kontributor'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/delete_kontributor/<int:data_id>', methods = ['GET'])
def delete_kontributor(data_id):
    if 'admin' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("DELETE FROM kontributor WHERE id=%s" %(data_id))
        conn.commit()
        flash('KONTRIBUTOR TELAH DIHAPUS')
        return redirect(url_for('index_admin_kontributor'))
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index_admin'))
#===================
# DASHBOARD KONTRIBUTOR END
#===================

#====================================
# VIEW ADMIN END
#====================================

#====================================
# VIEW USER START
#====================================
@app.route('/', methods = ['GET', 'POST'])
def index():
    form = RegistrationForm()
    if request.method == 'POST' and 'nis' in request.form:
        user_nis = request.form['nis']
        cur = mysql.new_cursor(dictionary=True)
        cur.execute("SELECT * FROM user WHERE nis=%s" %(user_nis))
        account = cur.fetchone()
        if account:
            session['login'] = True
            session['nis'] = account['nis']
            session['nama'] = account['nama']
            return redirect(url_for('index_dashboard'))
        else:
            flash('Nomor Induk Siswa Tidak Ada')
            return redirect(url_for('index'))
    if 'login' in session:
        return redirect(url_for('index_dashboard'))
        
    return  render_template('user/index.html', form=form)

@app.route('/logout')
def logout():
    session.pop('login', None)
    session.pop('nis', None)
    session.pop('nama', None)
    flash('Anda Telah Keluar', 'logout')
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
#===================
# USER IP CALC START
#===================
@app.route('/tools')
def index_tools():
    if 'login' in session:
        form = RegistrationForm()
        return render_template('user/BerhasilLogin/subnet.html',form = form)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/subnet', methods=['POST'])
def subnet():
    if 'login' in session:
        req_ip = request.form['ipaddress']
        req_prefix = request.form['prefix']
        if req_prefix == '8':
            flash(f'IP Address : {req_ip} Subnetmask : 255.0.0.0 Wildcard : 0.255.255.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '9':
            flash(f'IP Address : {req_ip} Subnetmask : 255.128.0.0 Wildcard : 0.127.255.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '10':
            flash(f'IP Address : {req_ip} Subnetmask : 255.192.0.0 Wildcard : 0.63.255.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '11':
            flash(f'IP Address : {req_ip} Subnetmask : 255.224.0.0 Wildcard : 0.31.255.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '12':
            flash(f'IP Address : {req_ip} Subnetmask : 255.240.0.0 Wildcard : 0.15.255.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '13':
            flash(f'IP Address : {req_ip} Subnetmask : 255.248.0.0 Wildcard : 0.7.255.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '14':
            flash(f'IP Address : {req_ip} Subnetmask : 255.252.0.0 Wildcard : 0.3.255.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '15':
            flash(f'IP Address : {req_ip} Subnetmask : 255.254.0.0 Wildcard : 0.1.255.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '16':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.0.0 Wildcard : 0.0.255.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '17':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.128.0 Wildcard : 0.0.127.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '18':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.192.0 Wildcard : 0.0.63.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '19':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.224.0 Wildcard : 0.0.31.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '20':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.240.0 Wildcard : 0.0.15.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '21':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.248.0 Wildcard : 0.0.7.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '22':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.252.0 Wildcard : 0.0.3.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '23':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.254.0 Wildcard : 0.0.1.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '24':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.255.0 Wildcard : 0.0.0.255', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '25':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.255.128 Wildcard : 0.0.0.127', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '26':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.255.192 Wildcard : 0.0.0.63', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '27':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.255.224 Wildcard : 0.0.0.31', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '28':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.255.240 Wildcard : 0.0.0.15', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '29':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.255.248 Wildcard : 0.0.0.7', 'subnet' )
            return redirect(url_for('index_tools'))

        elif req_prefix == '30':
            flash(f'IP Address : {req_ip} Subnetmask : 255.255.255.252 Wildcard : 0.0.0.3', 'subnet' )
            return redirect(url_for('index_tools'))
        else:
            abort(404)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))
#===================
# USER IP CALC END
#===================

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
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM jurnal")
        result = cur.fetchall()
        return render_template('user/BerhasilLogin/jurnal.html', jurnal = result)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

@app.route('/support')
def index_kontributor():
    if 'login' in session:
        conn = mysql.connection
        cur = conn.cursor()
        cur.execute("SELECT * FROM kontributor")
        result = cur.fetchall()
        return render_template('user/BerhasilLogin/support.html', kontributor = result)
    else:
        flash('Login Terlebih Dahulu')
        return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
