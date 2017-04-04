FROM resin/rpi-raspbian

RUN apt-get -y update
RUN apt-get -y install apt-utils

RUN apt-get -y install curl git python build-essential curl
#automake libtool libevent-dev libsnappy-dev

#RUN apt-get -y install python pkg-config check sqlite3 libglib2.0-dev libcurl4-openssl-dev erlang-nox erlang-dev erlang-src ruby libmozjs-dev libv8-dev libcloog-ppl0

RUN mkdir ~/bin

RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
RUN chmod a+x ~/bin/repo

ENV PATH="/root/bin:${PATH}"

RUN mkdir couchbase
RUN cd couchbase; repo init -u git://github.com/couchbase/manifest.git -m rel-2.1.1.xml
RUN cd couchbase; repo sync

RUN apt-get -y install automake
RUN apt-get -y install libtool
RUN apt-get -y install libevent-dev
RUN apt-get -y install libsnappy-dev
RUN apt-get -y install libicu-dev
RUN apt-get -y install libssl-dev
RUN apt-get -y install libcurl4-openssl-dev

RUN cd couchbase; make
