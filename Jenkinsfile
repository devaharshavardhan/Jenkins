pipeline {
    agent {
        docker { image 'python:3.9-slim' }
    }
    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/devaharshavardhan/Jenkins', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t calculator-app:1.0 .'
            }
        }
        stage('Run') {
            steps {
                sh 'docker run calculator-app:1.0'
            }
        }
    }
}
