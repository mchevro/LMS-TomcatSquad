import ftplib
import os
import time

class Ftp():
    def __init__(self, host, user, password):
        self.host = host
        self.user = user
        self.password = password
    
    def send(self, nameFile):
        try:
            session = ftplib.FTP(self.host, self.user, self.password)
            files = open(nameFile, 'rb')
            session.storbinary(f'STOR jurnal/{nameFile}', files)
            files.close()
            session.quit()
            time.sleep(1.5)
        except ftplib.all_errors as e:
            print('FTP Error: ', e)

    def delete(self, namaFile):
        try:
            session = ftplib.FTP(self.host, self.user, self.password)
            files = session.delete('jurnal/' + namaFile)
            session.quit()
            time.sleep(1.5)
        except ftplib.all_errors as e:
            print('FTP Error: ', e)