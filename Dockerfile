FROM java:8-alpine

ARG MINECRAFT_VERSION=1.11.2
ARG PAPER_BUILD=1046
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=6ae0b9439599b9bdfe53d3d2ff3e1f06baf651a97c9268e9a9106ef07be45705651ff75ad77183ea1f67566ad95bda79e4a603ee94efeff35fab6304066c4b31

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
