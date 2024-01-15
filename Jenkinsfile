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
   }
   stages {
       stage ('Build') {
         steps {
           sh 'mvn package'
           }
      }
   }
}
