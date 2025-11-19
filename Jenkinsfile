pipeline {
    agent any

    stages {
        stage('clone') {
            steps {
                git branch: 'main', url: 'https://github.com/srhardikpatel/djangodemo.git'    
            }
        }
        
        stage('build') {
            steps {
               sh 'docker build -t erhardikfreelancer/djangodemo:${BUILD_NUMBER} .'
            }
        }
        
        stage('push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push erhardikfreelancer/djangodemo:${BUILD_NUMBER}
                    '''
                }
            }
        }

        stage('Update deployment file') {
            environment {
                SERVICE_CREDS = credentials('github')
            }
            steps {
                sh 'echo "Service user is $SERVICE_CREDS_USR"'
                sh 'echo "Service password is $SERVICE_CREDS_PSW"'
                sh 'curl -u $SERVICE_CREDS https://${GITHUB_TOKEN}@github.com/$SERVICE_CREDS_USR/djangodemo'
            }
        
/*            environment {
                GIT_REPO_NAME = "djangodemo"
                GIT_USER_NAME = "srhardikpatel"
            }
            
            steps {
                 withCredentials([usernamePassword(credentialsId: 'github', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD')]) {

                     git log
                     sh '''
                        sed  s/replaceImageTag/${BUILD_NUMBER}/g deployment/deployment.yml
                        git config user.email srhardikpatel@gmail.com
                        git config user.name srhardikpatel
                        git add deployment/deployment.yml
                        git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                        def encodedPassword = URLEncoder.encode("$GIT_PASSWORD",'UTF-8')
                        git push https://${GIT_USERNAME}:${encodedPassword}@github.com/${GIT_USERNAME}/djangodemo.git"
                        ''' 
                 }
            }*/
        }
    }
}
