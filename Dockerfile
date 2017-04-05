FROM resin/rpi-raspbian

RUN apt-get -y update
RUN apt-get -y install apt-utils

RUN apt-get -y install curl git python build-essential curl
#automake libtool libevent-dev libsnappy-dev libicu-dev libssl-dev libcurl4-openssl-dev python erlang-nox erlang-dev pkg-config  
#check sqlite3 ruby libglib2.0-dev libv8-dev libmozjs-dev libcloog-ppl0

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
RUN apt-get -y install python
#RUN apt-get -y install erlang-nox
#RUN apt-get -y install erlang-dev
#RUN apt-get -y install erlang-src

RUN apt-get -y install libncurses5-dev libncursesw5-dev 
RUN git clone https://github.com/erlang/otp.git
RUN cd otp; ./otp_build autoconf  
RUN cd otp; ./configure
RUN cd otp; make
RUN cd otp; make install

RUN apt-get -y install pkg-config
RUN apt-get -y install check
RUN apt-get -y install sqlite3
RUN apt-get -y install ruby
RUN apt-get -y install libglib2.0-dev
RUN apt-get -y install libv8-dev
RUN apt-get -y install libmozjs-24-dev

RUN erlang -v
RUN cd couchbase; make
