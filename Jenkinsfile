pipeline {
    agent any

    environment {
        // Change these if you want different names for your image or container
        IMAGE_NAME = 'my-static-website'
        CONTAINER_NAME = 'website-container'
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning source code from GitHub...'
                // Ensure the branch name matches your GitHub default (usually 'main')
                git branch: 'main', url: 'https://github.com/Ritika168/jenkins-task.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image version ${env.BUILD_NUMBER}..."
                // Using double quotes so Jenkins can inject the environment variables
                sh "docker build -t ${env.IMAGE_NAME}:${env.BUILD_NUMBER} ."
                sh "docker tag ${env.IMAGE_NAME}:${env.BUILD_NUMBER} ${env.IMAGE_NAME}:latest"
            }
        }

        stage('Deploy Container') {
            steps {
                echo 'Deploying new container to Port 80...'
                script {
                    // Stop and remove the old container if it exists, ignore errors if it doesn't
                    sh "docker stop ${env.CONTAINER_NAME} || true"
                    sh "docker rm ${env.CONTAINER_NAME} || true"

                    // Run the fresh container
                    sh "docker run -d --name ${env.CONTAINER_NAME} -p 80:80 ${env.IMAGE_NAME}:latest"
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully! Your website is now live.'
        }
        failure {
            echo 'Pipeline failed. Check the Console Output to see what went wrong.'
        }
    }
}
