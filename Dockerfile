FROM debian:wheezy

RUN echo "deb http://http.us.debian.org/debian testing main" > /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends libgomp1 libc6-dev wget && \
    rm -rf /var/lib/apt/lists/*

ENV TAR http://sourceforge.net/projects/hyda/files/squeezambler-2.0.3-hyda-1.3.1.tar.gz
ENV DIR /opt/squeezambler

RUN mkdir ${DIR}
RUN wget ${TAR} -O - | tar xzf - --directory ${DIR} --strip-components=1
RUN ln -s ${DIR}/bin/* /usr/local/bin/

ADD run /usr/local/bin/
ADD Procfile /

ENTRYPOINT ["run"]
