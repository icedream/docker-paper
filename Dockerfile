FROM java:8-alpine

ARG MINECRAFT_VERSION=1.12-pre2
ARG PAPER_BUILD=6
ARG PAPER_URL=https://ci.destroystokyo.com/job/Paper-1.12-Pre-release/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=1ff2be6a4039427506d41f2f3ca9f4152cf352e32d62446e71cf323d44a98fe589f169c4e3dfd2edf70eb40061b851007b81ec7dfe9a766df148a0d94dd6a72f

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
