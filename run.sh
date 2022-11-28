#!/bin/bash

set -e

if [ -z $BASIC_AUTH ]; then
  echo >&2 "BASIC_AUTH must be set"
  exit 1
fi

if [ -z $PROXY_PASS ]; then
  echo >&2 "PROXY_PASS must be set"
  exit 1
fi
IFS=';' read -ra ADDR <<< "$BASIC_AUTH"
truncate -s 0 /etc/nginx/.htpasswd
for i in "${ADDR[@]}"; do
  IFS=':'; read -ra ACC <<< "$i"
  htpasswd -bB /etc/nginx/.htpasswd "${ACC[0]}" "${ACC[1]}"
done

sed \
  -e "s/##CLIENT_MAX_BODY_SIZE##/$CLIENT_MAX_BODY_SIZE/g" \
  -e "s/##PROXY_READ_TIMEOUT##/$PROXY_READ_TIMEOUT/g" \
  -e "s/##WORKER_PROCESSES##/$WORKER_PROCESSES/g" \
  -e "s/##SERVER_NAME##/$SERVER_NAME/g" \
  -e "s/##PORT##/$PORT/g" \
  -e "s|##PROXY_PASS##|$PROXY_PASS|g" \
  nginx.conf.tmpl > /etc/nginx/nginx.conf

exec nginx -g "daemon off;"
