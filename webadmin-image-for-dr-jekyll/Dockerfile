# From a base image setup before
FROM centos_tianxun_dr_jekyll_base:dev

# Image Owner
MAINTAINER Will Zhang <willzhang@skyscanner.net>


# Set global env parma here
ENV username skyadmin
ENV userhome /home/${username}
ENV root_dir /opt/${username}
ENV app_root ${root_dir}/experimental-web
ENV config_dir ${app_root}/config
ENV app_dir ${app_root}/app

# python version define here
ENV python_version=2.7.7
ENV python_root ${root_dir}/python/python-${python_version}
ENV python_bin_dir ${python_root}/bin

# supervisord
ENV supervisord_dir ${root_dir}/supervisord
ENV supervisord_app ${supervisord_dir}/appconfigs


# Update All
RUN yum -y update


# Init the folder and env.
RUN mkdir -p ${app_root} && \
    mkdir -p ${config_dir} && \
    mkdir -p ${app_dir} $$ \
    mkdir -p ${supervisord_dir} $$ \
    mkdir -p ${supervisord_app}

# cd to user home dir
WORKDIR ${userhome}


# 1. Install the supervisord.  refer to => ansible-role:[supervisord]
RUM ${python_bin_dir}/easy_install supervisor

# add config files
COPY config/supervisord/supervisord.conf ${supervisord_dir}
COPY config/statsd/statsd.ini ${supervisord_app}
COPY config/diamond/diamond.ini ${supervisord_app}
COPY config/app/experimentalweb.ini ${supervisord_app}
COPY config/supervisord/supervisord /etc/init.d/

# add supervisord as service
#/sbin/chkconfig

# 2. Deploy app dist resources. refer to => ansible-role:[experimentalweb]
