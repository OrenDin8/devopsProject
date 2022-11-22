

#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
JENKINS_WORKSPACE="/var/lib/jenkins/workspace/Final_Project"
MACHINE=$1
TEST=172.31.85.71
PRODUCTION=172.31.18.39
IP_PUBLIC=''

if [ "$MACHINE" == 'test' ];
 then 
     IP_PUBLIC=TEST
	 echo "Deploying to test "
else 
     IP_PUBLIC=PRODUCTION
	 echo "Deploying to production "
fi

echo "Copying the docker-compose file to the machine"
scp -i "Devops-course.pem"  -o StrictHostKeyChecking=no "$JENKINS_WORKSPACE"/docker-compose.yml ec2-user@$IP_PUBLIC:~

echo "Copying the .ENV file to the machine"
scp -i "Devops-course.pem" -o StrictHostKeyChecking=no "$JENKINS_WORKSPACE"/.env ec2-user@$IP_PUBLIC:~

ssh -i "Devops-course.pem" -o StrictHostKeyChecking=no ec2-user@$IP_PUBLIC "cd /home/ec2-user/&& docker-compose up --no-build -d && sleep 20"

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
