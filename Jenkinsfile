pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t calculator-app:1.0 .'
            }
        }
        stage('Run') {
            steps {
                sh 'docker run -d --name calculator-container calculator-app:1.0'
            }
        }
    }
}
