#!/bin/bash

# PREPARE THE REPOSITORIES
# Download and install the public signing key:
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Add the Elastic source list to the sources.list.d directory, where APT will look for new sources
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list


######## ELASTIC SETUP #######
# Update repositories and install all the required tools 
sudo apt update
sudo apt -y install openjdk-11-jre-headless

# Install elasticsearch
sudo apt install elasticsearch

# Configure the elasticsearch parameters
sudo cat <<EOF >>/etc/elasticsearch/elasticsearch.yml
network.host: localhost
http.port: 9200
EOF

# Reload the daemons
sudo systemctl daemon-reload

# Start the Elasticsearch service
sudo systemctl start elasticsearch.service
sudo systemctl enable elasticsearch.service


####### KIBANA SETUP #######
# Install kibana
sudo apt install kibana

# Configure Kibana parameters
sudo cat <<EOF >>/etc/kibana/kibana.yml
server.port: 5601
elasticsearch.hosts: ["http://localhost:9200"]
server.host: "0.0.0.0"
EOF

# Reload the daemons
#sudo systemctl daemon-reload

# Enable and start Kibana
sudo systemctl start kibana.service
sudo systemctl enable kibana.service

# Allow traffic on port 5601
sudo ufw allow 5601/tcp

####### LOGSTASH SETUP #######
# Instal logstash
sudo apt-get -y install logstash

# configure logstash to be available on port 5044 and send to elasticsearch
sudo cat << EOF >>/etc/logstash/conf.d/apache_logs.conf
input {
  beats {
    port => 5044 
  }
}

filter{
  grok {
    match => {"message" => "%{COMBINEDAPACHELOG}"}
  }
  date {
    match => [ "timestamp" , "dd/MMM/yyyy:HH:mm:ss Z" ]
  }
  geoip {
    source => "clientip"
  }
}

output {
  elasticsearch {
    hosts => ["localhost:9200"]
    manage_template => false
    index => "logstash-%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
  }
}
EOF

# Make the directory writtable otherwise I get an error
sudo chmod +777 /usr//share/logstash//data/

# Enable and start logstash
sudo systemctl start logstash
sudo systemctl enable logstash




