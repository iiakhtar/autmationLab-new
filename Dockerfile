# CentOS 7 base image
FROM centos:7

#Use base image of playwright
#FROM mcr.microsoft.com/playwright:v1.40.0-jammy

#Install required dependencies
RUN yum -y update && yum -y install curl

#Install node.js
Run curl -sL https://rpm.nodesource.com/setup_18.x | bash -
RUN yum -y install nodejs


USER root
RUN mkdir /tests
COPY . /tests
WORKDIR /tests

#Install Playwright dependencies
#RUN npm ci

# Install dependencies
#RUN npx @playwright/test install
#Run npx playwright install-deps
Run npx playwright install --with-deps

#RUN tests
RUN npx playwright test

#Default command to execute playwright test
CMD ["npx", "playwright", "test"]