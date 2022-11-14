<div>
    <h1>Final project - Oren Gadamo - Dev8200 DevOps Bootcamp</h1>
    <strong>
    <p>Let me to inturduce to my final project for the Bynet and 8200 course!</p>
    <p>
        The main idea is based on an output from <a href="https://www.webex.com/">"Webex"</a>        application that analyzed the attendance of the students in each lesson.
        In addition, the application calculated the length of time the students were in class, the number of devices they connected to, the type of devices, emails, etc.
        The task was to filter a table of all the students with the following details:
        the student's name, the accumulated number of minutes and the general percentage of attendance in all classes.
    </strong>
    </p>
</div>

<h3>In order to build it I used several Technologies:</h3>
<li>Python3 </li>
<li>CSS3 </li> 
<li>Bootstrap </li>
<li>HTML + Jinja2 </li>
<li>Javascript </li>
<li>MYSQL </li>
<li>Flask </li>
<li>Docker </li>
<li>Jenkins </li>
<li>AWS </li>
<li>Virtualbox - Ubuntu </li>
</li>

<h3>Installation</h3>
<p>
    Use the command cd to get into the docker-compose direcory location and write the command:
    docker-compose up --build
</p>
<h3>Images</h3>
<p>
    I'm used two docker containers in the project and uploaded to my dockerhub:
        <li>app -I'm define my command in a Dockerfile, and the docker-compose run it.</li>
        <li> mysql - Build an table with all the students.</li>
</p>
<h3>app.py</h3>
<p>
    Activated by the docker file with simple command "python3 app.py" .
    In the app.py file I used jinja and HTML to decore and writh the index.html as a base HTML, and all the other HTML'S file are "inherat" the logic from him. 
</p>
<h3>Dockerfile</h3>
<p>
    In the Dockerfile we will define our environment that we use, also the dependencies that we will use (in the requirements.txt file), in addition to copying files to the container that we will use in Docker Compose.
</p>   
<h3>Jenkinsfile</h3>
<p>
    A file in which all the testing and construction phases of the project are defined.
    A stage of building the image, pushing to dockerhub after building an image, pulling from dockerhub for proper testing in the testing stage, and then moving to a final stage of uploading to production..
</p>

<h3>sftp_csv.py</h3>
<p>
    Simply connect to remote server with secure transfer files and copy all the csv files fron the remote course machine into the our container.
</p>
image.png
<h3>attendance.py</h3>
<p>
    The main file in the project,I'ts fill All the calcutions, Contains all the actions required to create the final attendance file. Union of students with two email addresses, or students who entered the class with two or more devices, deletion of duplicates, etc.
</p>
<h3>.env file</h3>
<p>Contain environment variables , and secure deatails.</p> 

<h3>deploy.sh</h3>
<p>
    Usage: deploy.sh [test|prod]
    This script deploys the project to test and prod servers,
    It's copy docker-compose.yml to the [test | prod] server using secure transfer by [ssh | scp]
    Also it's check if the current server is working.
    if it is works it will runs curl command to check if my app is available.
</p>
<h3>Screenshots</h3>
![ScreenShot](https://github.com/OrenDin8/devopsProject/blob/main/Screenshots/home.jpg)
![ScreenShot](https://github.com/OrenDin8/devopsProject/blob/main/Screenshots/attendance_table.jpg)
![ScreenShot](https://github.com/OrenDin8/devopsProject/blob/main/Screenshots/contact.jpg)
![ScreenShot](https://github.com/OrenDin8/devopsProject/blob/main/Screenshots/about.jpg)
