FROM resin/rpi-raspbian

RUN apt-get -y update
RUN apt-get -y install apt-utils

RUN apt-get -y install git wget curl 
RUN apt-get -y install gcc
RUN apt-get -y install build-essential 

RUN curl -sSLO https://storage.googleapis.com/golang/go1.7.5.linux-armv6l.tar.gz  
RUN mkdir -p /usr/local/go  
RUN tar -xvf go1.7.5.linux-armv6l.tar.gz -C /usr/local/go --strip-components=1  

ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="$HOME/go"

RUN apt-get -y install python python3

RUN mkdir ~/sync_gateway 
RUN cd ~/sync_gateway; wget https://raw.githubusercontent.com/couchbase/sync_gateway/master/bootstrap.sh
RUN cd ~/sync_gateway; chmod +x bootstrap.sh
RUN cd ~/sync_gateway; ./bootstrap.sh
RUN cd ~/sync_gateway; ./build.sh

EXPOSE 4985

CMD ~/sync_gateway/godeps/bin/sync_gateway -adminInterface="0.0.0.0:4985"
