## CentOS 7 base image
#FROM centos:7

## Use base image of playwright
FROM mcr.microsoft.com/playwright:v1.24.0-focal

## Install Git
RUN apt-get update && apt-get install -y git

USER root
RUN mkdir /tests
COPY . /tests
WORKDIR /tests

## Set variable for clone url
ARG GITHUB_URL
#ENV GITHUB_URL ="https://github.com/Harishk9697/playwright-test-suite.git"
RUN echo "Git Url: $GITHUB_URL"
## Clone the Github repository
Run git clone $GITHUB_URL /tests/playwright_repo

WORKDIR /tests/playwright_repo

## Install Playwright dependencies
RUN npm install

## Install dependencies
RUN npx @playwright/test install
Run npx playwright install-deps

## RUN tests
#RUN npx playwright test

## Default command to execute playwright test
CMD ["npx", "playwright", "test"]