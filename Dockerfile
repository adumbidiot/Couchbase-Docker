FROM resin/rpi-raspbian

RUN apt-get -y update
RUN apt-get -y install apt-utils

RUN apt-get -y install curl git python build-essential

RUN mkdir ~/bin
ENV PATH=~/bin:$PATH

RUN  curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
RUN chmod a+x ~/bin/repo
