FROM ubuntu:14.04

MAINTAINER Pratee Naik <prateeknaik032@gmail.com>

#Install Java-8
ENV JAVA_VER 8
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    echo 'deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886 && \
    apt-get update && \
    echo oracle-java${JAVA_VER}-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
    apt-get install -y --force-yes --no-install-recommends oracle-java${JAVA_VER}-installer oracle-java${JAVA_VER}-set-default && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists && \
    rm -rf /var/cache/oracle-jdk${JAVA_VER}-installer

RUN apt-get update && \
    #apt-get install -y git build-essential curl wget software-properties-common && \
    apt-get install -yq --no-install-recommends pwgen ca-certificates && \
    apt-get install -yq --no-install-recommends libtcnative-1 && \
    apt-get install net-tools wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#Set environment for tomcat
ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_MINOR_VERSION 8.0.39
ENV CATALINA_HOME /tomcat
ENV JAVA_OPTS ""
ENV TOMCAT_BIND_ON_INIT true

# INSTALL TOMCAT
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz && \
    mv apache-tomcat* tomcat && \
    rm -fr tomcat/webapps/examples && \
    rm -fr tomcat/webapps/docs && \
    sed -i "s/Connector port=\"8080\"/Connector port=\"8080\" bindOnInit=\"${TOMCAT_BIND_ON_INIT}\"/" tomcat/conf/server.xml

ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
#Based on the war file location make changes to the below line
#COPY ./target/*.war /tomcat/webapps

EXPOSE 8080
CMD ["/run.sh"]
