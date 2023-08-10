pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/P-priyanka/DevOps_Jenkins'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def buildId = env.BUILD_ID
                    def imageName = "web_app_image:${buildId}"
                    def dockerfile = 'Dockerfile'

                    def dockerImage = docker.build(imageName, "-f ${dockerfile} .")
                    env.IMAGE_NAME = imageName
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            environment {
                DOCKER_HUB_USERNAME = 'pkboo'
                DOCKER_HUB_REPOSITORY = 'web_app_image'
                DOCKER_HUB_PASSWORD = 'Priyanka1@'
            }
            steps {
                script {
                    def buildId = env.BUILD_ID
                    def imageFullName = "${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:${buildId}"
                    def latestImage = "${DOCKER_HUB_USERNAME}/${DOCKER_HUB_REPOSITORY}:latest"

                    sh "docker tag ${env.IMAGE_NAME} ${imageFullName}"
                    sh "docker tag ${env.IMAGE_NAME} ${latestImage}"
                }

                sh "docker login -u ${DOCKER_HUB_USERNAME} -p ${DOCKER_HUB_PASSWORD}"
                sh "docker push ${imageFullName}"
                sh "docker push ${latestImage}"
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run -p 8000:80 -d --name web_app_container ${env.IMAGE_NAME}"
                }
            }
        }
    }
}
