pipeline {
  agent {
    label 'docker-agent-maven-17'
  }
  environment {
    DOCKER_ACCESS = credentials("DOCKER_ACCESS_PERMISSIONS_CREDENTIALS")
  }
  stages {
    stage('Dependency') {
      steps {
        sh 'mvn dependency:resolve'
      }
    }
    stage('Test') {
      steps {
        sh 'mvn test'
      }
    }
    stage('Build App') {
      steps {
         sh "mvn package"
         }
      }
    stage('Release App') {
      steps {
        script {
          env.IMAGE_NAME = sh(script: 'echo repoprivate:first', returnStdout: true).trim()
        }
        sh 'chmod +x ci-cd/build_&_release'
        sh 'bash ci-cd/build_&_release'
      }
    }
    stage('Deploy App') {
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
