pipeline {

    agent any

    environment {
        MONGODB_HOST = "mongodb"
        MONGODB_PORT = "27017"
       // ME_CONFIG_BASICAUTH_ENABLED = true

    }

    stages {

        stage('Building image from Dockerfile.') {

            steps {
                sh 'docker build -t basic_devsecops:v1 .'
                sh 'docker compose -f docker-compose.yaml down'


            }
        }

        // add security tests before running docker compose

        stage('Running docker compose.') {

           steps{

            script {
                withCredentials([
                    usernamePassword(
                    credentialsId: 'mongodb-creds',
                    usernameVariable: 'MONGO_INITDB_ROOT_USERNAME',
                    passwordVariable: 'MONGO_INITDB_ROOT_PASSWORD')
               ])
                {


                withEnv([
                    "ME_CONFIG_MONGODB_URL=mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@${MONGODB_HOST}:${MONGODB_PORT}/"
                ])

                 {

                    sh "Username is $MONGO_INITDB_ROOT_USERNAME"
                    sh "Password is $MONGO_INITDB_ROOT_PASSWORD"
                   // sh 'docker compose -f docker-compose.yaml down'
                    //sh 'docker compose -f docker-compose.yaml up'
                }


                }


                }





                }
                }

        }
    }
