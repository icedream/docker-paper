FROM java:8-alpine

ARG MINECRAFT_VERSION=1.12
ARG PAPER_BUILD=1110
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=1e16b71a70ec0a1c10e090ffa3170a2fa8dc995293f93f3a7c1a5795a88ba86d1d69edc1c814ab317b7e7b2c830baba0a9b49a395e28386d66878b09161b2dbc

WORKDIR /data
ADD "${PAPER_URL}" /srv/paper.jar
RUN cd /srv &&\
	java -jar paper.jar --version &&\
	mv cache/patched*.jar paper.jar &&\
	rm -rf cache &&\
	chmod 444 /srv/paper.jar

ADD start.sh /usr/local/bin/paper
RUN chmod +x /usr/local/bin/paper

ENV JAVA_ARGS "-Xmx1G"
ENV SPIGOT_ARGS ""
ENV PAPER_ARGS ""

VOLUME "/data"

CMD ["paper"]
