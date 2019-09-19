FROM jenkins/jenkins:2.195

USER root

# Install packages to allow apt to use a repository over HTTPS:
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
        gnupg2 \
        software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        docker-ce-cli=5:19.03.2~3-0~debian-stretch \
    && rm -rf /var/lib/apt/lists/*

USER jenkins