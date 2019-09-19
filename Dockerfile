FROM jenkins/jenkins:2.195

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ruby \
        ruby-dev \
        make \
        gcc \
        libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# install Capistrano and another dependencies
RUN gem install --no-document --minimal-deps \
        capistrano:3.11.1 \
        bundler \
        capistrano-composer \
        capistrano-file-permissions \
        capistrano-harrow \
        capistrano-symfony \
        rollbar

USER jenkins

# increase workers count to 5
COPY init.groovy.d/executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy