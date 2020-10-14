FROM ubuntu:latest
LABEL MAINTAINER Gary Leong

# install java
RUN apt-get -y update && \
    apt-get -y install openjdk-8-jdk wget

RUN mkdir /usr/local/tomcat

ENV TOMCAT_VERSION 8.5.59
ENV TOMCAT_DOWNLOAD_SITE https://downloads.apache.org/tomcat/tomcat-8/v${TOMCAT_VERSION} 

# install tomcat
RUN wget ${TOMCAT_DOWNLOAD_SITE}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    -O /tmp/tomcat.tar.gz

RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-${TOMCAT_VERSION}/* /usr/local/tomcat/
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run

# install jar/war file
ADD sample.war /usr/local/tomcat/webapps/

# export port
EXPOSE 8080

# start up tomcat
CMD ["catalina.sh", "run"]

