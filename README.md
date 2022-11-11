<h1> Final project - Oren Gadmo - DevOps Bootcamp <h1/>
Let me to inturduce to my final project for the Bynet and 8200 course!
The main idea is based on an output from the "Webex" application that analyzed the attendance of the students in each lesson.
In addition, the application calculated the length of time the students were in class, the number of devices they connected to, the type of devices, emails, etc.
The task was to filter a table of all the students with the following details:
the student's name, the accumulated number of minutes and the general percentage of attendance in all classes.

In order to build it I used several Technologies:
Python3
CSS3 
Bootstrap
HTML + Jinja2
Javascript
MYSQL
Flask
Docker
Jenkins
AWS
Virtualbox - Ubuntu

Installation
Use the command cd to get into the docker-compose direcory location and write the command:
docker-compose up --build

Images
I'm used two docker containers in the project and uploaded to my dockerhub:
1) app -I'm define my command in a Dockerfile, and the docker-compose run it.
2) mysql - Build an table with all the students.

app.py:
Activated by the docker file with simple command "python3 app.py" .
In the app.py file I used jinja and HTML to decore and writh the index.html as a base HTML, and all the other HTML'S file are "inherat" the logic from him. 

sftp_csv.py-
Simply connect to remote server with secure transfer files and copy all the csv files fron the remote course machine into the our container.

attendance.py-
The main file in the project,I'ts fill All the calcutions, Contains all the actions required to create the final attendance file. Union of students with two email addresses, or students who entered the class with two or more devices, deletion of duplicates, etc.

.env file
Contain environment variables , and secure deatails 

deploy.sh
Usage: deploy.sh [test|prod]

This script deploys the project to test and prod servers,
It's copy docker-compose.yml to the [test | prod] server using secure transfer by [ssh | scp]
Also it's check if the current server is working.
if it is works it will runs curl command to check if my app is available.
