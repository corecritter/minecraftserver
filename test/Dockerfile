#using arm64 architecture. Take this out to default to os
FROM ubuntu:24.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl -y
RUN mkdir /var/data
COPY ./startup.sh /var/data/backup.sh
WORKDIR /
ENTRYPOINT [ "bash", "/var/data/backup.sh" ]
