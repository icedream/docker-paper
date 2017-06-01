FROM java:8-alpine

ARG MINECRAFT_VERSION=1.12-pre2
ARG PAPER_BUILD=7
ARG PAPER_URL=https://ci.destroystokyo.com/job/Paper-1.12-Pre-release/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=cc94f504951fe8491c383dea2ade4ac376281dc8772958a614b858db103a0d4a6ccee00cde9014b5e0418181b1ad45b1740671787b8692e2d1042d87889f52e3

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
