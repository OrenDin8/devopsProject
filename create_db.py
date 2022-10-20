from dataclasses import dataclass
from dbm.dumb import _Database
import mysql.connector
import start_attendance

df = start_attendance.df_output
mydb = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = 'og123456',
    database = 'attendance'
)
my_cursor = mydb.cursor()
#my_cursor.execute("CREATE DATABASE attendance")
#my_cursor.execute("SHOW DATABASES")
#my_cursor.execute("select database();")
#record = my_cursor.fetchone()
#print("You're connected to database:", record)
my_cursor.execute("CREATE TABLE attendance_data(name varchar(255),avarage varchar(255))")
print("Table is created....")
#loop through the data frame
for i,row in df.iterrows():
    #here %S means string values 
    sql = "INSERT INTO attendance.attendance_data VALUES (%s,%s)"
    my_cursor.execute(sql, tuple(row))
    print("Record inserted")
    # the connection is not auto committed by default, so we must commit to save our changes
    mydb.commit()

# Execute query
sql = "SELECT * FROM attendance.attendance_data"
my_cursor.execute(sql)
# Fetch all the records
result = my_cursor.fetchall()
for i in result:
    print(i)

