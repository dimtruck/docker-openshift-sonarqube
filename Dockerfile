FROM centos:7
MAINTAINER Wolfgang Kulhanek <wkulhane@redhat.com>

ENV SONAR_VERSION=6.7.1 \
    SONARQUBE_HOME=/opt/sonarqube

LABEL name="SonarQube" \
      io.k8s.display-name="SonarQube" \
      io.k8s.description="Provide a SonarQube image to run on Red Hat OpenShift" \
      io.openshift.expose-services="9000" \
      io.openshift.tags="sonarqube" \
      build-date="2017-12-21" \
      version=$SONAR_VERSION \
      release="1"

USER root
EXPOSE 9000
RUN yum -y install epel-release \
    && yum repolist \
    && yum -y update \
    && yum -y install unzip java-1.8.0-openjdk nss_wrapper \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && cd /tmp \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && cd /opt \
    && unzip /tmp/sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm /tmp/sonarqube.zip*
ADD root /

