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

RUN yum install -y \
    libatk1.0-0 \                     
    libatk-bridge2.0-0 \                          
    libcups2 \                                    
    libdrm2 \                                     
    libxcb1 \                                     
    libxkbcommon0 \                               
    libatspi2.0-0 \                               
    libx11-6 \                                    
    libxcomposite1 \                              
    libxdamage1 \                                 
    libxext6 \                                    
    libxfixes3 \                                  
    libxrandr2 \                                  
    libgbm1 \                                     
    libpango-1.0-0 \                              
    libcairo2 \                                   
    libasound2 

## Unzip installation
RUN yum install -y unzip

## Install Git
RUN yum install -y git

## Install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip && ./aws/install

## Check version
RUN aws --version

## Install Playwright dependencies
#RUN npm install

## Use base image of playwright
#FROM mcr.microsoft.com/playwright:v1.24.0-focal

#COPY --from=centos /tests /tests

#WORKDIR /tests

## Install browser
RUN npx @playwright/test install

## Install dependencies
#Run npx playwright install-deps

## List the files
RUN ls /tests

## Make the script executable
RUN chmod +x test.sh

## Default command to execute playwright test
CMD ["sh", "test.sh"]
