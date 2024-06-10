pipeline {
    agent any

    environment {
        USERNAME = credentials('admin-username')
        USERPWD = credentials('keycloakadmin-pass')
        USER_DB = credentials('db-url')
        USERDBNAME = credentials('db-user')
        USERDB_PWD = credentials('db-pass')
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
