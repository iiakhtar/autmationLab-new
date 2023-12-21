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

RUN yum install -y epel-release && \
    yum install -y \
    libatk \                  
    libatk-bridge \                       
    libcups \                                   
    libdrm \                                     
    libxcb \
    libXcursor \                                    
    libxkbcommon \                              
    libatspi \                              
    libX11 \                                    
    libXcomposite \                              
    libXdamage \                               
    libXext \                                    
    libXfixes \                                  
    libXrandr \                                  
    libgbm \                                   
    libpango \                              
    libcairo \
    libXi \
    libXtst \
    libXrender \
    libXScrnSaver \                            
    libasound \
    liberation-fonts

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
RUN npx playwright install chromium
 
## Install dependencies
#Run npx playwright install-deps

## List the files
RUN ls /tests

## Make the script executable
RUN chmod +x test.sh

## Default command to execute playwright test
CMD ["sh", "test.sh"]
