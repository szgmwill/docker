#!/bin/bash
# Debug into a docker container 
# Author by Will

# docker run format
# docker run [OPTIONS] IMAGE[:TAG] [COMMAND] [ARG...]
docker run -it -P centos_tianxun_dr_jekyll_base:dev /bin/bash
