# pyawsdev
## Python AWS API Development Environment using Docker

This Docker container is intended to be used by mounting source code from
the development environment at /src and mounting /var/lib/docker.sock.
Mounting /var/lib/docker.sock provides the ability to run docker inside
the container to create AWS Lambda dependencies.

[pyawsdev-bootstrap](https://github.com/bennyhahmeen/pyawsdev-bootstrap) 
contains setup scripts to bootstrap a development environment with the
tools necessary to use this.

### Setup

    docker pull bennyhahmeen/pyawsdev
    cd <my-project-directory>
    docker run --rm -it -v "`pwd`:/src" -w /src -v /var/run/docker.sock:/var/run/docker.sock bennyhahmeen/pyawsdev bash
    
Now configure your IDE for the docker run command above.
