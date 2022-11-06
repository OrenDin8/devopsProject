pipeline {

    agent any

    environment {
        dockerhub_registry = ''
        dockerhub_credential = credentials('dockerhub')
        dockerImage = ''
        github_credential = ''
        github_url = 'https://github.com/OrenDin8/devopsProject'
        test_cerdentials = 'jenkins-ec2-server-credentials'
        prod_cerdentials = ''
    }
    stages {
        stage('Build Image') {
            steps {
                script {
                    dockerImage = docker.build dockerhub_registry + ":latest"
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
        stage('Pull from dockerHub') {
            steps {
               script {
                    docker.withRegistry( '', dockerHubRegistryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Test') {
            steps {
                sshagent(credentials: [test_cerdentials]) {
                    sh """
                        echo 'test server in action'
                        ssh -o StrictHostKeyChecking=no -i /home/ec2-user/.ssh/jenkins-git
                        bash -x deploy.sh test
                        """
                    }
                }
            }
        stage ('Production') {
	        steps {
	        	sh './deploy.sh'
            }
	    }
      
 }
