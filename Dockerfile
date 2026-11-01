FROM soerentsch/serviio:latest

ARG UID=1900
ARG GID=1900

RUN apk upgrade --no-cache

RUN addgroup -g $GID serviio
RUN adduser -s /sbin/nologin -G serviio -D -u $UID serviio

RUN chown -R serviio:serviio /opt/serviio/config /opt/serviio/library /opt/serviio/plugins /opt/serviio/log

USER serviio
