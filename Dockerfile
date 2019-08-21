FROM debian:stretch

LABEL maintainer="info@enforge.de"

### 1 - update and install os
RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get autoremove && \
apt-get clean -y && \
rm -rf /tmp/* /var/tmp/* /var/cache/apt/* /var/cache/distfiles/*

## 1.1 - install required prerequisites
RUN apt-get install -y net-tools apt-utils curl

## 1.2 - add repo and update
RUN curl -fsSL https://raspbian.raspberrypi.org | apt-key add -
RUN echo "deb http://raspbian.raspberrypi.org/raspbian stretch main contrib non-free rpi" >> /etc/apt/sources.list


### 2 - install required software
RUN apt-get install -y libraspberrypi-bin



### 3 - configure software
## either
## COPY install.sh /install.sh
## or
## run commands here with RUN
##   install.sh is bad, as this does not provide any caching of expensive operations
## thus, RUN commands are used!

## configure the video access
RUN usermod -a -G video root


### 4 - expose network ports
EXPOSE 80/tcp


### 5 - add custom files


### 6 - startup command
#CMD bash
CMD raspistill -vf -hf -o test.jpg