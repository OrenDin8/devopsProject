pipeline {

    agent any

    environment {
        dockerhub_registry = "orendin8/devops_project"
        dockerhub_credential = 'dockerhub'
        dockerImage = ''
        github_credential = "9YvQFinxGdQNZXu8/pmb/G3H0CXrpWFK3D7tzq2sUZs"
        github_url = "https://github.com/OrenDin8/devopsProject"
	test_cerdentials = "jenkins-ec2-server-credentials"

    }
    stages {
        stage('Build Image') {
            steps {
                script {
                    dockerImage = docker.build dockerhub_registry + ":latest"
		    sh ''' docker-compose up -d --build 
		    sleep 15
	            HTTP_STATUS=`curl -o /dev/null -s -w "%{http_code}\n" http://localhost:5000/`
		    docker-compose down 
		    if [ $HTTP_STATUS -eq 200 ];
		      then
		      		echo "TEST: SUCCES"
		      else
				echo "TEST: FAIL"
				exit 1
		      fi
                }
            }
        }
	stage('Test') {
            steps {
                sshagent() {
                    sh """
                        echo 'Test stage ...'
                        bash -x deploy.sh test
                        """
                }
            }
        }
        stage('Push to dockerhub') {
            steps {
               script {
                    docker.withRegistry( '', dockerhub_credential) {
                        dockerImage.push()
                    }
                }
            }
        }
   
        stage ('Production') {
	    steps {
	    	sh """
                     echo 'Prodaction stage ...'
                     bash -x deploy.sh test
                   """
            }
        }
    }
 }
