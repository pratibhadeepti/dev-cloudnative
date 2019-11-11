# CNVA-Development
## While committing your code to github, please remove any private keys

## Steps to run the code on a new machine:
1. Create a Jump host with at least 50 GB disk space on OTC or any other Openstack supported cloud
2. Clone this repository, and source the environment file placed inside inventory folder.
3. Run init script (.sh file) to install all the dependencies on the jump host
4. run site.yml file

##command: 
- source inventory/env_otc.sh
- ./init_tools.sh
- ansible-playbook site.yml --extra-vars cluster_type=(Sub or Admin)
## For ELB deletion execute the below command:
- ansible-playbook site.yml --tags "DELB" --extra-vars cluster_type=(Sub or Admin)
