#!/bin/bash
# Manage the Service Action into docker container
# Author by Will

# start ssh service
/usr/sbin/sshd &

# start nginx service
/usr/sbin/nginx

# start statsd server
#/usr/bin/node /opt/skyadmin/statsd/stats.js statsdConfig.js &
/usr/bin/nohup /opt/skyadmin/statsd/bin/statsd /opt/skyadmin/statsd/statsdConfig.js >> /var/log/statsd/statsdLog &

# start diamond
/sbin/service diamond restart

# tail log
tail -f /var/log/nginx/access.log
