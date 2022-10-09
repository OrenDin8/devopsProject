import pandas as pd
import os
import glob
import re

path = os.getcwd()

#Using glob we load all the csv files
mergedCsvFiles = glob.glob(os.path.join(path, "participant*.csv"))

# Create new empty dic
data = {'Name':{}}

print("Start to Merge all files . . ")
# loop over the list of csv files
for i in mergedCsvFiles:
    # read the csv file
    df = pd.read_csv(i, sep="\t", encoding="UTF-16LE")
    
    # change the names to lowercase and Convert time from string to integer
    for j in range(len(df)):
        cur_name = df.at[j, 'Name'].lower()
        cur_duration = re.findall(r'\d+', df.at[j, 'Attendance Duration'])
        cur_duration = int(''.join(cur_duration))
        # Add all to dictionary
        if cur_name not in data['Name']: # if name not exist
            data['Name'].update({cur_name: cur_duration})
        else: # if name exist
            data['Name'][cur_name] += cur_duration

df_output = pd.DataFrame.from_dict(data)


#Add col Attendance Percentage 
empty_col = pd.DataFrame(['']*len(df_output)) 
df_output.insert(1,'Percentage',empty_col)
  
#Calcuate the Attendance Percentage 
df_output['Percentage'] = (df_output['Name']/len(mergedCsvFiles)/240)*100


df_output.to_csv("output.csv")
print("Merge All File in Directory Succeed! !")

