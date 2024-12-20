pipeline {
    agent any  // Runs on any available agent

    environment {
        DOCKER_IMAGE = 'my-httpd-server'
        DOCKER_TAG = 'latest'
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_USER = 'sibisam2301'  // Your Docker Hub username
        DOCKER_CREDENTIALS_ID = 'docker-credentials-id'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                script {
                    checkout scmGit(
                        branches: [[name: '*/main']], 
                        extensions: [], 
                        userRemoteConfigs: [[credentialsId: 'docker-credentials-id', url: 'https://github.com/sibilucky/declarative-pipeline.git']]
                    )
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker Image...'
                    sh "docker build -t docker.io/sibisam2301/my-httpd-server:latest ."
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo 'Deploying Docker container...'
                    sh "docker run -d --name httpd-container -p 7070:80 docker.io/sibisam2301/my-httpd-server:latest"
                }
            }
        }

        stage('Push to Docker Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'sibisam2301@gmail.com', passwordVariable: 'devika@123')]) {
                    script {
                        echo 'Pushing Docker image to registry...'
                        sh """
                            echo devika@123 | docker login -u sibisam2301@gmail.com --password-stdin
                            docker push docker.io/sibisam2301/my-httpd-server:latest
                        """
                    }
                }
            }
        }
    }
 post {
        success {
            echo 'Pipeline executed successfully!'
        }

        failure {
            echo 'Pipeline failed. Please check the logs.'
        }

        always {
            // Cleanup - stop and remove the Docker container if it exists
            echo 'Cleaning up Docker container...'
            sh 'docker rm -f httpd-container || true'
        }
    }
}
   
