pipeline {

    agent any

    environment {
        MONGODB_HOST = "mongodb"
        MONGODB_PORT = "27017"

    }

    stages {

//        stage('Cloning from Git repository') {
//            steps {
//                git 'https://github.com/Michael2921/Basic_DevSecOps.git'
//            }
//        }

        // add security tests before running docker compose

        stage('Running docker compose') {
            steps {
                sh 'docker compose -f docker-compose.yaml up'
            }

        }
    }







}