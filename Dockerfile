FROM aursu/jenkins:2.204-docker-19.03.4-b1

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ruby \
        ruby-dev \
        make \
        gcc \
        libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# upgrade rubygems
RUN gem update --system --no-document

# install Capistrano and another dependencies
RUN gem install --no-document --minimal-deps \
        capistrano:3.11.2 \
        bundler \
        capistrano-composer \
        capistrano-file-permissions \
        capistrano-harrow \
        capistrano-symfony \
        io-console

USER jenkins

# increase workers count to 5
COPY init.groovy.d/executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
