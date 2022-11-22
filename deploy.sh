

#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
JENKINS_WORKSPACE="/var/lib/jenkins/workspace/Final_Project"
MACHINE=$1
IP_PUBLIC='ec2-3-86-12-33.compute-1.amazonaws.com'
if [ "$MACHINE" == 'test' ];
 then 
     IP_PUBLIC='ec2-3-86-12-33.compute-1.amazonaws.com'
	 echo "Deploying to test start"
else 
     IP_PUBLIC='ec2-34-236-143-158.compute-1.amazonaws.com'
	 echo "Deploying to production start"
fi
echo "Copying the docker compose file to the machine"

scp -p 22 -i "Devops-course.pem"  -o StrictHostKeyChecking=no "$JENKINS_WORKSPACE"/docker-compose.yml ec2-user@$MACHINE:~
scp -p 22 -i "Devops-course.pem" -o StrictHostKeyChecking=no "$JENKINS_WORKSPACE"/.env ec2-user@$MACHINE:~

ssh -p 22 -i "Devops-course.pem" -o StrictHostKeyChecking=no ec2-user@$MACHINE "cd /home/ec2-user/ && docker pull orendin8/devops_project:latest && docker-compose up --no-build -d && sleep 20"

if [ "$MACHINE" == "test" ];
 then
 	status=`curl --write-out "%{http_code}\n" --silent --output /dev/null "http://127.0.0.1:5000"`
	echo $status
	if [ "$status" == "200" ];
	then
	 echo "test PASSED successfully."
	else
	 echo "Test Failed"
	 fi
fi
echo "Deploying to $MACHINE server succedded"
