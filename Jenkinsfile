pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('420493635762').AWS_ACCESS_KEY_ID
        AWS_SECRET_ACCESS_KEY = credentials('420493635762').AWS_SECRET_ACCESS_KEY
        AWS_DEFAULT_REGION = 'us-east-1'
    }
    stages {
        stage('Install Docker') {
            steps {
                echo "hello"
            }
        }
         stage('Build Docker Image') {
            steps {
                sh 'sudo docker build -t my_image .'
            }
        }
        stage('Push Docker Image to ECR') {
            steps {
                sh '$(aws ecr get-login --no-include-email --region us-east-1)'
                sh 'docker tag my_image 420493635762.dkr.ecr.us-east-1.amazonaws.com/final-workshop:$BUILD_NUMBER'
                sh 'docker push 420493635762.dkr.ecr.us-east-1.amazonaws.com/final-workshop:$BUILD_NUMBER'
            }
        }
    }
}
