pipeline {
    agent any

    stages {

        stage('Install Ansible if missing') {
            steps {
                sh '''
                ansible --version || (
                    sudo apt update &&
                    sudo apt install -y ansible
                )
                '''
            }
        }

        stage('Install Docker on Test Server') {
            steps {
                sh 'ansible-playbook ansible/install_docker.yml -i ansible/hosts'
            }
        }

        stage('Deploy PHP App') {
            steps {
                sh 'ansible-playbook ansible/deploy_php_app.yml -i ansible/hosts'
            }
        }

        stage('Cleanup on Failure') {
            when {
                expression { currentBuild.currentResult == 'FAILURE' }
            }
            steps {
                sh '''
                ansible test -i ansible/hosts -m docker_container \
                  -a "name=phpapp state=absent" || true
                '''
            }
        }
    }
}
