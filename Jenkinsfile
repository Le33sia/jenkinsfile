pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'gogsimage'
        DOCKER_IMAGE_TAG = 'latest'
        SERVER_IP = '10.0.0.50'
        REMOTE_DIRECTORY = '~'
    }
    stages {
        stage('Cleanup') {
            steps {
                sh 'docker system prune -a --volumes -f'
            }
        }

        stage('Building Gogs Image') {
            steps {
                sh 'docker build -t gogsimage .'
                sleep 15
                sh 'docker images'
                sh 'docker compose build'
                sh 'docker compose down -v --remove-orphans'
            }
        }
        stage('Run Tests') {
            
            steps {
                //sh 'go vet ./...'
                //sh 'go test ./...'
                echo "Testing"
            }
        }
        stage('Deploy to Ubuntu_Server') {
            steps {
                sh 'docker save -o gogsimage.tar gogsimage:latest'  
                sh 'scp gogsimage.tar jenkins@10.0.0.50:~'
                sh 'scp docker-compose.yml jenkins@10.0.0.50:~'
                sh '''
                ssh jenkins@10.0.0.50 "docker load -i /home/jenkins/gogsimage.tar && cd /home/jenkins/ && docker compose up -d"
                '''
            
            }
        }
    }
}        

    
