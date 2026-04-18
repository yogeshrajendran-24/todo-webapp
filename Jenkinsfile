pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "yogeshrajendran/todo-webapp"
        EC2_HOST = "ubuntu@3.86.152.35"
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

        stage('Deploy to Kubernetes') {
            steps{
                sshagent(['ec2-ssh-key']){
                    ssh -o StrictHostkeyChecking=no ${EC2_HOST}sh '''
                        kubectl apply -f deployment.yaml
                        kubectl apply -f service.yaml
                        kubectl apply -f ingress.yaml
                    '''
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
