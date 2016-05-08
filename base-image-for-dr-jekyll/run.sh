#!/bin/bash
# Manage the Service Action into docker container
# Author by Will

# start ssh service
/usr/sbin/sshd &

# start nginx service
/usr/sbin/nginx

# tail log
tail -f /var/log/nginx/access.log

