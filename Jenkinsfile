pipeline {

    agent any

    environment {
        MONGODB_HOST = "mongodb"
        MONGODB_PORT = "27017"
        ME_CONFIG_BASICAUTH_ENABLED = true

    }

    stages {

        stage('Building image from Dockerfile.') {

            steps {
                sh 'docker build -t basic_devsecops:v1 .'

            }
        }

        // add security tests before running docker compose

        stage('Running docker compose.') {
          environment {


          }


           steps{
            script {
                withCredentials([
                string(credentialsId: 'mongo-username', variable: 'MONGODB_USER'),
                string(credentialsId: 'mongo-password', variable: 'MONGODB_PASS'),
                string(credentialsId: 'mongoexpress-username', variable: 'ME_CONFIG_BASICAUTH_USERNAME'),
                string(credentialsId: 'mongoexpress-password', variable: 'ME_CONFIG_BASICAUTH_PASSWORD')]) {

                withEnv([
                    "ME_CONFIG_MONGODB_URL: mongodb://${MONGODB_USER}:${MONGODB_PASS}@${MONGODB_HOST}:${MONGODB_PORT}/"
                ])
                 
                 {
                    sh 'docker compose -f docker-compose.yaml up'
                }


                }


                }





                }
                }

        }
    }







}