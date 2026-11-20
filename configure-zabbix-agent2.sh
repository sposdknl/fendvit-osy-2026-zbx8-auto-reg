#!/usr/bin/env bash
set -euo pipefail

# Pevny jedinecny nazev hosta: zustane stejny po restartu i po opakovanem provisioningu
ZBX_HOSTNAME="debian13-fendvit"
ZBX_SERVER="enceladus.pfsense.cz"
CONF="/etc/zabbix/zabbix_agent2.conf"

# Zaloha puvodni konfigurace (jen poprve)
[ -f "$CONF-orig" ] || cp -v "$CONF" "$CONF-orig"

# Nastaveni parametru (vzory sedi na puvodni i uz upraveny radek, takze jde spustit opakovane)
sed -i "s/^Hostname=.*/Hostname=$ZBX_HOSTNAME/" "$CONF"
sed -i "s/^Server=.*/Server=$ZBX_SERVER/" "$CONF"
sed -i "s/^ServerActive=.*/ServerActive=$ZBX_SERVER/" "$CONF"
sed -i -E "s/^#? ?HostMetadata=.*/HostMetadata=SPOS/" "$CONF"
diff -u "$CONF-orig" "$CONF" || true

# Restart sluzby a kontrola stavu
systemctl restart zabbix-agent2
systemctl --no-pager status zabbix-agent2 | head -5

# EOF
