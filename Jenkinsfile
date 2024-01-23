pipeline {
    agent {
        label 'docker-agent-maven-17'
    }
    environment {
        DATE = new Date().format('yy.M')
        TAG = "${DATE}.${BUILD_NUMBER}"
    }
    stages {
        stage ('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    docker.build("aniscoprog/repoprivate:${TAG}")
                }
            }
        }
	    stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    docker.withRegistry('https://hub.docker.com/', 'DOCKER_REGISTRY_CREDENTIALS'){
                        docker.image("aniscoprog/repoprivate:${TAG}").push()
                        docker.image("aniscoprog/repoprivate:${TAG}").push("latest")
                    }
                }
            }
        }
        stage('Deploy'){
            steps {
                sh "docker stop repoprivate | true"
                sh "docker rm repoprivate | true"
                sh "docker run --name repoprivate -d -p 9004:8080 aniscoprog/repoprivate:${TAG}"
            }
        }
    }
}