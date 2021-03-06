FROM ubuntu:19.10

RUN apt-get update && apt-get install -y curl ca-certificates
RUN adduser --disabled-password --gecos '' mega && adduser mega sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN curl -k -o /megacmd.deb https://mega.nz/linux/MEGAsync/xUbuntu_19.10/amd64/megacmd-xUbuntu_19.10_amd64.deb
RUN apt install -y ./megacmd.deb

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /home/mega

USER mega

ENV PASSWORD=
ENV EMAIL=

CMD /entrypoint.sh
