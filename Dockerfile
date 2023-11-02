FROM centos:7

LABEL org.label-schema.schema-version=1.0 org.label-schema.name="CentOS Base"
RUN yum -y install epel-release
RUN yum -y update
RUN yum install wget -y
RUN yum install unzip -y

#downloading and installating chrome driver and browser
WORKDIR /usr/bin

#RUN  wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/119.0.6045.105/linux64/chromedriver-linux64.zip
#RUN  unzip chromedriver-linux64.zip -d /usr/bin
#RUN  mv chromedriver-linux64/chromedriver /usr/bin/chromedriver
#RUN chmod +x /usr/bin/chromedriver

#download chrome driver ---not tested
RUN CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
wget https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip && \
unzip chromedriver_linux64.zip -d /usr/bin && \
chmod +x /usr/bin/chromedriver && \rm chromedriver_linux64.zip
 
# install headless chrome
RUN curl -O  https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
RUN yum install google-chrome-stable_current_x86_64.rpm -y
RUN  mv /usr/bin/google-chrome-stable /usr/bin/google-chrome

#install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && ./aws/install

#virtual env pip
#RUN yum install https://repo.ius.io/ius-release-el$(rpm -E '%{rhel}').rpm
RUN yum update -y
RUN yum install -y python3

#setting python environment
RUN python3 -m venv /automation_Robot_app 
RUN source /automation_Robot_app/bin/activate

WORKDIR /automation_Robot_app
#installing pip
RUN yum install python3-pip
RUN python3 -m pip install --upgrade pip 
RUN pip install robotframework==5
RUN pip install wheel==0.37.0 
#RUN pip install robotframework-ride==2.0.6 
RUN pip install robotframework-selenium2library==3.0.0 
RUN pip install robotframework-seleniumlibrary==5.1.3
RUN pip install selenium==3.141.0 
RUN pip install setuptools==47.1.0 


# Install anything. The service you want to start must be a SystemD service.

CMD ["robot", "--outputdir tmp", "/tmp/aut-rf-jeopardy4/JEOPARDY/TestCases/About/About.robot"]
#SSM
#RUN yum install -y -d0 -e0 https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
#RUN systemctl start amazon-ssm-agent

#copy file from S3 bucket to ec2
#RUN aws s3 cp s3://tf-rf-scripts-spe-qaqc-bucket/scripts/TestSuite.robot testsuite.robot
#RUN aws s3 cp s3://tf-rf-scripts-spe-qaqc-bucket/scripts/aut-rf-spt temp --recursive
#Robot Specific
#RUN mkdir /robot
#RUN mkdir /results
#ENTRYPOINT ["robot"]
