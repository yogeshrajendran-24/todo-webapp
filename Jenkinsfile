pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "yogeshrajendran/todo-webapp"
        EC2_HOST = "ubuntu@98.94.151.180"
    }
    
       stages{
        stage('Checkout Code'){
            steps{
                git branch: "main", url: "https://github.com/yogeshrajendran-24/todo-webapp.git"
            }
        }

        stage('Build Docker Image'){
            steps{
                script{
                    dockerImage = docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push Image to DockerHub'){
            steps{
                script{
                    docker.withRegistry('', 'todo-webapp-creds') {
                    dockerImage.push("${BUILD_NUMBER}")
                    dockerImage.push("latest")
                     }
                }
             }
        }

        stage('Deploy to EC2'){
            steps{
                sshagent(['ec2-user-key']){
                    sh """
                    ssh -o StrictHostkeyChecking=no ${EC2_HOST} "
                       docker pull ${DOCKER_IMAGE}:latest &&
                        docker stop todo-webapp || true &&
                        docker rm todo-webapp || true &&
                        docker run -d -p 80:80 --name todo-webapp ${DOCKER_IMAGE}:latest 
                        "
                        """
                }

            }

        }
    }


    post{
        always{
            sh 'echo "Pipeline finished!"'
        }

        success{
            sh 'echo "Build Successful!!!"'
        }

        failure{
            sh 'echo "Build failed, Sending Notification...."'
        }
    }
}