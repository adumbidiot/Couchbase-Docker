FROM resin/rpi-raspbian

RUN apt-get -y update
RUN apt-get -y install apt-utils

RUN apt-get -y install curl git python build-essential curl
#RUN apt-get -y install python automake libtool pkg-config check libssl-dev sqlite3 libevent-dev libglib2.0-dev libcurl4-openssl-dev erlang-nox curl erlang-dev erlang-src ruby libmozjs-dev libicu-dev libv8-dev libcloog-ppl0 libsnappy-dev

RUN mkdir ~/bin

RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
RUN chmod a+x ~/bin/repo

ENV PATH="~/bin:${PATH}"

RUN repo

RUN echo $PATH
RUN dir ~/bin
RUN mkdir couchbase
RUN cd couchbase; repo init -u git://github.com/couchbase/manifest.git -m rel-2.1.1.xml
RUN cd couchbase; repo sync

RUN cd couchbase; make
