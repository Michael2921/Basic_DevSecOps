pipeline {

    agent any


    environment {
        MONGODB_HOST = "mongodb"
        MONGODB_PORT = "27017"
        GITHUB_TOKEN = credentials('github-token')
        IMAGE_NAME = "michael101/basic-devsecops:v1"


    }


    stages {


        stage('Sonarqube scan') {

            environment {
                scannerHome = tool 'sonarqube-scanner'
            }

                    steps {

                        timeout(time: 2, unit: 'MINUTES') {



                        withSonarQubeEnv(credentialsId: 'sonarqube-creds', installationName: 'Sonarqube-server') { //defined in jenkins > system > name of sonaqube server

                            sh "${scannerHome}/bin/sonar-scanner" // defined in jenkins > tools > name of sonarqube scanner
                        }

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
                sh 'docker build -t ${IMAGE_NAME} .'



            }
        }


        stage('Trivy scan') {

            steps {

               sh 'trivy image --severity HIGH,CRITICAL --exit-code 1 basic_devsecops:v1'


            }

        }


        stage('Docker login and push to repo') {
            steps {
                script {
                    echo "Logging in to docker"
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh 'echo $PASS | docker login -u $USER --password-stdin'
                        sh 'echo "Pushing secure image to repo"'
                        sh "docker push ${IMAGE_NAME}"

                  }

                }

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
//                    sh 'docker compose down -v'
//
//                }
//
//
//                }
//
//
//                }


//                }


//        stage('Push secure code to master branch'){
//            when {
//                not {
//                    branch 'master'
//                }
//            }
//
//            steps {
//                   script {
//                        sh 'echo "Pushing code to master branch"'
//                        sh 'git config user.email "jenkins@example.com"'
//                        sh 'git config user.name "jenkins"'
//                        sh 'git status'
//                        sh 'git branch'
//                        sh 'git remote set-url origin https://${GITHUB_TOKEN}@github.com/Michael2921/Basic_DevSecOps.git'
//                        sh 'git add .'
//                        sh 'git commit -m "pushing secure code to master branch"'
//                        sh 'git push -f origin HEAD:master'
//
//
//                   }
//
//            }
//
//        }
//
        stage('Deploying image to EC2'){

            steps {
                script {
                    def shellCmd = "bash ./commands.sh ${IMAGE_NAME}"
                    def ec2Instance = "ec2-user@18.191.154.151"

                    sshagent(['basic-devsecops-ssh']) {
                        sh "scp -o StrictHostKeyChecking=no commands.sh docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"

                    }
                }

            }
        }



                }

        }
