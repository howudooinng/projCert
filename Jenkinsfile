pipeline {
    agent {
        docker {
            image 'docker:26-cli'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

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
}
