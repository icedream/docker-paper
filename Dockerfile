FROM java:8-alpine

ARG MINECRAFT_VERSION=1.11.2
ARG PAPER_BUILD=1084
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=02c2bad92cf22a934a8f9609bc1284a17b4588f4ee9ebeb06881eccda16f5d6a0ae7fd43d994f94ed2b5f31cffd525a438acfd28875ada7c121a69b20e5ebb5a

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
