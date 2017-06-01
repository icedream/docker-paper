FROM java:8-alpine

ARG MINECRAFT_VERSION=1.12-pre5
ARG PAPER_BUILD=12
ARG PAPER_URL=https://ci.destroystokyo.com/job/Paper-1.12-Pre-release/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=f9a4c80236a2c0a4ee30c9af46ba5b6aefed84ec13ae9cc7c89ba596c242c7f314777008ce51bb8bda2812fa198ca9860ff32c92b02b560a0688701a91f42f96

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
