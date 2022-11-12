import pysftp
import warnings
import os
from dotenv import load_dotenv


warnings.filterwarnings('ignore','.*Failed to load HostKeys.*')
# create connection options object and ignore_known hosts check
cnopts = pysftp.CnOpts()
cnopts.hostkeys = None
load_dotenv()

# connection parameters
def connect_to_sftp():
   with pysftp.Connection(cnopts=cnopts, host='185.164.16.144', username='oreng', password='123456') as sftp:
	#print("connected to sftp server!")
        # dowmload remote folder files to local folder
        sftp.get_d("/var/tmp/csv_files/", localdir="./", preserve_mtime=True)
connect_to_sftp()

       
       


