# dependencies and scripts to run
# https://personaltelco.net/wiki/FooCabFirmwareHowTo

FROM ubuntu:14.04

MAINTAINER ptp@bnf.net
	    
ENV IMAGE personaltelco/node-builder
# ENV BUILDATE

RUN apt-get update &&\
    apt-get install -y git-core subversion build-essential gcc-multilib \
    libncurses5-dev zlib1g-dev gawk flex gettext wget unzip python libssl-dev openssl \
    cpanminus libnet-ssleay-perl libcrypt-ssleay-perl &&\
    apt-get clean 

RUN cpanm --skip-satisfied NetAddr::IP::Lite Getopt::Long LWP::Simple JSON LWP::Protocol::https 

ADD ./bin /opt/bin

ENV OWUSER openwrt
RUN useradd -m ${OWUSER} &&\
    echo "${OWUSER} ALL=NOPASSWD: ALL" > /etc/sudoers.d/${OWUSER} 

# this is a russelism
RUN ln -s /home/${OWUSER} /src_archive

USER ${OWUSER}
WORKDIR /home/${OWUSER}
RUN git clone -b static-splash git://github.com/bnfinet/ptp-openwrt-files.git
RUN git clone git://git.openwrt.org/openwrt.git 

WORKDIR /home/${OWUSER}/openwrt
RUN scripts/feeds update
ADD config/openwrt/feeds.conf /home/${OWUSER}/openwrt/feeds.conf
RUN scripts/feeds update -a
RUN scripts/feeds install -a

WORKDIR /home/${OWUSER}

USER ${OWUSER}
ENTRYPOINT ["/opt/bin/build.sh"]
