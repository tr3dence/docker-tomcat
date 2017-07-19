FROM tredence/docker-java

MAINTAINER Pratee Naik <prateeknaik032@gmail.com>

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

EXPOSE 8080
CMD ["/run.sh"]
