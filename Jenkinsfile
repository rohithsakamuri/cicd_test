pipeline {
    agent { label 'pipeline-test' }
    stages {
        stage('build') {
            steps {
                sh '''
                echo "test PR"
                '''
            }
        }
    }
}

