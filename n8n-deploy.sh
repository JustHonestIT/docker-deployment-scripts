!/bin/bash

echo "Creating directory structure on the root filesystem now"
sleep 2
wait
mkdir -p /n8n-app-data
echo "Please enter the subdomain / domain name, which is gonna be publicly accesible for n8n"
sleep 2
wait
read -p "Enter the value for APPURLTOUSE: " APPURLTOUSE
cat <<EOF > /n8n-app-data/docker-compose.yml
version: "3.7"

services:
  n8n:
    image: docker.n8n.io/n8nio/n8n
    restart: always
    ports:
      - "127.0.0.1:5678:5678"
    environment:
      - N8N_HOST=${APPURLTOUSE}
      - N8N_PORT=5678
      - N8N_PROTOCOL=https
      - NODE_ENV=production
      - WEBHOOK_URL=https://${APPURLTOUSE}/
      - GENERIC_TIMEZONE=${GENERIC_TIMEZONE}
    volumes:
      - /n8n-app-data:/home/node/.n8n
EOF

 sleep 2
 wait
 echo "Almost ready, going to deploy your n8n environment now, using Docker Compose." 
 sleep 2
 wait
 echo "CD'ing into the correct direcory first"
 cd /n8n-app-data
 sleep 2
 wait
 echo "Running Docker Compose, please stand by, as everything is setup"
 docker-compose up -d
 sleep 8
 wait
 echo "Stopping container, almost done now"
 docker stop $(docker ps -q)
 sleep 2
 wait
 echo "Starting container, last task now"
 docker start $(docker ps -a -q --filter "status=exited")
 sleep 2
 wait
 echo "Done, enjoy your n8n environment!"
 echo "Ooh, and subscribe to my channel :)"
