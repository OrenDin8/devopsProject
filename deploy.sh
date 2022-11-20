

#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
JENKINS_WORKSPACE="/var/lib/jenkins/workspace/Final_Project"
MACHINE=$1
IP_PUBLIC='ec2-35-171-157-87.compute-1.amazonaws.com'
if [ "$MACHINE" == 'test' ];
 then 
     IP_PUBLIC='ec2-35-171-157-87.compute-1.amazonaws.com'
	 echo "Deploying to test start"
else 
     IP_PUBLIC='ec2-54-174-199-225.compute-1.amazonaws.com'
	 echo "Deploying to production start"
fi
echo "Copying the docker compose file to the machine"
scp -i "Devops-course.pem"  -o StrictHostKeyChecking=no "$JENKINS_WORKSPACE"/docker-compose.yml ec2-user@${IP_PUBLIC}:~
scp -i "Devops-course.pem" -o StrictHostKeyChecking=no "$JENKINS_WORKSPACE"/.env ec2-user@${IP_PUBLIC}:~

ssh -i "Devops-course.pem" -o StrictHostKeyChecking=no ec2-user@${IP_PUBLIC} "cd /home/ec2-user/ && docker pull orendin8/devops_project:latest && docker-compose up --no-build -d && sleep 30"

HTTP_CODE_STATUS=`curl -o /dev/null -s -w "%{http_code}\n" http://localhost:5000/`	
if [ "$MACHINE" == "test" ];	     
then
	if [ $HTTP_CODE_STATUS -eq 200 ];
	then
		echo "The web is up"
	else
		echo "The web is down"
		exit 1
	fi
fi
echo "Deploying to $MACHINE server succedded"


