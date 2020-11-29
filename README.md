# Practice SysAdmin Bootcamp DevOps

Small project to provision 2 machines automatically using shell script as provisioners, one machine with ELK stack and another one with Wordpress and Apache. The wordpress machine 
will also install filebeat so it collect the logs and send them to ELK machine so they can be visualized in kibana GUI  

## Starting 🚀

To clone this project just press on the clone button on the right hand side

## Hardware settings for the virtual machines used
  
- Virtual Machine 2(Wordpress)
    - Ubuntu Bionic 18.04
    - RAM	: 1GB
    - CPU	: 2
    - IP	: 192.168.33.11
    - Network	: Keepcoding
    
- Virtual Machine 3(Elastik)
    - Ubuntu Bionic 18.04
    - RAM	: 4GB
    - CPU	: 2
    - IP	: 192.168.33.12
    - Network	: Keepcoding

## Installation 🔧

Open a terminal and navigate to the project root folder, then start the 3 virtual machines by executing: 
```shell
vagrant up
``` 

Once all the tasks has finished succesfully. Open your browser and enter ```localhost:8081/blog``` to go to wordpress installation page, and enter your configuration details then press install wordpress button at the bottom.

After that open another tab in the browser and enter ```localhost:5601``` to get to Kibana GUI, on the top left corner click on the hamburguer icon and then click on **stack management** then click on **index patterns->create pattern**, add the logstash-filebeat index, and press enter, the add the **@timestamp** to in the time field and click on create index pattern.

Click on the hamburguer icon again and then go to **Kibana-> Discover** so you can see all the logs receive from the wordpress machine (in order to do this you need to have at least have installed wordpress as told in the previous steps)

## Built with 🛠️

* [Ubuntu 18.04](https://ubuntu.com/) - OS used in the 3 machines provisioned by Vagrant
* [Vagrant](https://www.vagrantup.com/) - Tool to manage virtual machines
* [ELK stack 7.10](https://www.elastic.co/es/) - Elastik stack tools to collect and display logs

## Author ✒️

* **Jesus Fernandez Arroyo** -(https://www.linkedin.com/in/jesus-fernandez-b3a969b0/)
