FROM java:8-alpine

ARG MINECRAFT_VERSION=1.10.2
ARG PAPER_BUILD=916.2
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=335fa5e89ad374f655acf4c71516d7eea6d5cf7b0b6b5c1d24df110349685ff33c5803df85371145000776a1080d6eb5c02ea03e5fd968ac84a88bf5e8ac7a79

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
