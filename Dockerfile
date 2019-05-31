#FROM debian:stretch
FROM node:10.15.3-stretch
# Install cron, certbot, bash, plus any other dependencies
# (1) install cron
RUN apt-get update && apt-get install -y cron rsyslog
COPY wpt-cron /etc/cron.d/wpt-cron
RUN chmod 0644 /etc/cron.d/wpt-cron
#RUN crontab /etc/cron.d/wpt-cron
WORKDIR /usr/src/wpt-reporter
COPY wpt-reporter ./
COPY script .
RUN chmod 0755 /usr/src/wpt-reporter/script
RUN npm install
RUN touch /etc/crontab /etc/cron.*/*
CMD rsyslogd && cron -f
