FROM alpine:3.7

LABEL MAINTAINER="Aurelien PERRIER <perrie_a@etna-alternance.net>"
LABEL APP="kibana"
LABEL APP_VERSION="6.0.0"
LABEL APP_REPOSITORY="https://github.com/influxdata/kapacitor/releases"

ENV TIMEZONE Europe/Paris
ENV VERSION 6.0.0
ENV ELASTICSEARCH_URL http://elasticsearch:9200

# Installing packages
RUN apk add --no-cache nodejs su-exec

# Work path
WORKDIR /scripts

# Download Kibana
ADD https://artifacts.elastic.co/downloads/kibana/kibana-${VERSION}-linux-x86_64.tar.gz ./
RUN addgroup kibana && \
      adduser -s /bin/false -G kibana -S -D kibana

# Installing binaries
RUN tar -C ./ -xzf kibana-${VERSION}-linux-x86_64.tar.gz && \
    mv kibana-${VERSION}-linux-x86_64 /usr/share/kibana && \
    rm -rf /usr/share/kibana/node kibana-${VERSION}-linux-x86_64.tar.gz

COPY ./scripts/start.sh start.sh

VOLUME [ "/usr/share/kibana" ]

EXPOSE 5601

ENTRYPOINT ["./start.sh"]