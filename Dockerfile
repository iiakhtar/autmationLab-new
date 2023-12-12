# CentOS 7 base image
FROM centos:7

LABEL org.label-schema.schema-version=1.0 org.label-schema.name="CentOS Base"

#Update the package manager and install necessary dependencies
RUN yum -y update && yum -y install curl sudo

#Install Node.js
RUN curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
RUN yum install -y nodejs

#Create a directory for your application
WORKDIR /app

#Install playwright
#RUN npm init playwright@latest
RUN npm install -g playwright

COPY test.spec.js /app
COPY playwright.config.js /app
CMD ["node", "test.spec.js"]
