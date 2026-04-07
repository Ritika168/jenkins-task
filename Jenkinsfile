pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my-static-website'
        CONTAINER_NAME = 'website-container'
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning source code...'
                git branch: 'main', url: '[github.com](https://github.com/Ritika168/jenkins-task.git)'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .'
                sh 'docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest'
            }
        }

        stage('Deploy Container') {
            steps {
                echo 'Deploying new container...'
                sh '''
                    # Stop and remove existing container if it exists
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true

                    # Run new container
                    docker run -d \
                        --name ${CONTAINER_NAME} \
                        -p 80:80 \
                        ${IMAGE_NAME}:latest

                    echo "Website deployed successfully!"
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully! Website is live.'
        }
        failure {
            echo 'Pipeline failed. Check the logs above.'
        }
    }
}
