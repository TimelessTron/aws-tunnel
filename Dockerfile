FROM amazon/aws-cli:2.27.23

RUN yum install -y git 
RUN yum install -y curl
RUN yum install -y tar
RUN curl -L https://github.com/bats-core/bats-core/archive/refs/tags/v1.11.0.tar.gz | tar xz && \
    cd bats-core-1.11.0 && \
    ./install.sh /usr/local && \
    cd .. && \
    rm -rf bats-core-1.11.0

RUN mkdir -p /opt/bats-libs && \
    git clone --depth=1 https://github.com/bats-core/bats-support.git /app/test/helpers/bats-libs/bats-support && \
    git clone --depth=1 https://github.com/bats-core/bats-assert.git /app/test/helpers/bats-libs/bats-assert

RUN yum install -y vim
RUN yum install -y python3
RUN yum install -y pip
RUN yum install -y groff
RUN yum install -y jq
RUN yum install -y grep
RUN yum install -y coreutils
RUN pip3 install --upgrade pip
RUN pip3 install aws-okta-processor
RUN yum clean all
RUN yum install -y https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm

WORKDIR /app

CMD ["tail", "-f", "/dev/null"]
