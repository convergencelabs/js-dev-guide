# Containers
Convergence is most commonly deployed as [Open Container Initiative](https://opencontainers.org/) (OCI) containers that can be run by any compliant OCI runtime such as [Docker](https://docs.docker.com/engine/) or [ContainerD](https://containerd.io/). The Convergence images are published to [Docker Hub](https://hub.docker.com/u/convergencelabs).

## Core Convergence Container Images
The following container make up the core Convergence Framework:

* **[convergencelabs/convergence-omnibus](https://hub.docker.com/r/convergencelabs/convergence-omnibus)**: An all-in-one container that has everything you need to start a Convergence instance. It is appropriate for local development, a test environment, and small server setups.
* **[convergencelabs/convergence-cluster-seed](https://hub.docker.com/r/convergencelabs/convergence-cluster-seed)**: A lightweight cluster seed node. This container has minimal code and dependencies making it lightweight to run and unlikely to crash. This makes it ideal for acting as a persistent cluster seed node when Convergence is set up in a clustered mode.
* **[convergencelabs/convergence-server](https://hub.docker.com/r/convergencelabs/convergence-server)**: This is the main Convergence Server. It provides the main business logic for Convergence and presents the Realtime (WebSocket) and REST APIs. It is configured to point to an Orient DB instance.
* **[convergencelabs/convergence-admin-console](https://hub.docker.com/r/convergencelabs/convergence-admin-console)**: This container hosts the Convergence Admin Console user interface.  It is configured to point to a Convergence Server node.

## Other Relevant Containers
* **[orientdb](https://hub.docker.com/_/orientdb)**: OrientDB is used as the persistence layer for Convergence.  Convergence currently uses OrientDB version 3.0.x.
* **[nginx](https://hub.docker.com/_/nginx)**: While not required, Convergence often makes use of the NGINX http server to act as a proxy when hosting multiple containers on the same machine.


