FROM alpine:3.7
ENV CONF_FILE /config/dnscrypt-proxy.toml
RUN apk add --no-cache wget ca-certificates
RUN wget -q https://github.com/jedisct1/dnscrypt-proxy/releases/download/2.0.0/dnscrypt-proxy-linux_i386-2.0.0.tar.gz
RUN tar -xzf dnscrypt-proxy-linux_i386-2.0.0.tar.gz
RUN mv /linux-i386 /dnscrypt
EXPOSE 53/tcp 53/udp
VOLUME ["/config"]
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD /dnscrypt/dnscrypt-proxy -syslog -config $CONF_FILE
