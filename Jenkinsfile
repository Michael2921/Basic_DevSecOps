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
        when {branch 'dev'}

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
        when {branch 'dev'}

                steps {

                        timeout(time: 2, unit: 'MINUTES') {
                            waitForQualityGate abortPipeline: true
                        }


                }

            }


        stage('Building image from Dockerfile.') {
        when {branch 'dev'}

            steps {
                sh 'docker build --no-cache -t ${IMAGE_NAME} .'



            }
        }


        stage('Trivy scan') {
        when {branch 'dev'}

            steps {

               sh 'trivy image --severity HIGH,CRITICAL --format table -o trivy-report.txt --exit-code 1 basic_devsecops:v1'
               sh 'cat trivy-report.txt'


            }

        }

        //When security scans pass, secure code is pushed to master, then secure code is pushed from master to private Docker repo and deployed to EC2


                stage('Push secure code to master branch'){
                when {branch 'dev'} //master doesn't push to itself avoiding a build loop. work isn't done from master. only pushed from dev when security scans pass

                    steps {
                           script {
                                sh 'echo "Pushing code to master branch"'
                                sh 'git config user.email "jenkins@example.com"'
                                sh 'git config user.name "jenkins"'
                                sh 'git status'
                                sh 'git branch'
                                sh 'git remote set-url origin https://${GITHUB_TOKEN}@github.com/Michael2921/Basic_DevSecOps.git'
                                sh 'git pull'
                                sh 'git add .'
                                sh 'git commit -m "pushing secure code to master branch"'
                                sh 'git push origin HEAD:master'


                           }

                    }

        }


        stage('Docker login and push to repo') {
        when {branch 'master'}

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



        stage('Deploying image to EC2'){
        when {branch 'master'} //deploys from master

            steps {
                script {
                    withCredentials([
                        usernamePassword(
                    credentialsId: 'mongodb-creds',
                    usernameVariable: 'MONGO_INITDB_ROOT_USERNAME',
                    passwordVariable: 'MONGO_INITDB_ROOT_PASSWORD'),
                        usernamePassword(
                        credentialsId: 'docker-hub-repo',
                        usernameVariable: 'USER',
                        passwordVariable: 'PASS'),

                        string(credentialsId: 'ec2-instance', variable: 'EC2_INSTANCE')

                    ]) {

                    def shellCmd = "bash ./commands.sh ${IMAGE_NAME}"
                    def ec2Instance = "ec2-user@${EC2_INSTANCE}"

                    sshagent(['basic-devsecops-ssh']) { //variables are set in the ssh command and a shell script containing commands to login to docker repo and deploy is executed
                        sh "scp -o StrictHostKeyChecking=no commands.sh docker-compose.yaml ${ec2Instance}:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} MONGO_INITDB_ROOT_USERNAME='${MONGO_INITDB_ROOT_USERNAME}' MONGO_INITDB_ROOT_PASSWORD='${MONGO_INITDB_ROOT_PASSWORD}' \
                        MONGODB_HOST='${MONGODB_HOST}' MONGODB_PORT='${MONGODB_PORT}' USER=${USER} PASS=${PASS} \
                        ${shellCmd}"

                    }

                    }
                }

            }
        }



                }

        }
