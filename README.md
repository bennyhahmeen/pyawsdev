# pyawsdev
## Python AWS Development Environment for Vagrant using Docker

This is a Vagrant development environment for Python AWS development
using Docker as a virtualization provider.

This is based on the official Python Docker image, which is Debian-based.
It adds a few utilities to support using it as a Vagrant development
environment along with the following development utilities:

    awscli
    docker
    pipenv

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

### Building for Local Updates

Edit Vagrantfile to comment out d.image and uncomment d.build_dir like so:

    # d.image = "bennyhahmeen/pyawsdev"
    d.build_dir = "."

Then run ```vagrant up``` as usual and it will build the docker image
locally rather than pulling it from Docker Hub.

### Manually running Docker directly

    docker pull bennyhahmeen/pyawsdev
    cd <my-project-directory>
    docker run --rm -it -v "`pwd`:/src" -w /src -v /var/run/docker.sock:/var/run/docker.sock bennyhahmeen/pyawsdev bash
