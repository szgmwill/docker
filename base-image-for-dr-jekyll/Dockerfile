# From a base image
#FROM centos:6.7
FROM registry.aliyuncs.com/acs-sample/centos:6

# Image Owner
MAINTAINER Will Zhang <willzhang@skyscanner.net>

# Indicate which user to run cmd,default is root
#USER skyadmin

# Set global env parma here
ENV username skyadmin
ENV rootdir /opt/${username}
ENV userhome /home/${username}
ENV logpath /var/log/${username}
# Aliyun File Download,please make sure when docker build can access this address
ENV aliyun_installers_url http://10.31.0.11/software/tianxun

# python version define here
ENV python_version=2.7.7
ENV python_root ${rootdir}/python/python-${python_version}
ENV python_bin_dir ${python_root}/bin

# Update All
RUN yum -y update && \
    yum -y install wget


# 1. Init the folder and env.  refer to => ansible-role:[initialise]
RUN mkdir -p ${userhome} && \
    mkdir -p ${userhome}/profile_includes && \
    mkdir -p ${rootdir} && \
    mkdir -p ${logpath} && \
    mkdir -p ${python_root}


# cd to user home dir
WORKDIR ${userhome}

# 2. Install all system dependencies. refer to => ansible-role:[dev_tools]
# 2.1 install the epel via local filesystem && development tools
RUN yum -y install tar && \
    wget ${aliyun_installers_url}/epel-release-6-8.noarch.rpm && \
    yum -y localinstall epel-release-6-8.noarch.rpm && \
    yum groupinstall -y "Development tools"

# 2.2 install additional development packages
RUN yum install -y \
    bzip2-devel \
    db4-devel \
    gdbm-devel \
    libcurl-devel \
    libffi-devel \
    libpcap-devel \
    libxml2-devel \
    libxslt-devel \
    libyaml-devel \
    lzo-devel \
    ncurses-devel \
    openssl-devel \
    pcre-devel \
    readline-devel \
    sqlite-devel \
    tk-devel \
    xz-devel \
    zeromq-devel \
    zlib-devel \

# 2.3 install additional hosted development packages
RUN wget ${aliyun_installers_url}/couchbase/libcouchbase2-core-2.3.2-1.x86_64.rpm && \
    wget ${aliyun_installers_url}/couchbase/libcouchbase2-libevent-2.3.2-1.x86_64.rpm && \
    wget ${aliyun_installers_url}/couchbase/libcouchbase-devel-2.3.2-1.x86_64.rpm && \
    yum -y localinstall libcouchbase2-core-2.3.2-1.x86_64.rpm && \
    yum -y localinstall libcouchbase2-libevent-2.3.2-1.x86_64.rpm && \
    yum -y localinstall libcouchbase-devel-2.3.2-1.x86_64.rpm

# 3. Install Python and Related Dependencies. refer to ansible-role:[python]
# 3.1 install python2.7
RUN wget ${aliyun_installers_url}/python/Python-${python_version}.tgz && \
    tar -zxvf Python-${python_version}.tgz && \
    cd Python-${python_version} && \
    ./configure --prefix=${python_root} && \
    make && \
    make install

# 3.2 install setuptools, pip, virtualenv
RUN cd ${userhome} && \
    wget ${aliyun_installers_url}/python/setuptools/setuptools-3.6.tar.gz && \
    tar -xvf setuptools-3.6.tar.gz && \
    cd setuptools-3.6 && \
    ${python_bin_dir}/python setup.py install && \
    ${python_bin_dir}/easy_install pip && \
    ${python_bin_dir}/pip install virtualenv

# 4. Install Nginx via yum.  refer to ansible-role:[nginx]
RUN cd ${userhome} && \
    yum -y install nginx
    #wget ${aliyun_installers_url}/nginx/nginx-1.6.0-1.el6.ngx.x86_64.rpm && \
    #yum -y localinstall nginx-1.6.0-1.el6.ngx.x86_64.rpm

# add nginx config if needed
#COPY config/nginx/default.conf /etc/nginx/conf.d/
#COPY config/nginx/nginx.pp ${userhome}

# apply SELinux nginx policy fix
#RUN cd ${userhome} && \
#    /usr/sbin/semodule -i nginx.pp


# 5. Install Nodejs via yum. refer to ansible-role:[node]
RUN yum -y install nodejs npm --enablerepo=epel

# 6. Install statsd. refer to ansible-role:[statsd]
RUN cd ${rootdir} && \
    git clone https://github.com/etsy/statsd.git && \
    mkdir -p /var/log/statsd

# statsd config file
COPY config/statsd/statsdConfig.js ${rootdir}/statsd/

# rename the host for currnet container id
RUN /bin/sed -i "s/docker/$(hostname)/g" ${rootdir}/statsd/statsdConfig.js

# 7. Install diamond. refer to ansible-role:[diamond]
RUN cd ${userhome} && \
    wget ${aliyun_installers_url}/diamond/diamond-3.4.322-0.el6.noarch.rpm && \
    yum -y localinstall diamond-3.4.322-0.el6.noarch.rpm

# add collectors and config file
COPY config/diamond/diamond.conf /etc/diamond/
COPY config/diamond/CustomHttpCollector.conf /etc/diamond/collectors/
COPY config/diamond/CustomHttpCollector.py /usr/share/diamond/collectors/


# clean download packages
RUN cd ${userhome} && \
    rm -rf * && \
    yum clean all

# add start cmd script to container
COPY run.sh /run.sh
RUN chmod 755 /*.sh

# mount some dir to the host machine,like log,data etc.
VOLUME ["${logpath}"]


# exec the start script when container running
CMD ["/run.sh"]

# expose all the port out
EXPOSE 80
EXPOSE 443
