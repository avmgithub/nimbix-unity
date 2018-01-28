FROM ubuntu/16.04

ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh && rm -f /tmp/install-ubuntu.sh

COPY NAE/help.html /etc/NAE/help.html

COPY NAE/AppDef.json /etc/NAE/AppDef.json

RUN apt-get update
RUN apt-get install wget -y

RUN apt-get install -y openssh-server

#RUN wget http://beta.unity3d.com/download/fd37f3680b5f/unity-editor-installer-2017.2.0b11.sh
