FROM java:8-alpine

ARG MINECRAFT_VERSION=1.11.2
ARG PAPER_BUILD=1080
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=61e57f9cc3ba2e7e780bb6708429be80f89ad4bede42b106bc4b8305094db582a8d089845d21702bc8baa3d12759b95122d72a06901a3241b03b0a3dbee59649

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
