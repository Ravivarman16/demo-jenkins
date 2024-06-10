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
                    
                    // Set keycloak_admin to the value of USERNAME
                    def keycloak_admin = env.USERNAME

                    // Build the Docker image with build arguments
                    docker.build('your_image_name', "--build-arg USERNAME=${username} --build-arg USERPWD=${userpwd} --build-arg USER_DB=${user_db} --build-arg USERDBNAME=${userdbname} --build-arg USERDB_PWD=${userdb_pwd} --build-arg KEYCLOAK_ADMIN=${keycloak_admin} --build-arg KEYCLOAK_ADMIN_PASSWORD=${keycloak_admin_password} --build-arg KC_DB_URL=${kc_db_url} --build-arg KC_DB_USERNAME=${kc_db_username} --build-arg KC_DB_PASSWORD=${kc_db_password} .")
                }
            }
        }
    }
}
