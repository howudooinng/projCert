pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t php-ubuntu:18.04 .'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker ps -q --filter "name=php-ubuntu" | xargs -r docker stop
                docker ps -aq --filter "name=php-ubuntu" | xargs -r docker rm
                docker run -d --name php-ubuntu -p 8083:80 php-ubuntu:18.04
                '''
            }
        }
    }

    post {
        failure {
            echo 'Build failed! Cleaning up containers...'
            sh '''
            docker ps -q --filter "name=php-ubuntu" | xargs -r docker stop
            docker ps -aq --filter "name=php-ubuntu" | xargs -r docker rm
            '''
        }
    }
}
