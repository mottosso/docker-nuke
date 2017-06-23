# BYOL distribution of Nuke, command-line only, for continuous integration

FROM centos:6.6
MAINTAINER Marcus Ottosson <konstruktion@gmail.com>

RUN yum -y update && \
    yum -y groupinstall "X Window System" "Fonts" && \
    yum -y install \
    	wget \
    	unzip \
    	mesa-libGLU \
    	alsa-lib \
    	libpng12 \
    	SDL \
    	xorg-x11-server-Xvfb

ENV NK_VERSION 9.0v4
ENV NK_MAJOR_RELEASE 9.0

# Install Nuke itself.
RUN wget -P /tmp/ \
    http://thefoundry.s3.amazonaws.com/products/nuke/releases/$NK_VERSION/Nuke$NK_VERSION-linux-x86-release-64.tgz && \
    tar xvzf /tmp/Nuke$NK_VERSION-linux-x86-release-64.tgz -C /tmp && \
	rm -f /tmp/Nuke$NK_VERSION-linux-x86-release-64.tgz && \
	unzip /tmp/Nuke$NK_VERSION-linux-x86-release-64-installer -d Nuke$NK_VERSION && \
	rm -f /tmp/Nuke$NK_VERSION-linux-x86-release-64-installer

# Create a User and switch to it. Nuke does not work well under root User.
RUN groupadd -r nuke && \
    useradd -r -g nuke nuke

ENV FOUNDRY_LICENSE_FILE /usr/local/foundry/FLEXlm
ENV NUKE_DISK_CACHE /tmp/nuke
ENV DISPLAY :99

USER nuke

ENTRYPOINT Xvfb :99 -screen 0 1024x768x16 2>/dev/null & \
    while ! ps aux | grep -q '[0]:00 Xvfb :99 -screen 0 1024x768x16'; \
        do echo "Waiting for Xvfb..."; sleep 1; done && \
    Nuke$NK_VERSION/Nuke$NK_MAJOR_RELEASE
