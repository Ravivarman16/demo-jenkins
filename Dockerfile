FROM quay.io/keycloak/keycloak:latest as builder
# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
# Configure a database vendor
WORKDIR /opt/keycloak
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:jenkinskey.ravivarman.xyz" -keystore conf/server.keystore
# Second stage
FROM quay.io/keycloak/keycloak:latest
# Copy files from the builder stage
COPY --from=builder /opt/keycloak/ /opt/keycloak/
# Set environment variables
ENV KC_HOSTNAME_DEBUG=false
ENV KC_HOSTNAME=jenkinskey.ravivarman.xyz
ENV KC_HTTPS_PORT=8443
ENV DB_VENDOR=postgres
ENV KEYCLOAK_ADMIN=$USERNAME
ENV KEYCLOAK_ADMIN_PASSWORD=$USERPWD
ENV KC_PROXY=passthrough
ENV KC_HEALTH_ENABLED=true
ENV KC_DB=mysql
ENV KC_DB_URL=$USER_DB 
ENV KC_DB_USERNAME=$USERDBNAME
ENV KC_DB_PASSWORD=$USERDB_PWD
ENV KC_HTTP_ENABLED=false
ENV -Dkeycloak.profile.feature.admin_fine_grained_authz.upload_scripts=enabled
# Entry point command
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]







