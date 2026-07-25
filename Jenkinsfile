pipeline {

    agent any


    environment {
        MONGODB_HOST = "mongodb"
        MONGODB_PORT = "27017"


    }


    stages {


        stage('Sonarqube scan') {

            environment {
                scannerHome = tool 'sonarqube-scanner'
            }

                    steps {



                        withSonarQubeEnv(credentialsId: 'sonarqube-creds', installationName: 'Sonarqube-server') { //defined in jenkins > system > name of sonaqube server

                            sh "${scannerHome}/bin/sonar-scanner" // defined in jenkins > tools > name of sonarqube scanner
                        }

                    }





        }


        stage('Sonarqube quality gate') {

                steps {

                        timeout(time: 2, unit: 'MINUTES') {
                            waitForQualityGate abortPipeline: true
                        }


                }

            }


        stage('Building image from Dockerfile.') {

            steps {
                sh 'docker build -t basic_devsecops:v1 .'



            }
        }


        stage('Trivy scan') {

            steps {

               sh 'trivy image --severity HIGH,CRITICAL basic_devsecops:v1'


            }

        }


        stage('Deploying image') {

            steps {

               sh 'whoami'


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
                    sh 'docker compose -f docker-compose.yaml up -d'

                }


                }


                }


                }
                }

        }
