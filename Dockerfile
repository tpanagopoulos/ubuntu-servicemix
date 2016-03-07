FROM ubuntu:14.04

MAINTAINER Thodoris Panagopoulos <thodoris.panagopoulos@gmail.com> version: 0.1

# Install dependencies
RUN \
  apt-get update && \
  apt-get install -y software-properties-common python-software-properties unzip

# Install Java
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Define working directory.
WORKDIR /opt/

# Download, extract ServiceMix
RUN \
  wget http://mirrors.muzzy.org.uk/apache/servicemix/servicemix-7/7.0.0.M1/apache-servicemix-7.0.0.M1.zip && \
  unzip apache-servicemix-7.0.0.M1.zip && \
  rm -rf apache-servicemix-7.0.0.M1.zip && \
  ln -s apache-servicemix-7.0.0.M1 servicemix

# Define working directory.
WORKDIR /opt/servicemix

# Execute ServiceMix, Install features
RUN \
  bin/start && \
  sleep 15 && \
  bin/client feature:install webconsole && \
  bin/client feature:repo-add hawtio 1.4.61 && \
  bin/client feature:install hawtio-core

EXPOSE 8181:8181

CMD ["bin/servicemix"]
