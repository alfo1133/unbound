# Base image is Alpine Linux
# docker build -t gkweb76/unbound:1.6.7 -t gkweb76/unbound:latest -t gkweb76/unbound:1.6.7-r1 .
FROM alpine:3.20.2
#LABEL maintainer="Guillaume Kaddouch"
LABEL maintainer="alfo1133"

# Install Unbound and setup permissions
RUN apk add --update --no-cache unbound=1.20.0 && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/* && \
    cp /usr/share/dnssec-root/trusted-key.key /etc/unbound/ && \
    chown unbound:unbound /usr/share/dnssec-root/trusted-key.key && \
    chown unbound:unbound /etc/unbound/trusted-key.key && \
    chmod 664 /usr/share/dnssec-root/trusted-key.key && \
    chmod 664 /etc/unbound/trusted-key.key && \
    chown -R unbound:unbound /etc/unbound

# Healtcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD nslookup alpinelinux.org || exit 1

# Port available
EXPOSE 53/udp 53/tcp

# Volume where are located config files, must contain unbound.conf
VOLUME ["/etc/unbound"]

# Environment variables
ENV UNBOUND_VERSION 1.20.0

# Start unbound daemon
CMD ["unbound", "-c", "/etc/unbound/unbound.conf"]
