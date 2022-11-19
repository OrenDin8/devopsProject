

#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
JENKINS_WORKSPACE="/var/lib/jenkins/workspace/Final_Project"
MACHINE=$1
if [ "$MACHINE" == 'test' ];
 then 
     MACHINE='ec2-44-201-110-248.compute-1.amazonaws.com'
	 echo "Deploying to test start"
else 
     MACHINE='ec2-54-163-62-126.compute-1.amazonaws.com'
	 echo "Deploying to production start"

fi
echo "Copying the docker compose file in $MACHINE machine"
scp -o StrictHostKeyChecking=no -r "$JENKINS_WORKSPACE"/docker-compose.yml ec2-user@${MACHINE}:~

ssh -i Devops-course.pem ec2-user@{MACHINE} "cd /home/ec2-user/ && docker pull orendin8/devops_project:latest && docker-compose up --no-build -d && sleep 30"

if [ "$MACHINE" == "test" ];
 then
     if curl -I "http://127.0.0.1:5000" 2>&1 | grep -w "200\|301" ; then
       	echo "page is working"
   	else
       	echo "page is down"
   	fi
fi
echo "Deploying to $MACHINE server succedded"


