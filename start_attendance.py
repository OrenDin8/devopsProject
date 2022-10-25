from ast import Str
import pandas as pd
import attendance
import connect_sftp




#get the result from the attendance.py file
path = "./attendance.csv"

# exec the function to connect the sftp 
connect_sftp.connect_to_sftp()

#read the csv file        
df = pd.read_csv(path)

#Create a new df
df2 = df[['names','average']]
df2 = df2.sort_values('average').reset_index(drop=True).sort_index(ascending=False).reset_index(drop=True)
df_output = df2
df_output["average"] = df_output["average"].replace({' %':' '}, regex=True).astype("float")
df_output["average"] = round(df_output['average'],2).astype("str") +' %'
