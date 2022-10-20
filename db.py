import mysql.connector
import start_attendance
import os
from os.path import join, dirname
from dotenv import load_dotenv

df = start_attendance.df_output

dotenv_path = join(dirname(__file__), '.env')

# load the environment variables from .env file
load_dotenv(dotenv_path)

host_env = os.environ.get('host_env')
username_env = os.environ.get('username_env')
password_env = os.environ.get('password_env')
database_env = os.environ.get('database_env')

load_dotenv()
conn =  mysql.connector.connect(host=host_env,username=username_env,password=password_env,database=database_env,use_pure=False)

#conn = mysql.connector.connect(host='127.0.0.1',username='oreng',password='og123456',database='attendance',use_pure=False)
if conn.is_connected():
    cursor = conn.cursor()
    cursor.execute("CREATE DATABASE attendance")
    print("Database is created")
    cursor.execute("select database();")
    record = cursor.fetchone()
    print("You're connected to database: ", record)
    cursor.execute('DROP TABLE IF EXISTS attendance_data;')
    print('Creating table....')
# in the below line please pass the create table statement which you want #to create
    cursor.execute("CREATE TABLE attendance_data(name varchar(255),avarage(255)")
    print("Table is created....")
    #loop through the data frame
    for i,row in df.iterrows():
        #here %S means string values 
        sql = "INSERT INTO attendance.attendance_data VALUES (%s,%s)"
        cursor.execute(sql, tuple(row))
        print("Record inserted")
        # the connection is not auto committed by default, so we must commit to save our changes
        conn.commit()

# Execute query
sql = "SELECT * FROM attendance.attendance_data"
cursor.execute(sql)
# Fetch all the records
result = cursor.fetchall()
for i in result:
    print(i)