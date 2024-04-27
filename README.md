# Cornrow Docker
Docker images for [cornrow by mincequi](https://github.com/mincequi/cornrow) an audio sink daemon for Bluetooth and Airplay streams.

## Setup

Make sure to disable bluetooth on the host:
```
sudo systemctl disable bluetooth
sudo systemctl stop bluetooth
```

**docker-compose.yaml**
```yaml
version: '3'

services:
  cornrow:
    image: ghcr.io/blaubeeree/cornrow-docker:latest
    container_name: cornrow
    environment:
      CORNROW_NAME: bluetooth speaker
    cap_add:
      - NET_ADMIN
    devices:
      - /dev/rfkill
      - /dev/snd
    network_mode: host
    restart: unless-stopped
```
