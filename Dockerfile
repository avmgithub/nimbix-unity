FROM nimbix/ubuntu-cuda:latest
#FROM nvidia/opengl:1.0-glvnd-devel-ubuntu16.04
#FROM ubuntu:xenial
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
#RUN curl http://beta.unity3d.com/download/7807bc63c3ab/UnitySetup-2017.3.0p2 --output UnitySetup-2017.3.0p2
RUN curl http://beta.unity3d.com/download/ad31c9083c46/unity-editor_amd64-2017.2.0f1.deb --output unity-editor_amd64-2017.2.0f1.deb
#RUN curl http://beta.unity3d.com/download/ddd95e743b51/unity-editor_amd64-5.6.2xf1Linux.deb --output unity-editor_amd64-5.6.2xf1Linux.deb 
#RUN sudo chmod +x ./UnitySetup-2017.3.0p2
#RUN echo y | sudo ./UnitySetup-2017.3.0p2 --unattended --install-location=/opt/Unity --components Unity,Documentation,StandardAssets,WebGL

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash && sudo apt-get install git-lfs && sudo git lfs install
RUN git clone https://github.com/udacity/self-driving-car-sim.git

ADD NAE/help.html /etc/NAE/help.html
ADD NAE/AppDef.json /etc/NAE/AppDef.json

RUN sudo chmod  u+s /usr/lib/libdlfaker.so /usr/lib/libvglfaker.so

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22

# for standalone use
EXPOSE 5901
EXPOSE 443
