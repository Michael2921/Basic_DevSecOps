pipeline {

    agent any


    environment {
        MONGODB_HOST = "mongodb"
        MONGODB_PORT = "27017"
        GITHUB_TOKEN = credentials('github-token')


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

               sh 'trivy image --severity HIGH,CRITICAL --exit-code 1 basic_devsecops:v1'


            }

        }







//        stage('Running docker compose.') {
//
//           steps{
//
//            script {
//                withCredentials([
//                    usernamePassword(
//                    credentialsId: 'mongodb-creds',
//                    usernameVariable: 'MONGO_INITDB_ROOT_USERNAME',
//                    passwordVariable: 'MONGO_INITDB_ROOT_PASSWORD')
//               ])
//               {
//                    sh 'docker compose down -v'
//                    sh 'docker compose -f docker-compose.yaml up -d'
//
//                }
//
//
//                }
//
//
//                }
//
//
//                }


        stage('Push secure code to master branch'){
            when {
                not {
                    branch 'master'
                }
            }

            steps {
                   script {
                        sh 'echo "Pushing code to master branch"'
                        sh 'git config user.email "jenkins@example.com"'
                        sh 'git config user.name "jenkins"'
                        sh 'git status'
                        sh 'git branch'
                        sh 'git remote set-url origin https://${GITHUB_TOKEN}@github.com/Michael2921/Basic_DevSecOps.git'
                        sh 'git add .'
                        sh 'git commit -m "pushing secure code to master branch"'
                        sh 'git push origin HEAD:master'


                   }

            }

        }



                }

        }
