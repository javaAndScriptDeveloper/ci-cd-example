pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t vampir/spring-app:latest .'
            }
        }
        stage('Push') {
            steps {
                sh 'docker login -u $DOCKER_USER -p $DOCKER_PASSWORD && docker push vampir/spring-app:latest'
            }
        }
    }
}