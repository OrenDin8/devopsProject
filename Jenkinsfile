pipeline {

    agent any

    environment {
        dockerhub_registry = 'orendin8/devops_project'
        dockerhub_credential = credentials('dockerhub')
        dockerImage = ''
        github_credential = '9YvQFinxGdQNZXu8/pmb/G3H0CXrpWFK3D7tzq2sUZs'
        github_url = 'https://github.com/OrenDin8/devopsProject'
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
