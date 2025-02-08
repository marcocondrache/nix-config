#!/usr/bin/env bash

HOST=$1
ADDRESS=$2

if [ -z "$HOST" -o -z "$ADDRESS" ]; then
    echo "Usage: $0 <host> <address>"
    exit 2
fi

TEMP=$(mktemp -d)

cleanup() {
  rm -rf "$TEMP"
}

trap cleanup EXIT

install -d -m755 "$TEMP/etc/ssh"

cp ssh_host_ed25519_key "$TEMP/etc/ssh/ssh_host_ed25519_key"
cp ssh_host_ed25519_key.pub "$TEMP/etc/ssh/ssh_host_ed25519_key.pub"

chmod 600 "$TEMP/etc/ssh/ssh_host_ed25519_key"
chmod 644 "$TEMP/etc/ssh/ssh_host_ed25519_key.pub"

nixos-anywhere --extra-files "$TEMP" --flake github:marcocondrache/nix-config#$HOST --target-host root@$ADDRESS --build-on-remote