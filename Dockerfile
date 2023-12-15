## CentOS 7 base image
#FROM centos:7

## Use base image of playwright
#FROM mcr.microsoft.com/playwright:v1.40.0-jammy
FROM mcr.microsoft.com/playwright:v1.24.0-focal

USER root
RUN mkdir /tests
COPY . /tests
WORKDIR /tests

## Install Playwright dependencies
#RUN npm ci
RUN npm install

## Install dependencies
RUN npx @playwright/test install
Run npx playwright install-deps
#Run npx playwright install --with-deps

## RUN tests
RUN npx playwright test

## Default command to execute playwright test
CMD ["npx", "playwright", "test"]