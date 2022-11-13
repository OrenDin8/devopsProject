#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
JENKINS_WORKSPACE="/var/lib/jenkins/workspace/Final_Project"
MACHINE=$1

echo "Deploying to ${MACHINE} start"

echo "Copying the docker compose file in $MACHINE machine"
scp -o StrictHostKeyChecking=no -r "$JENKINS_WORKSPACE"/docker-compose.yml ec2-user@${MACHINE}:~

ssh -o StrictHostKeyChecking=no ec2-user@${MACHINE} "cd /home/ec2-user/ && docker pull orendin8/devops_project:latest && docker-compose up --no-build -d && sleep 30"
if [ "$MACHINE" == "test" ];
 then
     if curl -I "http://127.0.0.1:5000" 2>&1 | grep -w "200\|301" ;
      then
       	echo "The website is up "
   	  else
       	echo "The website is down"
   	 fi
fi
echo "Deploying to $MACHINE server succedded"
