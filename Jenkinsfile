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
                -Dsonar.sources=.
                """
            }
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
        sh '''
        echo "Stopping old container if it exists..."
        docker stop todo-app || true
        docker rm todo-app || true

        echo "Deploying new container..."
        docker run -d \
          --name todo-app \
          -p 8081:80 \
          $DOCKER_IMAGE
        '''
            }
        }
    }
}
