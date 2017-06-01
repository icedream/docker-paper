FROM java:8-alpine

ARG MINECRAFT_VERSION=1.12-pre5
ARG PAPER_BUILD=13
ARG PAPER_URL=https://ci.destroystokyo.com/job/Paper-1.12-Pre-release/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=041583fff7da9699cf252b593a58b884f6d3555ee403555580b605ca0355945a9a5b6a0831572f32948b1cec53bacd1aa92e079ca41f1477d290fc9d492b9fbf

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
