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
#this url might change with newer versions?
RUN curl https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar --output /var/install/server.jar
#ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "/var/minecraft/server.jar"]
WORKDIR /
ENTRYPOINT [ "bash", "/var/startup.sh"]
