#!/bin/bash

usage() { echo "usage: xtractcrt.sh -i 10.129.16.128 -p 443" >&2; }

if [ $# -lt 4 ]
then
    usage
    exit 1
fi

while getopts 'i:p:' OPTION; do
    case "${OPTION}" in
        i) ip="$OPTARG" ;;
        p) port=$((OPTARG)) ;;
        *) break ;;
        ?) usage ;;
    esac
done

if ! [[ $ip =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]
then
    echo "$ip is not a valid ip address";
    exit 1
fi

if [[ $port -lt 0 || $port -gt 65535 ]]
then
    echo "$port is not a valid port"
    exit 1
fi

# get certificate and save as human readable text
openssl s_client -showcerts -connect $ip:$port </dev/null | \
openssl x509 > "$ip:$port.pem" && \
openssl x509 -in "$ip:$port.pem" -text > "$ip:$port.x509.txt" && \

# get certificate fingerprints
openssl x509 -in "$ip:$port.pem" -outform DER -out "$ip:$port.x509.der";
sha1sum "$ip:$port.x509.der" > "$ip:$port.x509.der.sha1";
sha256sum "$ip:$port.x509.der" > "$ip:$port.x509.der.sha256";
