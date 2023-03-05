pipeline {
    agent any
    environment {
        registry = "420493635762.dkr.ecr.us-east-1.amazonaws.com/final-workshop"
    }
    stages {
        stage('test') {
            steps {
                echo "hello"
            }
        }
         stage('Build Docker Image') {
            steps {
                echo 'sudo docker build -t my_image .'
            }
        }
        stage('Push Docker Image to ECR') {
            steps {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 420493635762.dkr.ecr.us-east-1.amazonaws.com'
                echo '$(aws ecr get-login --no-include-email --region us-east-1)'
                sh 'docker tag my_image 420493635762.dkr.ecr.us-east-1.amazonaws.com/final-workshop:$BUILD_NUMBER'
                sh 'docker push 420493635762.dkr.ecr.us-east-1.amazonaws.com/final-workshop:$BUILD_NUMBER'
            }
        }
    }
}
