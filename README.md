# Apache Kafka running on Raspberry Pi and Docker

This repository contains the necessary Dockerfile and
installation/config/runtime files to run [Kafka] and [Zookeeper] on [Raspberry Pi] in containers.

The overall goals of this repository is to make it easier to get started
with running a [Kafka] cluster on [Raspberry Pi].  It is also a learning
tool for learning better practices of creating more flexible builds with
[Docker].

You can find the [Docker Hub] images at `cberthold/kafka-pi-armv7:latest`.

## Quick Start

Right now there isn't much to configuring [Zookeeper] or [Kafka].  As more
development needs progress on a different project there will be new features
developed.

To run:
```# Run docker in daemon mode and expose ports
$ docker run -d -p 2181:2181 -p 9092:9092 -p 9091:9091 --name kafka-pi
cberthold/kafka-pi-armv7:latest
```

Additional configuration:

- ```create-config-template.sh```

Any part of the existing configuration file can be tweaked to allow
environment variables passed in through the Dockerfile or later on thread
docker-compose or Kubernetes.  This file builds that template that is done
at installation time.

- ```create-config-files.sh```

This file recombines any passed in environment variables and uses sensible
defaults for running on the [Raspberry Pi].


[Docker]: http://www.docker.io
[Docker Hub]: https://hub.docker.com
[Kafka]: http://kafka.apache.org
[Zookeeper]: https://zookeeper.apache.org
[Raspberry Pi]: https://www.raspberrypi.org