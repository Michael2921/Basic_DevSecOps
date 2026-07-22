pipeline {

    agent any

    environment {
        MONGODB_HOST = "mongodb"
        MONGODB_PORT = "27017"

    }

    stages {

        stage('Building image from Dockerfile.') {

            steps {
                sh 'docker build -t basic_devsecops:v1 .'

            }
        }

        // add security tests before running docker compose

        stage('Running docker compose.') {
            script {
                withCredentials([
                string(credentialsId: 'mongo-username', variable: 'MONGODB_USER'),
                string(credentialsId: 'mongo-password', variable: 'MONGODB_PASS')]) {

                sh 'docker compose -f docker-compose.yaml down'
                sh 'docker compose -f docker-compose.yaml up'


                }


                }

        }
    }







}