# CentOS 7 base image
FROM centos:7

#Use base image of playwright
FROM mcr.microsoft.com/playwright:v1.40.0-jammy

USER root
RUN mkdir /tests
COPY . /tests
WORKDIR /tests

#Install Playwright dependencies
RUN npm install

# Install dependencies
RUN npx @playwright/test install

#RUN tests
Run npx playwright install-deps
RUN npx playwright test