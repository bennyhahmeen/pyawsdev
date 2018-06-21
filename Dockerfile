FROM python:3

# Updates
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# Install Docker
RUN apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | \
      apt-key add - && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce && \
    apt-get clean

# Install AWS CLI
RUN apt-get install -y awscli && apt-get clean

# Upgrade and install Python development tools
RUN python -m pip install --upgrade \
    pip \
    setuptools \
    wheel \
    pipenv

