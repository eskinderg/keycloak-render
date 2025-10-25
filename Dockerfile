# Base Keycloak image
FROM quay.io/keycloak/keycloak:26.0.1

WORKDIR /opt/keycloak

# Optional: include custom config, themes, providers
#COPY conf/ conf/
#COPY themes/ themes/
#COPY providers/ providers/

# Environment defaults (can be overridden by Railway)
#ENV KC_DB=postgres
ENV KC_HTTP_ENABLED=true
#ENV KC_PROXY=edge
ENV KC_HOSTNAME_STRICT=false
ENV KC_LOG_LEVEL=INFO

# Build the Keycloak image
RUN /opt/keycloak/bin/kc.sh build

EXPOSE 8080

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
