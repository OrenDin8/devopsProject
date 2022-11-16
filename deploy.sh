#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
JENKINS_WORKSPACE="/var/lib/jenkins/workspace/Final_Project"
MACHINE=$1
TEST=44.204.24.143    

echo "Deploying to ${MACHINE} start"

echo "Copying the docker compose file in $MACHINE machine"
scp -o StrictHostKeyChecking=no -r "$JENKINS_WORKSPACE"/docker-compose.yml ec2-user@${MACHINE}:~

ssh -o StrictHostKeyChecking=no ec2-user@${MACHINE} "cd /home/ec2-user/ && docker pull orendin8/devops_project:latest && docker-compose up --no-build -d && sleep 30"

  if [ "$MACHINE" == "test" ];
  then
      HTTP=`curl --write-out "%{http_code}\n" --silent --output /dev/null "http://127.0.0.1:5000"`
      echo $HTTP
      if [ "$HTTP" == "200" ];
      then
  echo "Test succedded"
      else
  echo "Test failed"
      fi
  fi
echo "Deploying to $MACHINE server succedded"
