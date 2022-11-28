FROM nginx:1.11.9-alpine

# for htpasswd command
RUN apk add --no-cache --update \
      apache2-utils bash
RUN rm -f /etc/nginx/conf.d/*

ENV SERVER_NAME example.com
ENV PORT 80
ENV CLIENT_MAX_BODY_SIZE 1m
ENV PROXY_READ_TIMEOUT 60s
ENV WORKER_PROCESSES auto

COPY run.sh /
COPY nginx.conf.tmpl /

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/run.sh"]
RUN chmod +x /run.sh
