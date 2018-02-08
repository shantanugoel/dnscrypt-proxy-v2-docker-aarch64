#! /bin/sh
#
# entrypoint.sh
mkdir -p /config
if [ ! -f /config/dnscrypt-proxy.toml ]; then
    cp /dnscrypt/example-dnscrypt-proxy.toml /config/dnscrypt-proxy.toml
fi

exec "$@"
