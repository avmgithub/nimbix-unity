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

RUN apt-get install -y libnspr4 libnss3 libpango1.0-0  xdg-utils libpq5 npm
RUN curl http://beta.unity3d.com/download/7807bc63c3ab/UnitySetup-2017.3.0p2 --output UnitySetup-2017.3.0p2
RUN curl http://beta.unity3d.com/download/ad31c9083c46/unity-editor_amd64-2017.2.0f1.deb --output unity-editor_amd64-2017.2.0f1.deb
#RUN sudo chmod +x ./UnitySetup-2017.3.0p2
#RUN echo y | sudo ./UnitySetup-2017.3.0p2 --unattended --install-location=/opt/Unity --components Unity,Documentation,StandardAssets,WebGL

ADD NAE/help.html /etc/NAE/help.html
ADD NAE/AppDef.json /etc/NAE/AppDef.json

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22

# for standalone use
EXPOSE 5901
EXPOSE 443
