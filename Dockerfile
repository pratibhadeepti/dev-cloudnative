#################################
# Docker file to create image for ansible code
# ~Cloudibility.io
#################################

#Pull Centos 7 image from dockerhub
FROM centos:7

#Maintained by Cloudibility
MAINTAINER cloudibility.io

# Install dependencies on Centos Image
RUN yum install sudo -y && yum install wget -y && yum install make -y && yum -y install epel-release && yum clean all && yum -y install python-pip && yum clean all && yum install -y openssh-clients
RUN pip install ansible==2.6 && pip install openstacksdk==0.17.2 && pip install shade && pip install jinja2>=2.9.6 && pip install netaddr && pip install pbr>=1.6 && pip install ansible-modules-hashivault>=3.9.4 && pip install hvac && pip install PyYAML

# Set working directory
WORKDIR /home

# Copy Ansible code to image
COPY . .

# Expose port 22
EXPOSE 22

# change permissions of bash script
RUN chmod +x entry.sh init.sh inventory/env_otc.sh

# Run module
ENTRYPOINT ["./init.sh"]