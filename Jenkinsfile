pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "yogeshrajendran/todo-webapp:${BUILD_NUMBER}"
    }

    tools {
        sonarQubeScanner 'sonar-scanner'
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/yogeshrajendran-24/todo-webapp.git'
            }
        }

        stage('Test') {
            steps {
                sh 'chmod +x test.sh'
                sh './test.sh'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'sonar-scanner'
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker run -d -p 8081:80 $DOCKER_IMAGE'
            }
        }
    }
}
