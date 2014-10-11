FROM ubuntu
RUN apt-get update
RUN apt-get install -y libgomp1
#need to use wget instead of ADD to download squeezambler because it's hosted on sourceforge...
RUN apt-get install -y wget
RUN wget http://sourceforge.net/projects/hyda/files/squeezambler-2.0.3-hyda-1.3.1.tar.gz -O /opt/squeezambler.tar.gz
RUN mkdir /opt/squeezambler
RUN tar xzf /opt/squeezambler.tar.gz --directory /opt/squeezambler --strip-components=1
RUN ln -s /opt/squeezambler/bin/* /usr/local/bin/

ADD run /usr/local/bin/
ADD adaptive /usr/local/bin/
ADD Procfile /
