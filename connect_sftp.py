import pysftp


# create connection options object and ignore_known hosts check
cnopts = pysftp.CnOpts()
cnopts.hostkeys = None


# connection parameters
def connect_to_sftp():
    with pysftp.Connection(host='185.164.16.144', username='oreng', password='123456', cnopts=cnopts ) as sftp:
        print("connected to sftp server!")
        # dowmload remote folder files to local folder
        sftp.get_d("/var/tmp/csv_files/", localdir="./", preserve_mtime=True)
       