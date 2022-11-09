#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
JENKINS_PIPELINE_WORKSPACE="/var/lib/jenkins/workspace/Final_Project"
MACHINE=$1

echo "Deploying to $machine start"

echo "Copying the docker compose file in $MACHINE machine"
scp -o StrictHostKeyChecking=no -r "$JENKINS_PIPELINE_WORKSPACE"/docker-compose.yml ec2-user@${MACHINE}:~

ssh -tto StrictHostKeyChecking=no ec2-user@${MACHINE} << 'EOF'
  cd /home/ec2-user/
  docker-compose up --no-build -d
  sleep 20
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
