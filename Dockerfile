FROM openshift/jenkins-slave-base-centos7

MAINTAINER Raffaele Spazzoli <rspazzol@redhat.com>

# Labels consumed by Red Hat build service
LABEL com.redhat.component="jenkins-slave-skopeo-centos7" \
      name="openshift3/jenkins-slave-skopeo-centos7" \
      version="3.3" \
      architecture="x86_64" \
      release="4" \
      io.k8s.display-name="Jenkins Slave Skopeo" \
      io.k8s.description="The jenkins slave image has the skopeo tools on top of the jenkins slave base image." \
      io.openshift.tags="openshift,jenkins,slave,skopeo"

USER root

ENV SKOPEO_BIN=https://github.com/sabre1041/ocp-support-resources/blob/master/skopeo/bin/skopeo?raw=true

USER root

#COPY /skopeo /usr/bin/
COPY /policy.json /etc/containers/

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME && \
    curl -L -o /usr/bin/skopeo $SKOPEO_BIN && \
    chown -R 1001:0 /etc/containers && \
    chmod -R g+rw /etc/containers && \
    chmod -R o+x /usr/bin/skopeo

USER 1001
