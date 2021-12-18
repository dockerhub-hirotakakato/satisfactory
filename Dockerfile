FROM steamcmd/steamcmd:latest

EXPOSE 7777/udp 15000/udp 15777/udp
ENTRYPOINT []
CMD ["/steam/cmd.sh"]

RUN set -eux; \
    useradd -d /steam -m -s /bin/bash steam;\
    ( echo '#!/bin/sh -eu'; \
      echo 'steamcmd +force_install_dir ~/app +login anonymous +app_update 1690800 -beta experimental validate +quit'; \
      echo 'export LD_LIBRARY_PATH=~/app/linux64'; \
      echo 'exec ~/app/FactoryServer.sh' \
    ) | install -o steam -g steam -m 755 /dev/stdin /steam/cmd.sh

ENV USER=steam HOME=/steam
USER $USER
VOLUME $HOME
WORKDIR ["$HOME"]
