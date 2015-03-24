#!/bin/bash

# sanity check
if [[ -a /etc/supervisor/conf.d/supervisord.conf ]]; then
  exit 0
fi

# supervisor
cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=true

[program:alaveteli]
directory=/opt/alaveteli
process_name=alaveteli
command=bundle exec thin

[program:rsyslog]
command=/usr/sbin/rsyslogd -n -c3
EOF

cp /opt/alaveteli
bundle exec rake themes:install
