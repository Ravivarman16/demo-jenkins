pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    withCredentials([
                        usernamePassword(credentialsId: 'admin-username', usernameVariable: 'USERNAME', passwordVariable: 'USERPWD'),
                        string(credentialsId: 'db-url', variable: 'USER_DB'),
                        string(credentialsId: 'db-user', variable: 'USERDBNAME'),
                        string(credentialsId: 'db-pass', variable: 'USERDB_PWD')
                    ]) {
                        docker.build('your_image_name', """
                            --build-arg USERNAME=${env.USERNAME} \
                            --build-arg USERPWD=${env.USERPWD} \
                            --build-arg USER_DB=${env.USER_DB} \
                            --build-arg USERDBNAME=${env.USERDBNAME} \
                            --build-arg USERDB_PWD=${env.USERDB_PWD} .
                        """)
                    }
                }
            }
        }
    }
}
