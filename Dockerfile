FROM java:8-alpine

ARG MINECRAFT_VERSION=1.9.4
ARG PAPER_BUILD=773
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=48807b68b318cd8ecc9fca5fb75dcab971595ad8471c4c2f41c3eed3042befa0ebd929f28fcd3c3618d5dd4984b9a33b5855a160e74d7a6262c98793b835c9d1

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
