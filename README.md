# Rootless serviio

Rootless version of soerentsch/serviio for us weird folks wo do not like 3rd party Java software running as root. Naturally user container runs as must be able to read the files.

## Compose file

```
services:
  serviio:
    container_name: serviio
    build:
      context: src
      args:
        - UID=1900
        - GID=1900
    restart: always
    user: 1900
    tmpfs:
      - /tmp:size=4096m
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ./opt/serviio/config:/opt/serviio/config
      - ./opt/serviio/library:/opt/serviio/library
      - ./opt/serviio/plugins:/opt/serviio/plugins
      - ./opt/serviio/log:/opt/serviio/log
      - /mnt/nas/Media:/media/serviio:ro
    #devices:
    #  - /dev/dri:/dev/dri
```

Note that we are using tmpfs for /tmp so that transcoded files are placed to RAM. Depending on your videos and RAM size this could be very bad idea so adjust as needed.

It could be possible to use hardware accelerated transcoding by setting GID to 27 (video) and adding device /dev/dri, but this is untested as I have no Nvidia or Intelu GPU.
