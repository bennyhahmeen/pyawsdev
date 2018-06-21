# pyawsdev
## Python AWS API Development Environment using Docker

This Docker container is intended to be used by mounting source code from
the development environment at /src and mounting /var/lib/docker.sock.
Mounting /var/lib/docker.sock provides the ability to run docker inside
the container to create AWS Lambda dependencies.

