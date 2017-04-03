FROM resin/rpi-raspbian

RUN apt-get -y update
RUN apt-get -y install apt-utils

RUN apt-get -y install git wget curl

RUN git clone https://github.com/couchbase/sync_gateway.git
RUN git submodule update --init --recursive

RUN cd sync_gateway \
./build.sh

RUN cd sync_gateway \ 
bin/sync_gateway examples/admin_party.json

CMD curl -X GET http://localhost:4985/db/
