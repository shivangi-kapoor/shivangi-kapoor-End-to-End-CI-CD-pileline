FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    docker.io

# Add Jenkins user to the docker group
RUN groupadd -f docker && usermod -aG docker jenkins

USER jenkins