## Example Dropwizard application image
#
FROM ubuntu:14.04
MAINTAINER pablo.rodriguez prodriguezdefino@gmail.com

# Set correct source list
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-updates main universe" >> /etc/apt/sources.list

# add the python properties so we can add repos afterwards and also the utility to auto-accept licenses, some dev tools too
RUN apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common debconf-utils 

# auto-acept oracles jdk license
RUN /bin/echo -e oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections

# add JDK8 repository
RUN add-apt-repository -y ppa:webupd8team/java

# install Oracle JDK 8
RUN apt-get update && apt-get upgrade -y --force-yes && apt-get install -y --force-yes oracle-java8-installer  

# set java environment variables
RUN apt-get install oracle-java8-set-default

ADD app/ /

CMD java -jar dropwizard-example-1.0.0-SNAPSHOT.jar server example.yml
