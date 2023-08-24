pipeline {
    agent any

     stages {
        stage('Start SSH Agent') {
            steps {
                sshagent(['cred_docker']) {
                    
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh 'docker system prune -a --volumes -f'
            }
        }

        stage('Run Docker Compose') {
            steps {
                sh 'docker-compose up -d'
                sleep 15
                sh 'docker ps'
                sh 'docker-compose down -v --remove-orphans'
                sh 'docker images'
                
            }
        }
        
        stage('Deploy to Ubuntu_Server') {
            steps {
                script {
                    sshagent(['cred_docker']) {
                       
                        sh 'scp mymariadb-image.tar mygogs-image.tar git@10.0.0.35:/home/git/workspace/'
                    }  
                    sshagent(['cred_docker']) {
                        sh 'scp docker-compose.yml git@10.0.0.35:/home/git/workspace/'
                    }
                    
                    sshagent(['cred_docker']) {
                        sh 'ssh git@10.0.0.35 "cd /home/git/workspace/ && docker load -i mymariadb-image.tar && docker load -i mygogs-image.tar && docker-compose up -d"'
                    }
                }
            }
        }
    }
}   
