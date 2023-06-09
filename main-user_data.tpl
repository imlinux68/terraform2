#!/bin/bash
yum update -y
hostname set-hostname ${new_hostname}
echo -e "[grafana]\nname=grafana\nbaseurl=https://packages.grafana.com/oss/rpm\nrepo_gpgcheck=1\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.grafana.com/gpg.key\nsslverify=1\nsslcacert=/etc/pki/tls/certs/ca-bundle.crt" >> /etc/yum.repos.d/grafana.repo
yum install grafana wget epel-release -y
# pass admin login admin
systemctl daemon-reload
systemctl start grafana-server
systemctl enable grafana-server.service