FROM soerentsch/serviio:latest

ARG UID=1900
ARG GID=1900

RUN grep -e ":$GID:" /etc/group >/dev/null || addgroup -g $GID serviio
RUN adduser -s /sbin/nologin -G `getent group $GID | cut -d : -f 1` -D -u $UID serviio
RUN chown -R $UID:$GID /opt/serviio

USER serviio
RUN id
