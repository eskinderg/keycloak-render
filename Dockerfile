# Base image for Keycloak
FROM quay.io/keycloak/keycloak:26.0.1

# Set working directory
WORKDIR /opt/keycloak

# Copy local Keycloak config and themes if you’ve customized them
COPY conf/ conf/
COPY themes/ themes/
COPY providers/ providers/

# Set environment variables for build
ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://db:5432/keycloak
ENV KC_DB_USERNAME=keycloak
ENV KC_DB_PASSWORD=keycloak
ENV KC_HTTP_ENABLED=true
ENV KC_PROXY=edge
ENV KC_HOSTNAME_STRICT=false
ENV KC_LOG_LEVEL=INFO

# Build the server image (necessary for KC >=17)
RUN /opt/keycloak/bin/kc.sh build

# Expose the HTTP port
EXPOSE 8080

# Run Keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
