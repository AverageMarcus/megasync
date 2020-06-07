FROM ubuntu:19.10

RUN apt-get update && apt-get install -y curl
RUN curl -o megacmd-xUbuntu_19.10_amd64.deb https://mega.nz/linux/MEGAsync/xUbuntu_19.10/amd64/megacmd-xUbuntu_19.10_amd64.deb
RUN apt install -y ./megacmd-xUbuntu_19.10_amd64.deb

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN adduser --disabled-password --gecos '' mega && adduser mega sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER mega

WORKDIR /home/mega

ENV PASSWORD=
ENV EMAIL=

CMD /entrypoint.sh
