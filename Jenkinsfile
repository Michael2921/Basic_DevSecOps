pipeline {

    agent any

    environment {
        MONGODB_HOST = "mongodb"
        MONGODB_PORT = "27017"

    }

    stages {

        stage('Building image from Dockerfile') {
            steps {
                script {
                withCredentials([
                string(credentialsId: 'mongo-username', variable: 'MONGODB_USER'),
                string(credentialsId: 'mongo-password', variable: 'MONGODB_PASS')]) {

                sh 'docker compose -f docker-compose.yaml up'


                }


                }
            }
        }

        // add security tests before running docker compose

        stage('Running docker compose') {
            steps {
                sh 'docker compose -f docker-compose.yaml up'
            }

        }
    }







}