FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    docker.io

# Stay as root
USER root