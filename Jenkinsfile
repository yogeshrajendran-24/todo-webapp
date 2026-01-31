pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "yogeshrajendran/todo-webapp:${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
    steps {
        git branch: 'main',
                url: 'https://github.com/yogeshrajendran-24/todo-webapp.git'
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
        script {
            def scannerHome = tool 'sonar-scanner'
            withSonarQubeEnv('sonarqube') {
                sh """
                ${scannerHome}/bin/sonar-scanner \
                -Dsonar.projectKey=todo-app \
                -Dsonar.sources=. \
                -Dsonar.login=$SONAR_AUTH_TOKEN
                """
            }
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
