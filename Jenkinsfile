pipeline {
    agent {
        label 'docker-agent-maven-17'
    }
    environment {
        DOCKER_REGISTRY_CREDENTIALS = credentials('DOCKER_REGISTRY_CREDENTIALS')
    }
    stages {
        stage('Build') {
            agent any
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Build') {
            agent any
            steps {
                script {
                    docker.build("aniscoprog/repoprivate:${TAG}")
                }
            }
        }
        stage('Pushing Docker Image to Dockerhub') {
            agent any
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com/v2/', 'DOCKER_REGISTRY_CREDENTIALS') {
                        docker.image("aniscoprog/repoprivate:${TAG}").push()
                        docker.image("aniscoprog/repoprivate:${TAG}").push("latest")
                    }
                }
            }
        }
        stage('Deploy') {
            agent any
            steps {
                sshagent(credentials: ['VAGRANT_SSH_CREDENTIALS']) {
                    sh 'chmod +x ci-cd/deploy'
                    sh 'bash ci-cd/deploy'
                }
            }
        }
    }
}
