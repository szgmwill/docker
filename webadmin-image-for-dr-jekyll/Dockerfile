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


# Update All
RUN yum -y update


# Init the folder and env.
RUN mkdir -p ${app_root} && \
    mkdir -p ${config_dir} && \
    mkdir -p ${app_dir}

# cd to user home dir
WORKDIR ${userhome}


# 1. Install the supervisord.  refer to => ansible-role:[supervisord]



# 2. Deploy app dist resources. refer to => ansible-role:[experimentalweb]
