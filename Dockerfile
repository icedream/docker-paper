FROM java:8-alpine

ARG MINECRAFT_VERSION=1.12
ARG PAPER_BUILD=1138
ARG PAPER_URL=https://ci.destroystokyo.com/job/PaperSpigot/${PAPER_BUILD}/artifact/paperclip-${PAPER_BUILD}.jar
ARG PAPER_SHA512=0a723fdafd21d9ffede1c181bf3ba0be8392f1596dedc3ab0a8c0545c69bd72f82b969a7320b056597e0c5e3a32f25327154c83cfafce9171cda249d89eed8e6

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
