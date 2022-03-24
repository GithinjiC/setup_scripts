### Requirements
* python3.8+
* pip
* ansible

### Installation
```bash
sudo apt install python3.8+
sudo apt install python3-pip
sudo apt install ansible
```

### Usage
```bash
ansible-playbook <playbook.yml> -vvv -K
```
```bash
ansible-playbook -i <inventory_file> <playbook.yml> -vvv -K
```

###Options
``vvv or vv for verbose``
``-K for user password prompt``

### About the Playbooks
Originally all playbooks run on localhost. 
Design inventory file and adjust `hosts:` in the playbooks to run on defined remote hosts.

For debugging purposes disable `no_log:true`
#### Playbooks with sections/plays that should run only once e.g
* k8_install.yml -> `Change Docker cgroup driver`

#### Playbooks dependent on script files e.g
* K8_install.yml uses iptables.sh