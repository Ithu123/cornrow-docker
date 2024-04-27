FROM debian:bookworm

# install dependencies
RUN apt-get update
RUN apt-get install -y \
  bluez \
  build-essential \
  debhelper \
  fakeroot \
  libtool \
  cmake \
  libasound2-dev \
  libavahi-compat-libdnssd-dev \
  libavcodec-dev \
  libboost-dev \
  libboost-system-dev \
  libsbc-dev \
  libssl-dev \
  qtconnectivity5-dev \
  libqt5websockets5-dev \
  libkf5bluezqt-dev \
  libcap2-bin

# compile and install project
COPY ./cornrow /cornrow
WORKDIR /cornrow
RUN dpkg-buildpackage -us -uc -nc
RUN apt-get install -y /cornrowd_*.deb

# cleanup
WORKDIR /
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /cornrow

# run entrypoint
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
