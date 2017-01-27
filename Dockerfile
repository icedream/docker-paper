FROM java:8-alpine

ARG MINECRAFT_VERSION=1.10.2
ARG PAPER_BUILD=916.2
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/916/artifact/paperclip-916.2.jar
ARG PAPER_SHA512=98ceca322a136ac43e4666d5cc3137923ea610ed924efc309c0d05a1556dc15564298746448883ffb9ceb85666d6ee85538dfb92044d5dac63d442f83861159e

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
