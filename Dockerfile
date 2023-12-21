## CentOS 7 base image
FROM centos:7 AS centos

USER root
RUN mkdir /tests
COPY . /tests
WORKDIR /tests

## Update the package manager and install necessary dependencies
RUN yum update -y && yum install -y curl sudo

## Install Node.js
RUN curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
RUN yum -y install nodejs

## Add npm for package management
RUN yum install -y npm

## Install Git
RUN yum install -y git

## Install Playwright dependencies
#RUN npm install

## Use base image of playwright
FROM mcr.microsoft.com/playwright:v1.24.0-focal

COPY --from=centos /tests /tests

WORKDIR /tests

RUN apt-get update && \
    apt-get install -y curl unzip

## Install browser
RUN npx playwright install chromium
 
## Install dependencies
Run npx playwright install-deps

## Install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip && ./aws/install

## Check version
RUN aws --version

## List the files
RUN ls /tests

## Make the script executable
RUN chmod +x test.sh

## Default command to execute playwright test
CMD ["sh", "test.sh"]
