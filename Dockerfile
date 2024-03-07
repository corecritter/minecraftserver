FROM ubuntu:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install curl -y
RUN apt-get install default-jre -y
RUN apt-get install default-jdk -y
RUN mkdir /minecraft
WORKDIR /minecraft
#need to agree to the eula
#RUN touch eula.txt
RUN echo 'eula=true' > eula.txt
#this url might change with newer versions?
RUN curl https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar --output /minecraft/server.jar
ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "/minecraft/server.jar", "nogui"]