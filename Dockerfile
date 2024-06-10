# Multi-stage build
FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
WORKDIR /opt/keycloak
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:uat.ravivarman.xyz" -keystore conf/server.keystore

# Second stage
FROM quay.io/keycloak/keycloak:latest

# Copy files from the builder stage
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ARG KEYCLOAK_ADMIN
ARG KEYCLOAK_ADMIN_PASSWORD
ARG KC_DB_USERNAME
ARG KC_DB_PASSWORD

# Set environment variables
ENV KC_HOSTNAME_DEBUG=false
ENV KC_HTTPS_PORT=8443
ENV KEYCLOAK_ADMIN=${KEYCLOAK_ADMIN}
ENV KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_ADMIN_PASSWORD}
ENV KC_PROXY=passthrough
ENV KC_HEALTH_ENABLED=true
ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://34.100.161.8:5432/db?currentSchema=db1
ENV KC_DB_USERNAME=${KC_DB_USERNAME}
ENV KC_DB_PASSWORD=${KC_DB_PASSWORD}
ENV KC_HTTP_ENABLED=false
ENV KC_HOSTNAME_URL=https://uat.ravivarman.xyz/
ENV -Dkeycloak.profile.feature.admin_fine_grained_authz.upload_scripts=enabled
# Entry point command
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
