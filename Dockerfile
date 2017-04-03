FROM resin/rpi-raspbian

RUN apt-get -y update
RUN apt-get -y install apt-utils

RUN apt-get -y install git wget curl bc 
#golang build-essential

RUN wget http://dave.cheney.net/paste/go1.4.2.linux-arm~multiarch-armv7-1.tar.gz
RUN  tar -C /usr/local -xzf  go1.4.2.linux-arm~multiarch-armv7-1.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

#RUN dir /usr/local/go/bin
ENV GOPATH="$HOME/go"

RUN go env
RUN go version

RUN apt-get install python python3

RUN mkdir ~/sync_gateway 
RUN cd ~/sync_gateway; wget https://raw.githubusercontent.com/couchbase/sync_gateway/master/bootstrap.sh
RUN cd ~/sync_gateway; chmod +x bootstrap.sh
RUN cd ~/sync_gateway; ./bootstrap.sh
RUN cd ~/sync_gateway; ./build.sh
#RUN go get -u -t github.com/couchbase/sync_gateway/...

RUN git init
RUN git clone https://github.com/couchbase/sync_gateway.git
RUN dir sync_gateway
RUN git submodule update --init --recursive

#RUN cd sync_gateway && make
#RUN cd sync_gateway && make install

RUN sync_gateway/build.sh

RUN dir bin

CMD sync_gateway/bin/sync_gateway sync_gateway/examples/admin_party.json
