#!/usr/bin/env bash
set -euo pipefail

# Oficialni repozitar Zabbix 8.0 LTS pro Debian 13
apt-get update
apt-get install -y wget
wget -q -O /tmp/zabbix-release.deb https://repo.zabbix.com/zabbix/8.0/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_8.0+debian13_all.deb
dpkg -i /tmp/zabbix-release.deb
apt-get update

# Instalace Zabbix Agent 2
apt-get install -y zabbix-agent2

# Povoleni sluzby a kontrola verze
systemctl enable zabbix-agent2
zabbix_agent2 -V | head -1

# EOF
