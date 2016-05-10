FROM registry.aliyuncs.com/acs-sample/centos:6

# Image Owner
MAINTAINER Will Zhang <szgmwill@gmail.com>

ENV user will

RUN yum -y update

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN yum -y install nginx


CMD ["service", "nginx", "restart"]

EXPOSE 80
