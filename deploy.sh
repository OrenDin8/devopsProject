#!/usr/bin/bash

MACHINE=$1

echo "Deploying to ${MACHINE} starting"

echo "copying the project dir in $MACHINE machine"
scp -o StrictHostKeyChecking=no -r "$/var/lib/jenkins/workspace/Final_Project" ec2-user@${MACHINE}:~

ssh -o StrictHostKeyChecking=no ec2-user@${MACHINE} << 'EOF'
  cp .env Final_Project/
  cd /home/ec2-user/Final_Project/
  docker-compose up --build -d
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

