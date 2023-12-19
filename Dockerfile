## CentOS 7 base image
FROM centos:7

#Update the package manager and install necessary dependencies
RUN yum -y update && yum -y install curl sudo

## Install Git
RUN yum -y update && yum -y install git

## Use base image of playwright
FROM mcr.microsoft.com/playwright:v1.24.0-focal

USER root
RUN mkdir /tests
COPY . /tests
WORKDIR /tests

## Set variable for clone url
ARG GITHUB_URL
ARG BRANCH_NAME
#ENV GITHUB_URL ="https://github.com/Harishk9697/playwright-test-suite.git"
RUN echo "Git Url: $GITHUB_URL"
RUN echo "Git Branch name: $BRANCH_NAME"
## Clone the Github repository
Run git clone --single-branch --branch $BRANCH_NAME $GITHUB_URL /tests/playwright_repo

WORKDIR /tests/playwright_repo

## Install Playwright dependencies
RUN npm install

## Install dependencies
RUN npx @playwright/test install
Run npx playwright install-deps

## RUN tests
RUN npx playwright test

## Copy generated report to s3 bucket
RUN aws s3 cp /tests/playwright_repo/playwright-report s3://tf-rf-scripts-spe-qaqc-bucket/output

## Default command to execute playwright test
#CMD ["npx", "playwright", "test"]