FROM ubuntu:14.04
 
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN locale-gen en_US en_US.UTF-8
ENV LANG en_US.UTF-8
RUN echo "export PS1='\e[1;31m\]\u@\h:\w\\$\[\e[0m\] '" >> /root/.bashrc

#Runit
RUN apt-get install -y runit 
CMD export > /etc/envvars && /usr/sbin/runsvdir-start
RUN echo 'export > /etc/envvars' >> /root/.bashrc

#Utilities
RUN apt-get install -y vim less net-tools inetutils-ping wget curl git telnet nmap socat dnsutils netcat tree htop unzip sudo software-properties-common jq psmisc

RUN apt-get install -y nginx
RUN wget -O - https://github.com/letsencrypt/letsencrypt/archive/v0.4.2.tar.gz | tar xz
RUN mv letsencrypt* letsencrypt
RUN /letsencrypt/letsencrypt-auto --help

COPY default /etc/nginx/sites-enabled/

#Add runit services
COPY sv /etc/service 

