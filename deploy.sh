#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
JENKINS_PIPELINE_WORKSPACE="/var/lib/jenkins/workspace/Final_Project"
MACHINE=$1

echo "Deploying to $machine start"

echo "Copying the docker compose file in $MACHINE machine"
scp -o StrictHostKeyChecking=no -r "$JENKINS_PIPELINE_WORKSPACE"/docker-compose.yml ec2-user@${MACHINE}:~

ssh -i "id_rsa" \
ec2-user@${MACHINE} \
-o BatchMode=yes -o StrictHostKeyChecking=no \
<< 'EOF'
cd /home/ec2-user/
docker-compose.yml up --no-build -d
sleep 20
if [ "$MACHINE" == "test" ];
  then
      if curl -I "http://127.0.0.1:5000" 2>&1 | grep -w "200\|301" ; then
        	echo "page is working"
    	else
        	echo "page is down"
    	fi
  fi
EOF

echo "Deploying to $MACHINE server succedded"
