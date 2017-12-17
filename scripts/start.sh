#!/bin/sh

sed -ri "s!^(\#\s*)?(server\.host:).*!\2 '0.0.0.0'!" /usr/share/kibana/config/kibana.yml
grep -q "^server\.host: '0.0.0.0'\$" /usr/share/kibana/config/kibana.yml
sed -ri "s!^(\#\s*)?(elasticsearch\.url:).*!\2 '${ELASTICSEARCH_URL}'!" /usr/share/kibana/config/kibana.yml
grep -q "^elasticsearch\.url: '${ELASTICSEARCH_URL}'\$" /usr/share/kibana/config/kibana.yml
sed -i "s|NODE=\"${DIR}/node/bin/node\"|NODE=\"/usr/bin/node\"|g" /usr/share/kibana/bin/kibana-plugin
sed -i "s|NODE=\"${DIR}/node/bin/node\"|NODE=\"/usr/bin/node\"|g" /usr/share/kibana/bin/kibana

chown -R kibana:kibana /usr/share/kibana

exec su-exec kibana /usr/share/kibana/bin/kibana