FROM jenkins/jenkins:2.195-centos

USER root
# Software collections from the CentOS SCLo SIG
RUN yum -y install \
        centos-release-scl-rh \
        centos-release-scl \
    && yum clean all && rm -rf /var/cache/yum /var/lib/rpm/__db*

# Install ruby 2.5
RUN yum -y install rh-ruby25 \
    && yum clean all && rm -rf /var/cache/yum /var/lib/rpm/__db*

ENV X_SCLS=rh-ruby25
ENV LD_LIBRARY_PATH=/opt/rh/rh-ruby25/root/usr/local/lib64:/opt/rh/rh-ruby25/root/usr/lib64
ENV PATH /opt/rh/rh-ruby25/root/usr/local/bin:/opt/rh/rh-ruby25/root/usr/bin:$PATH
ENV XDG_DATA_DIRS /opt/rh/rh-ruby25/root/usr/local/share:/opt/rh/rh-ruby25/root/usr/share:/usr/local/share:/usr/share
ENV PKG_CONFIG_PATH=/opt/rh/rh-ruby25/root/usr/local/lib64/pkgconfig:/opt/rh/rh-ruby25/root/usr/lib64/pkgconfig

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