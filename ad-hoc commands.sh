
---
- name: Test connectivity to all hosts
  hosts: all
  tasks:
    - name: Ping all nodes
      ansible.builtin.ping:

---
- name: Create a test file
  hosts: all
  become: yes
  tasks:
    - name: Create a file in /tmp directory
      ansible.builtin.file:
        path: /tmp/testfile.txt
        state: touch


---
- name: Clone a GitHub repository
  hosts: all
  become: yes
  tasks:
    - name: Clone a repository into /var/www/html
      ansible.builtin.git:
        repo: "https://github.com/example/repo.git"
        dest: "/var/www/html"
        version: "main"




#Check Connectivity (Ping)
ansible all -m ping

#Gather System Information (Facts)
ansible all -m setup
ansible -m setup -a 'filter=ansible_distribution' all

#Create a File
ansible all -m file -a "path=/home/ec2-user/testfile.txt state=touch"

#Create a Directory
ansible all -m file -a "path=/home/ec2-user/newdir state=directory"

#Delete a File
ansible all -m file -a "path=/tmp/testfile state=absent"

#Installs nginx using apt
ansible all -m apt -a "name=nginx state=present" --become
ansible all -m yum -a "name=httpd state=present" --become
ansible all -m service -a "name=nginx state=started" --become #to start


####playbook
---
- name: Ansible Playbook for Basic Tasks
  hosts: all
  become: yes
  tasks:

    - name: Check Connectivity (Ping)
      ansible.builtin.ping:

    - name: Gather System Information (Facts)
      ansible.builtin.setup:

    - name: Get OS Distribution
      ansible.builtin.setup:
      register: system_facts

    - name: Display OS Distribution
      debug:
        msg: "OS Distribution is {{ system_facts.ansible_facts.ansible_distribution }}"

    - name: Create a File
      ansible.builtin.file:
        path: /home/ec2-user/testfileak.txt
        state: touch

    - name: Create a Directory
      ansible.builtin.file:
        path: /home/ec2-user/newdirak
        state: directory

    - name: Install HTTPD 
      ansible.builtin.yum:
        name: httpd
        state: present

    - name: Start Nginx Service
      ansible.builtin.service:
        name: httpd
        state: started
