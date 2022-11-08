#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
JENKINS_PIPELINE_WORKSPACE="/var/lib/jenkins/workspace/Final_Project"
MACHINE=$1

echo "Deploying to ${MACHINE} starting"

cd $HOME_DIR"/.ssh

echo "Copying the docker-compose file in $MACHINE machine"

scp -o StrictHostKeyChecking=no "$JENKINS_PIPELINE_WORKSPACE"/docker-compose.yml ec2-user@${MACHINE}:~
sco -o StrictHostKeyChecking=no ec2-user@${MACHINE} << 'EOF'
  cp .env /Final_Project
  cd /home/ec2-user/Final_Project/
  sudo docker system prune
  docker-compose up -d --no-build 
  sleep 25
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
EOF

echo "Deploying to $MACHINE server succedded"

