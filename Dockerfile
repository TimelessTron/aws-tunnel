FROM amazon/aws-cli:2.27.23

RUN yum install -y git 
RUN yum install -y curl
RUN yum install -y tar

RUN yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-11.noarch.rpm
RUN yum install -y mysql
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
