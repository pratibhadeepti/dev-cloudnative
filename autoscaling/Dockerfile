#################################
# Docker file to create image to implement autoscaling
# ~Cloudibility.io
#################################

#Pull Centos 7 image from dockerhub
FROM centos:7

#Maintained by Cloudibility
MAINTAINER cloudibility.io

# Install dependencies on Centos Image
RUN yum install sudo -y && yum install wget -y && yum install make -y && yum -y install epel-release && yum clean all && yum -y install python-pip && yum clean all && yum install -y openssh-clients && yum -y install python-devel
RUN pip install ansible==2.6 && pip install openstacksdk==0.17.2 && pip install shade && pip install jinja2>=2.9.6 && pip install netaddr && pip install pbr>=1.6 && pip install ansible-modules-hashivault>=3.9.4 && pip install hvac && pip install PyYAML 
#RUN pip install openstackclient

# Set working directory
WORKDIR /home

# Create data directory
RUN mkdir data

# Copy Ansible autoscaling code to image
COPY . .
#COPY ../kubespray .
#COPY ../init_tools.sh .
#COPY ../ssh .

# change permissions of bash script
RUN chmod +x entry.sh

# Run module
ENTRYPOINT ["./entry.sh"]
