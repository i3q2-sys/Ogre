FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt-get -y install wget python3.6 unzip python3-pip
RUN wget https://releases.hashicorp.com/terraform/0.14.3/terraform_0.14.3_linux_amd64.zip
RUN unzip terraform_0.14.3_linux_amd64.zip
RUN mv ./terraform  /usr/local/bin/
RUN apt install -y software-properties-common
RUN apt update
RUN apt install -y ansible
RUN ansible-galaxy collection install amazon.aws --ignore-errors && pip3 install boto3 && pip3 install botocore