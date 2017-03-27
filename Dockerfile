FROM java:8-alpine

ARG MINECRAFT_VERSION=1.11.2
ARG PAPER_BUILD=1070
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=9b03b646435e31266ab27bfd4d79dc48956819c5a54028e4e299b1346342efa731c88d446054bfe95ab0ab6b62c80bb3dab33ef754c7ce4cb17e87f1676a7c89

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
