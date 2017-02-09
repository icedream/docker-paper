FROM java:8-alpine

ARG MINECRAFT_VERSION=1.11.2
ARG PAPER_BUILD=1053
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=5ac79f3061bc252aea9022d3b6207da87e30f0f7899577f27eb0e5bb7e9c6f3a8548bb9c113224590ef9067a63b122250034c8beb1b4175ade087860b3474464

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
