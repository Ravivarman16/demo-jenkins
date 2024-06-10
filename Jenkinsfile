pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Retrieve environmental variables from Jenkins global properties
                    def username = env.USERNAME
                    def userpwd = env.USERPWD
                    def user_db = env.USER_DB
                    def userdbname = env.USERDBNAME // Using USERDBNAME from global properties
                    def userdb_pwd = env.USERDB_PWD
                    // Build the Docker image with build arguments
                    docker.build('your_image_name', "--build-arg USERNAME=${username} --build-arg USERPWD=${userpwd} --build-arg USER_DB=${user_db} --build-arg USERDBNAME=${userdbname} --build-arg USERDB_PWD=${userdb_pwd} .")
                }
            }
        }
    }
}
