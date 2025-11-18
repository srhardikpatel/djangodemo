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
            steps {
                 withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                     sh '''
                         sed -i "/replaceImageTag/${BUILD_NUMBER}" deployment/deployment.yml
                        '''
                 }
            }
        }
    }
}
