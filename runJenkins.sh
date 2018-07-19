#!/bin/bash
docker run -p 8080:8080 -p 50000:50000 \
  -u root \
  -e "DOCKER_GID_ON_HOST=$(cat /etc/group | grep docker: | cut -d: -f3)" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /usr/bin/docker:/usr/bin/docker \
  -v /var/jenkins_home:/var/jenkins_home mbaaba/jenkins  