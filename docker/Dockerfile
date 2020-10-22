FROM ubuntu:latest

RUN apt update
RUN apt-get install -y git build-essential automake libevent-dev libssl-dev zlib1g-dev python3.8 pkg-config liblzma-dev libzstd-dev
RUN useradd -ms /bin/bash tor
RUN git clone https://gitlab.com/torproject/tor.git /home/tor/tor/
COPY config/auths_dir.inc /home/tor/tor/src/app/config/auths_dir.inc
RUN cd home/tor/tor && ./autogen.sh
RUN cd home/tor/tor && ./configure --disable-asciidoc && make
RUN cd home/tor/tor && make install
USER tor
EXPOSE 9050
EXPOSE 80
EXPOSE 443

VOLUME ["/var/lib/tor"]

CMD ["tor"]