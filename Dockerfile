FROM debian:wheezy

ENV PACKAGES libgomp1 libc6-dev wget make g++
ENV TAR http://sourceforge.net/projects/hyda/files/squeezambler-2.0.3-hyda-1.3.1.tar.gz
ENV DIR /opt/squeezambler

RUN echo "deb http://http.us.debian.org/debian testing main" > /etc/apt/sources.list
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends ${PACKAGES} && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir ${DIR}
RUN cd ${DIR} && \
    wget ${TAR} -O - | tar xzf - --directory . --strip-components=1 && \
    make clean
RUN cd ${DIR} && \
    make MAXK=128 MAXCOLORS=4 && \
    ln -s ${DIR}/bin/* /usr/local/bin/

ADD run /usr/local/bin/
ADD Procfile /

ENTRYPOINT ["run"]
