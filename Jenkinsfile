pipeline {
    agent any

    environment {
        KEYCLOAK_ADMIN_CREDENTIALS = credentials('keycloak-admin-credentials')
        KC_DB_CREDENTIALS = credentials('kc-db-credentials')
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Extracting username and password from credentials
                    def keycloakAdminUsername = credentials('keycloak-admin-credentials').username
                    def keycloakAdminPassword = credentials('keycloak-admin-credentials').password
                    def kcDbUsername = credentials('kc-db-credentials').username
                    def kcDbPassword = credentials('kc-db-credentials').password
                    
                    // Building Docker image with build arguments for credentials
                    sh "docker build -t demo \
                         --build-arg KEYCLOAK_ADMIN=${keycloakAdminUsername} \
                         --build-arg KEYCLOAK_ADMIN_PASSWORD=${keycloakAdminPassword} \
                         --build-arg KC_DB_USERNAME=${kcDbUsername} \
                         --build-arg KC_DB_PASSWORD=${kcDbPassword} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker stop key"
                    sh "docker rm key"
                    sh "docker run -d -it --name key -p 8080:8080 -p 8443:8443 demo start-dev"
                }
            }
        }
    }
}
