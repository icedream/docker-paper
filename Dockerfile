FROM java:8-alpine

ARG MINECRAFT_VERSION=1.12-pre5
ARG PAPER_BUILD=17
ARG PAPER_URL=https://ci.destroystokyo.com/job/Paper-1.12-Pre-release/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=294184ca13ee6b2f8bc00b8e421ad2b3fb806a00a4adf2a91176557f449c0501ccd3e74cb172ac6fdc40327c03e2a65bd0dfc00d9643407ef984646f3bf76735

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
