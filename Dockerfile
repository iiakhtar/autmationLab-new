FROM centos:7

LABEL org.label-schema.schema-version=1.0 org.label-schema.name="CentOS Base"

RUN yum -y install epel-release update wget unzip git

#downloading and installating chrome driver and browser
WORKDIR /usr/bin

RUN  wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/119.0.6045.105/linux64/chromedriver-linux64.zip
RUN  unzip chromedriver-linux64.zip -d /usr/bin
RUN  mv chromedriver-linux64/chromedriver /usr/bin/chromedriver
RUN chmod +x /usr/bin/chromedriver
 
# install headless chrome
RUN curl -O  https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
RUN yum install google-chrome-stable_current_x86_64.rpm -y
RUN  mv /usr/bin/google-chrome-stable /usr/bin/google-chrome

#install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip && ./aws/install

RUN yum update -y
RUN yum install -y python3

#setting python environment
RUN python3 -m venv /automation_Robot_app 
RUN source /automation_Robot_app/bin/activate

WORKDIR /automation_Robot_app
COPY test2.sh .
RUN chmod +x test2.sh
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

CMD ["sh", "test2.sh"]

#copy file from S3 bucket to ec2
#RUN aws s3 cp s3://tf-rf-scripts-spe-qaqc-bucket/scripts/TestSuite.robot testsuite.robot
#RUN aws s3 cp s3://tf-rf-scripts-spe-qaqc-bucket/scripts/aut-rf-spt temp --recursive
