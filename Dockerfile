#using arm64 architecture. Take this out to default to os
FROM --platform=linux/arm64 ubuntu:24.04

RUN apt update
RUN apt upgrade -y
RUN apt install curl -y
RUN apt install wget -y
#RUN apt-get install default-jre -y
RUN apt install default-jdk -y
RUN mkdir /var/install
RUN mkdir /var/settings
RUN mkdir /var/minecraft
#need to agree to the eula
COPY ./startup.sh /var/startup.sh
COPY ./restore.sh /var/restore.sh
COPY ./backup.sh /var/backup.sh
COPY ./settings/ /var/settings/
RUN echo 'eula=true' > /var/install/eula.txt
#ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "/var/minecraft/server.jar"]
WORKDIR /
ENTRYPOINT [ "bash", "/var/startup.sh"]
