FROM debian:8.6
MAINTAINER @vando

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH $PATH:/home/hadoop/hadoop-2.7.1/bin
ENV HADOOP_CONF_DIR /home/hadoop/hadoop-2.7.1/etc/hadoop

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu yakkety main" | tee /etc/apt/sources.list.d/oreacle-java-8.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    oracle-java8-installer \
    krb5-user \
    unzip

RUN wget --header='Cookie: oraclelicense=accept-securebackup-cookie' --no-check-certificate \
    -P /root http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip
RUN unzip -oj -d ${JAVA_HOME}/jre/lib/security /root/jce_policy-8.zip

RUN rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk8-installer && \
    rm /root/jce_policy-8.zip

RUN useradd -mb /home -s /bin/bash hadoop

USER hadoop
WORKDIR /home/hadoop

RUN wget -qO - http://www-eu.apache.org/dist/hadoop/core/hadoop-2.7.1/hadoop-2.7.1.tar.gz | tar zxvf -
RUN find hadoop-2.7.1 -type f -name '*cmd' -exec rm {} \;

ADD core-site.xml hadoop-2.7.1/etc/hadoop/

RUN mkdir /home/hadoop/data

VOLUME ["/home/hadoop/data"]

CMD ["bash"]
