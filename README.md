# Serviio rootless
Rootless version of soerentsch/serviio for us weird folks wo do not like 3rd party Java software running as root. Naturally user container runs as must be able to read the files.

# Compose file

## Example
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
    #group_add:
    #  - video
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
    networks:
      macvlan_lan:
        ipv4_address: 10.0.0.10

networks:
  macvlan_lan:
    name: macvlan_lan
    external: true
```

Note that we are using tmpfs for /tmp so that transcoded files are placed to RAM. Depending on your videos and RAM size this could be very bad idea so adjust as needed.

It could be possible to use hardware accelerated transcoding by applying ```group_add: video``` and ```devices: /dev/dri:/dev/dri```, but this is untested as I have no Nvidia or Intel GPU.

I am using macvlan here to give container it's own IP address for Reasons but please refer to https://hub.docker.com/r/soerentsch/serviio for port mappings if needed.
