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
RUN echo "Git Url: $REPO_URL"
## fetch repo name
RUN REPO_NAME=$(basename -s .git $REPO_URL)
#ARG REPO_NAME
RUN echo "Repositor Name: $REPO_NAME"
## Clone the Github repository
Run git clone $REPO_URL

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