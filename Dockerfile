FROM resin/rpi-raspbian

RUN apt-get -y update
RUN apt-get -y install apt-utils

RUN apt-get -y install git wget curl
RUN apt-get -y install go

RUN wget http://dave.cheney.net/paste/go1.4.2.linux-arm~multiarch-armv7-1.tar.gz
RUN  tar -C /usr/local -xzf  go1.4.2.linux-arm~multiarch-armv7-1.tar.gz

#RUN export PATH=$PATH:/usr/local/go/bin

RUN git init
RUN git clone https://github.com/couchbase/sync_gateway.git
RUN dir sync_gateway
RUN git submodule update --init --recursive

RUN sync_gateway/build.sh

RUN dir bin

CMD sync_gateway/bin/sync_gateway sync_gateway/examples/admin_party.json
