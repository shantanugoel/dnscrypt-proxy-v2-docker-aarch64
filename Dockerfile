FROM arm64v8/alpine:latest
ENV CONF_FILE /config/dnscrypt-proxy.toml
ARG dnscrypt_version=2.0.29-beta.3
RUN apk add --no-cache wget ca-certificates \
&& wget -q https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/${dnscrypt_version}/dnscrypt-proxy-linux_arm64-${dnscrypt_version}.tar.gz \
&& tar -xzf dnscrypt-proxy-linux_arm64-${dnscrypt_version}.tar.gz \
&& mv /linux-arm64 /dnscrypt
ARG DNS_PORT=53
EXPOSE $DNS_PORT/tcp $DNS_PORT/udp
VOLUME ["/config"]
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD /dnscrypt/dnscrypt-proxy -syslog -config $CONF_FILE
