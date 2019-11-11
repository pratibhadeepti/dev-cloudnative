#######################################################################################################
# Script to install all the initial dependencies on first machine which will help image in booting up
# It will install: Ansible, Python 3.5, Pip, Openstack SDK
# ~ Cloudibility.io
#######################################################################################################
#!/bin/bash

echo "Welcome"  ${USER}
echo
echo "This script will install initial dependencies like Ansible, python, pip and openstack SDK version 0.17.2"
echo

#if [[ $EUID -ne 0 ]]; then
#    echo "This script to be run as root" >&2
#    exit 1
#fi

# Checking Linux(Distribution) MacOS SunOS AIX

OS=`uname -s`

# Function to install openstack SDK
openstck()
{
        pip show openstacksdk
        ver=`echo $?`
        if [ ${ver} == "0" ]; then
            echo  "Uninstalling SDK"
            sudo pip uninstall openstacksdk -y; sudo pip install openstacksdk==0.17.2;
            echo "Installing Shade"
            sudo pip install shade objectpath json pytz;
            echo "uninstalling and installing new version of qpid-proton-c"
            sudo yum remove qpid-proton-c -y; sudo yum install qpid-proton-c -y;

        else
             echo  "Installing Openstack"
             sudo pip install openstacksdk==0.17.2;
             echo "Installing Shade"
             sudo pip install shade objectpath json pytz;
             echo "uninstalling and installing new version of qpid-proton-c"
             sudo yum remove qpid-proton-c -y; sudo yum install qpid-proton-c -y;

        fi
}

"$@"


echo "OS type - " ${OS}

if [ ${OS} == "Linux" ]; then
    echo "OS type is Linux"
    if [ -f /etc/redhat-release ] ; then
        DIST="RedHat"
        echo "Installing tools on" ${DIST}
        echo
        sleep 2
        echo "Updating repository"
        sudo yum update -y; sudo yum upgrade -y;
        echo "Installing tools"
        sudo yum install gcc -y; sudo cd /usr/src; sudo wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz;
        sudo tar xzf Python-2.7.10.tgz; sudo cd Python-2.7.10; sudo ./configure; sudo make altinstall; sudo yum install python-pip -y;
        echo "Installing Ansible"
        sleep 2
        sudo pip install ansible==2.6;
	    sudo pip install -r ./kubespray/requirements.txt
        sudo yum install epel-release -y; yum install -y jq; yum install parallel -y; yum install zip -y;
        openstck
        echo "Install Docker"
        sudo yum check-update; curl -fsSL https://get.docker.com/ | sh; sudo systemctl start docker; sudo systemctl status docker; sudo systemctl enable docker; sudo usermod -aG docker $(whoami); sudo systemctl restart docker
        echo "Installation complete!"


    fi
    if [ -f /etc/debian_release ] || [ -f /etc/debian_version ] ; then
        DIST="Ubuntu"
        echo "Installing tools on" ${DIST}
        echo
        sleep 2
        echo "Updating repository"
        sudo apt-get update -y; sudo apt-get upgrade -y;
        echo "Installing tools"
        sudo apt-get install gcc -y; sudo cd /usr/src; sudo wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz;
        sudo tar xzf Python-2.7.10.tgz; sudo cd Python-2.7.10; sudo ./configure; sudo make altinstall; sudo apt-get install python-pip -y;
        echo "Installing Ansible"
        sudo apt-get update; sudo apt-get install software-properties-common -y;sudo apt-get install jq -y; sudo apt-add-repository ppa:ansible/ansible -y; sudo apt-get update; sudo apt-get install ansible -y;
        echo "Installing openstack SDK"
        openstck
        echo "Installation complete!"

    fi
fi

