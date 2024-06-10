pipeline {
    agent any

    environment {
        DOCKER_BUILDKIT = "1"
        KEYCLOAK_ADMIN = "${KEYCLOAK_ADMIN}"
        KEYCLOAK_ADMIN_PASSWORD = "${KEYCLOAK_ADMIN_PASSWORD}"
        KC_DB_USERNAME = "${KC_DB_USERNAME}"
        KC_DB_PASSWORD = "${KC_DB_PASSWORD}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("my-keycloak", """
                        --build-arg KEYCLOAK_ADMIN=${env.KEYCLOAK_ADMIN} \
                        --build-arg KEYCLOAK_ADMIN_PASSWORD=${env.KEYCLOAK_ADMIN_PASSWORD} \
                        --build-arg KC_DB_USERNAME=${env.KC_DB_USERNAME} \
                        --build-arg KC_DB_PASSWORD=${env.KC_DB_PASSWORD} .
                    """)
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    docker.image("my-keycloak").run("-d -p 8443:8443")
                }
            }
        }
    }
}
