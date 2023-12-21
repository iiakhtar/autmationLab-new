## CentOS 7 base image
FROM centos:7 AS centos

## Update the package manager and install necessary dependencies
RUN yum update -y && yum install -y curl sudo

## Add npm for package management
#RUN yum install -y npm

## Install Node.js
RUN curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
RUN yum -y install nodejs

## Unzip installation
RUN yum install -y unzip

## Install Git
RUN yum install -y git

## Install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip && ./aws/install

## Check version
RUN aws --version

USER root
RUN mkdir /tests
COPY . /tests
WORKDIR /tests

## Install Playwright dependencies
#RUN npm install

## Use base image of playwright
#FROM mcr.microsoft.com/playwright:v1.24.0-focal

#COPY --from=centos /tests /tests

WORKDIR /tests

## Install browser and dependencies
RUN npx @playwright/test install
Run npx playwright install-deps

## List the files
RUN ls /tests/playwright_repo

## RUN tests
RUN npx playwright test

## List the files
RUN ls /tests/playwright_repo

## List the files
RUN ls /tests/playwright_repo/playwright-report

## Default command to execute playwright test
CMD ["sh", "test.sh"]
