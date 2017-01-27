FROM java:8-alpine

ARG MINECRAFT_VERSION=1.8.8
ARG PAPER_BUILD=443
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/${PAPER_BUILD}/artifact/paperclip-1.8.8-fix.jar
ARG PAPER_SHA512=cee5f076fe587c1cd483c4b0dbcab1af555aded44318c0037b80d767f754cc4ed1b12d09a4a26d06833b6647a7b68df0d4209f9b94d0d470bfbe88ade0e53fb1

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
