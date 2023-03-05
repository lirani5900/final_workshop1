    agent any
    environment {
        registry = "420493635762.dkr.ecr.us-east-1.amazonaws.com/final-workshop"
    }
    triggers {
        githubPush()
    }
    stages {
        stage('test') {
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
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: '420493635762']]) {
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 420493635762.dkr.ecr.us-east-1.amazonaws.com'
                    sh "docker tag my_image $registry:$BUILD_NUMBER"
                    sh "docker push $registry:$BUILD_NUMBER"
                }
            }
        }
    }

