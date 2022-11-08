pipeline {

    agent any

    environment {
        dockerhub_registry = "orendin8/devops_project"
        dockerhub_credential = 'dockerhub'
        dockerImage = ''
        github_credential = "9YvQFinxGdQNZXu8/pmb/G3H0CXrpWFK3D7tzq2sUZs"
        github_url = "https://github.com/OrenDin8/devopsProject"
	credatinal_test_stage = "jenkins_host_root"

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
   	stage('Test') {
            steps {  
                sshagent(credentials:['jenkins_host_root']) {
                     sh """
                        echo 'Test stage ...'
                        bash -x deploy.sh test
                        """.stripIndent()
		}
            }
        }
        stage ('Production') {
	    steps {
	    	 sh """
                     echo 'Production stage ...'
                     bash -x deploy.sh prod
                   """.stripIndent()
            }
        }
    }
 }
