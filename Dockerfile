FROM jgoerzen/debian-base-security AS debian-addons
FROM python:3

COPY --from=debian-addons /usr/local/preinit/ /usr/local/preinit/
COPY --from=debian-addons /usr/local/bin/ /usr/local/bin/
COPY --from=debian-addons /usr/local/debian-base-setup/ /usr/local/debian-base-setup/
RUN run-parts --exit-on-error --verbose /usr/local/debian-base-setup

# enable ssh
ENV DEBBASE_SSH enabled
ENV HOME /root

# Install sudo
RUN apt-get update && apt-get install -y sudo && \
    mkdir -p /etc/sudoers.d

# Install Docker
RUN apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg |  apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && apt-get install -y docker-ce

# Install AWS CLI
RUN apt-get update && apt-get install -y awscli

# Upgrade and install Python development tools
RUN python -m pip install --upgrade \
    pip \
    setuptools \
    wheel \
    pipenv

# Create and configure vagrant user
RUN useradd --create-home -s /bin/bash vagrant
WORKDIR /home/vagrant

# Enable passwordless sudo for the "vagrant" user
RUN install -b -m 0440 /dev/null /etc/sudoers.d/vagrant && \
    echo 'vagrant ALL=NOPASSWD: ALL' >> /etc/sudoers.d/vagrant

# Configure SSH access
RUN mkdir -p /home/vagrant/.ssh && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys && \
    chown -R vagrant: /home/vagrant/.ssh && \
    echo -n 'vagrant:vagrant' | chpasswd

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/usr/local/bin/boot-debian-base"]
EXPOSE 22

