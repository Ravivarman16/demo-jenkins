pipeline {
    agent any

    environment {
        USERNAME = credentials('USERNAME')
        USERPWD = credentials('USERPWD')
        USER_DB = credentials('USER_DB')
        USERDBNAME = credentials('USERDBNAME')
        USERDB_PWD = credentials('USERDB_PWD')
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('your_image_name', "--build-arg USERNAME=${USERNAME} --build-arg USERPWD=${USERPWD} --build-arg USER_DB=${USER_DB} --build-arg USERDBNAME=${USERDBNAME} --build-arg USERDB_PWD=${USERDB_PWD} .")
                }
            }
        }
    }
}
