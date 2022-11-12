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
   with pysftp.Connection(cnopts=cnopts, host=os.environ["host_machine_env"], username=os.environ["username_env"], password=os.environ["password_env"]) as sftp:
	#print("connected to sftp server!")
        # dowmload remote folder files to local folder
        sftp.get_d("/var/tmp/csv_files/", localdir="./", preserve_mtime=True)
connect_to_sftp()

       
       


