FROM java:8-alpine

ARG MINECRAFT_VERSION=1.12
ARG PAPER_BUILD=1173
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=8247e46dc76a332705255b21bf1b7e5bca14ef5e202aac5eb895f6dba7c27765ca5fd589b131ca69e2088a7561e0d936e6118660f2a1d979d68536e6e48155b4

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
