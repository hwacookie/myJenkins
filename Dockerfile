FROM jenkins/jenkins
# if we want to install via apt
USER root
RUN apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get -y install docker-ce maven


# Let Jenkins be sudoer
RUN apt-get --no-install-recommends -y install sudo && \
echo "jenkins ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers 

ENV DOCKER_GID_ON_HOST ""
COPY jenkins.sh /usr/local/bin/jenkins.sh
ENV MAVEN_HOME /usr/share/maven

# drop back to the regular jenkins user - good practice
USER jenkins
