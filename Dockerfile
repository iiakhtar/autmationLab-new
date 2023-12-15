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
ENV REPO_URL = $(echo "https://github.com/Harishk9697/playwright-test-suite.git")
## fetch repo name
RUN REPO_NAME=$(basename -s .git $REPO_URL)
echo "Repositor Name"
## Clone the Github repository
Run git clone --single-branch --branch main $REPO_URL

WORKDIR /tests/$REPO_NAME

## Install Playwright dependencies
RUN npm install

## Install dependencies
RUN npx @playwright/test install
Run npx playwright install-deps

## RUN tests
#RUN npx playwright test

## Default command to execute playwright test
CMD ["npx", "playwright", "test"]