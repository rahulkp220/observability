#!/bin/bash
ALERTMANAGER_VERSION="0.15.2"
wget https://github.com/prometheus/alertmanager/releases/download/v${ALERTMANAGER_VERSION}/alertmanager-${ALERTMANAGER_VERSION}.linux-amd64.tar.gz
tar xvzf alertmanager-${ALERTMANAGER_VERSION}.linux-amd64.tar.gz
cd alertmanager-${ALERTMANAGER_VERSION}.linux-amd64/

# create user
useradd --no-create-home --shell /bin/false alertmanager 

# create directories
mkdir /etc/alertmanager
mkdir /etc/alertmanager/template
mkdir -p /var/lib/alertmanager/data

# touch config file
touch /etc/alertmanager/alertmanager.yml

# set ownership
chown -R alertmanager:alertmanager /etc/alertmanager
chown -R alertmanager:alertmanager /var/lib/alertmanager

# copy binaries
cp alertmanager /usr/local/bin/
cp amtool /usr/local/bin/

# set ownership
chown alertmanager:alertmanager /usr/local/bin/alertmanager
chown alertmanager:alertmanager /usr/local/bin/amtool

# setup systemd
echo '[Unit]
Description=Prometheus Alertmanager Service
Wants=network-online.target
After=network.target
[Service]
User=alertmanager
Group=alertmanager
Type=simple
ExecStart=/usr/local/bin/alertmanager \
    --config.file /etc/alertmanager/alertmanager.yml \
    --storage.path /var/lib/alertmanager/data
Restart=always
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/alertmanager.service

# setup alertmanager yaml file
echo "global:
  smtp_smarthost: 'localhost:25'
  smtp_from: 'alertmanager@prometheus.com'
  smtp_auth_username: ''
  smtp_auth_password: ''
  smtp_require_tls: false
templates:
- '/etc/alertmanager/template/*.tmpl'
route:
  repeat_interval: 1h
  receiver: operations-team
receivers:
- name: 'operations-team'
  email_configs:
  - to: 'operations-team+alerts@example.org'
  slack_configs:
  - api_url: https://hooks.slack.com/services/XXXXXX/XXXXXX/XXXXXX
    channel: '#prometheus-alerts'
    send_resolved: true" > /etc/alertmanager/alertmanager.yml


systemctl daemon-reload
systemctl enable alertmanager
systemctl start alertmanager

