# pyawsdev
## Python AWS Development Environment for Vagrant using Docker

This is a Vagrant development environment for Python AWS development
using Docker as a virtualization provider.

### Quick Start

    docker pull bennyhahmeen/pyawsdev
    cd <this-directory>
    vagrant up

Then configure your IDE to connect to vagrant.

Optionally edit Vagrantfile and change the source code directory being
synced to the virtualized environment:

    config.vm.synced_folder "~/src", "/src"

### Details

This Docker container is intended to be used by mounting source code from
the development environment at /src and mounting /var/lib/docker.sock.
Mounting /var/lib/docker.sock provides the ability to run docker inside
the container to create AWS Lambda dependencies.

[pyawsdev-bootstrap](https://github.com/bennyhahmeen/pyawsdev-bootstrap) 
contains setup scripts to bootstrap a development environment with the
tools necessary to use this.

### Manually running Docker directly

    docker pull bennyhahmeen/pyawsdev
    cd <my-project-directory>
    docker run --rm -it -v "`pwd`:/src" -w /src -v /var/run/docker.sock:/var/run/docker.sock bennyhahmeen/pyawsdev bash
