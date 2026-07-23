pipeline {

    agent any

    environment {
        MONGODB_HOST = "mongodb"
        MONGODB_PORT = "27017"


    }





    stages {


        stage('Sonaqube scan') {

                    steps {

                        withSonarQubeEnv('Sonarqube-server') {

                            sh 'sonar-scanner'
                        }
                    }





        }


        stage('Quality gate') {

                steps {

                        echo "Quality gate goes here"


                }

            }


        stage('Building image from Dockerfile.') {

            steps {
                sh 'docker build -t basic_devsecops:v1 .'



            }
        }

        stage('Trivy scan') {

            steps {

               sh 'trivy --version'
               sh 'trivy image --severity HIGH,CRITICAL basic_devsecops:v1'


            }

        }




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
                    sh 'docker compose down -v'
                    sh 'docker compose -f docker-compose.yaml up'

                }


                }


                }


                }
                }

        }
