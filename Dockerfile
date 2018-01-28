FROM ubuntu:xenial
MAINTAINER Nimbix, Inc.

# Update SERIAL_NUMBER to force rebuild of all layers (don't use cached layers)
ARG SERIAL_NUMBER
ENV SERIAL_NUMBER ${SERIAL_NUMBER:-20180124.1405}

ARG GIT_BRANCH
ENV GIT_BRANCH ${GIT_BRANCH:-master}

RUN apt-get -y update && \
    apt-get -y install curl && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/nimbix/image-common/$GIT_BRANCH/install-nimbix.sh \
        | bash -s -- --setup-nimbix-desktop --image-common-branch $GIT_BRANCH

RUN curl http://beta.unity3d.com/download/fd37f3680b5f/unity-editor-installer-2017.2.0b11.sh --output unity.sh
ADD NAE/help.html /etc/NAE/help.html
ADD NAE/AppDef.json /etc/NAE/AppDef.json

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22

# for standalone use
EXPOSE 5901
EXPOSE 443
