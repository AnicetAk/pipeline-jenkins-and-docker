pipeline {
  agent {
    label 'docker-agent-maven-17'
  }
   stages {
     stage('test') {
       steps {
          sh 'mvn test'
       }
     }
      stage ('Build') {
        steps {
           sh 'mvn package'
        }
      }
   }
}
