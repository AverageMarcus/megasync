FROM --platform=${BUILDPLATFORM:-linux/amd64} ubuntu:19.10 as builder

ARG BUILDPLATFORM
ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH

RUN apt-get update && apt-get install -y curl ca-certificates
RUN export URL="https://mega.nz/linux/MEGAsync/Raspbian_10.0/armhf/megacmd-Raspbian_10.0_armhf.deb" && \
    if [ "${TARGETARCH}" = "amd64" ] ; then export URL="https://mega.nz/linux/MEGAsync/xUbuntu_19.10/amd64/megacmd-xUbuntu_19.10_amd64.deb" ; fi && \
    curl -k -o /megacmd.deb $URL
RUN adduser --disabled-password --gecos '' mega && adduser mega sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh


FROM --platform=${TARGETPLATFORM:-linux/amd64} ubuntu:19.10
WORKDIR /home/mega

COPY --from=builder /etc/sudoers /etc/sudoers
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /entrypoint.sh /entrypoint.sh
COPY --from=builder /megacmd.deb /megacmd.deb
RUN apt install -y ./megacmd.deb

USER mega
ENV PASSWORD=
ENV EMAIL=
CMD /entrypoint.sh
