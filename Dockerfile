FROM ubuntu:22.04

# Grundpakete installieren
RUN apt-get update && apt-get install -y \
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
    lsb-release \
    gnupg \
    software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# AWS CLI v2 installieren
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install && \
    rm -rf awscliv2.zip aws

# Python-Pakete installieren
RUN pip3 install --upgrade pip && \
    pip3 install aws-okta-processor

# MySQL Server direkt aus Ubuntu Repo installieren
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# AWS Session Manager Plugin
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb" && \
    dpkg -i session-manager-plugin.deb && rm session-manager-plugin.deb

WORKDIR /app

CMD ["tail", "-f", "/dev/null"]
