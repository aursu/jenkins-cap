FROM jenkins/jenkins:2.195-centos

USER root
# Software collections from the CentOS SCLo SIG
RUN yum -y install \
        centos-release-scl-rh \
        centos-release-scl \
    && yum clean all && rm -rf /var/cache/yum /var/lib/rpm/__db*

# install ruby 2.5
RUN yum -y install rh-ruby25 \
    && scl enable rh-ruby25 bash \
    && yum clean all && rm -rf /var/cache/yum /var/lib/rpm/__db*

# install Capistrano and another dependencies
RUN gem install --no-document --minimal-deps \
        capistrano:3.11.1 \
        bundler \
        capistrano-composer \
        capistrano-file-permissions \
        capistrano-harrow \
        capistrano-symfony \
        net-scp \
        net-ssh \
        rollbar

USER jenkins

# increase workers count to 5
COPY init.groovy.d/executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy