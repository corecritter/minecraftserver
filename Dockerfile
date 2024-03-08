FROM ubuntu:24.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl -y
#RUN apt-get install default-jre -y
RUN apt-get install default-jdk -y
RUN mkdir /var/install
RUN mkdir /var/settings
RUN mkdir /var/data
RUN mkdir /var/data/minecraft
#need to agree to the eula
COPY ./startup.sh /var/data/startup.sh
COPY ./settings/ /var/settings/
RUN echo 'eula=true' > /var/install/eula.txt
#this url might change with newer versions?
RUN curl https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar --output /var/install/server.jar
#ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "/var/data/minecraft/server.jar"]
WORKDIR /
ENTRYPOINT [ "bash", "/var/data/startup.sh" ]
