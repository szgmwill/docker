FROM registry.aliyuncs.com/acs-sample/centos:6

# Image Owner
MAINTAINER Will Zhang <szgmwill@gmail.com>

ENV user will

RUN yum -y update && \
    yum -y install wget tar && \
    yum -y gcc gcc-c++ autoconf automake zlib zlib-devel openssl openssl-devel pcre-devel

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN mkdir -p /home/temp && \
    cd /home/temp && \
    wget http://nginx.org/download/nginx-1.6.0.tar.gz && \
    tar -zxvf nginx-1.6.0.tar.gz && \
    cd nginx-1.6.0 && \
    ./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx--conf-path=/etc/nginx/nginx.conf && \
    --error-log-path=/var/log/nginx/error.log && \
    --http-log-path=/var/log/nginx/access.log && \
    --pid-path=/var/log/nginx/nginx.pid && \
    --lock-path=/var/log/nginx/nginx.lock && \
    make && make install  && \
    mkdir -p /etc/nginx/conf.d

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
