FROM java:8-alpine

ARG MINECRAFT_VERSION=1.12-pre2
ARG PAPER_BUILD=10
ARG PAPER_URL=https://ci.destroystokyo.com/job/Paper-1.12-Pre-release/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=2cf8de6b8ac8b7c09f125665a90a3bb5721cc2edf6a3205d49f0cbfe37556647f2a49de7e3bcd646c599828ff9e917c75332fe7d701ae23777948a07779f58de

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
