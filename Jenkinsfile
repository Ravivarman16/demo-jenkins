pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    withCredentials([
                        string(credentialsId: 'USERNAME', variable: 'USERNAME'),
                        string(credentialsId: 'USERPWD', variable: 'USERPWD'),
                        string(credentialsId: 'USER_DB', variable: 'USER_DB'),
                        string(credentialsId: 'USERDBNAME', variable: 'USERDBNAME'),
                        string(credentialsId: 'USERDB_PWD', variable: 'USERDB_PWD')
                    ]) {
                        docker.build('your_image_name', """
                            --build-arg USERNAME=${USERNAME} \
                            --build-arg USERPWD=${USERPWD} \
                            --build-arg USER_DB=${USER_DB} \
                            --build-arg USERDBNAME=${USERDBNAME} \
                            --build-arg USERDB_PWD=${USERDB_PWD} .
                        """)
                    }
                }
            }
        }
    }
}
