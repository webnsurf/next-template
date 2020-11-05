pipeline {
    agent any

    stages {
        stage("Initialize") {
            steps {
                buildName " #${BUILD_NUMBER} - ${ENVIRONMENT}"
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker/build.sh'
            }
        }

        stage('Start staging containers') {
            when {
                expression { env.ENVIRONMENT == 'staging' }
            }
            steps {
                sh 'rm -r next_template || true && mkdir next_template'
                sh 'cp docker/start.sh next_template/'
                sh 'cp docker-compose.prod.yml next_template/'
                sh 'cd next_template && ./start.sh'
            }
        }

        stage('Deploy to Production') {
            when {
                expression { env.ENVIRONMENT == 'production' }
            }
            steps {
                sh 'docker/deploy.sh'
            }
        }

        stage('Start production containers') {
            when {
                expression { env.ENVIRONMENT == 'production' }
            }
            steps {
                sh 'docker/start-remote.sh'
            }
        }

        stage('Done!') {
            steps {
                sh 'docker image ls'
            }
        }
    }
}
