pipeline {
    agent any

    stages {
        stage('clone') {
            steps {
                git branch: 'main', url: 'https://github.com/srhardikpatel/djangodemo.git'    
            }
        }
/*        
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
*/
        stage('Update deployment file') {
        
            environment {
                GIT_REPO_NAME = "djangodemo"
                GIT_USER_NAME = "srhardikpatel"
            }
            
            steps {
                 withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                     TAG_TO_REPLACE= sh 'awk /djangodemo:/{print $2} deployment/deployment.yml'
                     sh '''
                        git config user.email "srhardikpatel@gmail.com"
                        git config user.name "srhardikpatel"
                        
                        echo ${TAG_TO_REPLACE}
/*                        sed -i '' "s/replaceImageTag/${BUILD_NUMBER}/g" deployment/deployment.yml
                        git add deployment/deployment.yml
                        git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                        git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}.git HEAD:main
*/
                        '''
                 }
            }
        }
    }
}
