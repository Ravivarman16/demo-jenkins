# Use a multi-stage build for efficiency
# Stage 1: Build stage
FROM quay.io/keycloak/keycloak:latest as builder

# Set environmental variables for Keycloak configuration
ARG USERNAME
ARG USERPWD
ARG USER_DB
ARG USERDBNAME
ARG USERDB_PWD

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

WORKDIR /opt/keycloak

# Generate keypair for SSL
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:jenkinskey.ravivarman.xyz" -keystore conf/server.keystore

# Stage 2: Final image stage
FROM quay.io/keycloak/keycloak:latest

# Copy configurations from the builder stage
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Set additional environmental variables
ENV KC_HOSTNAME_DEBUG=false
ENV KC_HOSTNAME=jenkinskey.ravivarman.xyz
ENV KC_HTTPS_PORT=8443
ENV DB_VENDOR=postgres
ENV KEYCLOAK_ADMIN=${USERNAME}
ENV KEYCLOAK_ADMIN_PASSWORD=${USERPWD}
ENV KC_PROXY=passthrough
ENV KC_HEALTH_ENABLED=true
ENV KC_DB=mysql
ENV KC_DB_URL=${USER_DB}
ENV KC_DB_USERNAME=${USERDBNAME}
ENV KC_DB_PASSWORD=${USERDB_PWD}
ENV KC_HTTP_ENABLED=false
ENV JAVA_OPTS -Dkeycloak.profile.feature.admin_fine_grained_authz.upload_scripts=enabled

# Use kc.sh as the entrypoint
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
