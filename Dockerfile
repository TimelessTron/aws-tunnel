FROM amazonlinux:2

# Systemupdates + wichtige Tools + MySQL Repo + SSM Plugin
RUN yum update -y && \
    yum install -y \
        curl \
        tar \
        vim \
        python3 \
        python3-pip \
        groff \
        jq \
        grep \
        coreutils \
        unzip \
        https://dev.mysql.com/get/mysql80-community-release-el7-11.noarch.rpm \
        https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm && \
    yum clean all

# AWS CLI v2 installieren
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install && \
    rm -rf awscliv2.zip aws

# Python-Pakete installieren
RUN pip3 install --upgrade pip && \
    pip3 install aws-okta-processor

# MySQL Server installieren
RUN yum install -y mysql-community-server && \
    yum clean all

WORKDIR /app

CMD ["tail", "-f", "/dev/null"]
