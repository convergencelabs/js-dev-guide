# Docker
Docker is a common container runtime that will easily run Convergence. If you are running linux, ensure you have installed the [Docker Engine](https://docs.docker.com/engine/install/).  If you are running MacOS or Window install [Docker Desktop](https://www.docker.com/products/docker-desktop).

## Running the Omnibus Container
To run the `convergence-omnibus-container` execute the following command:

```shell
docker run \
  --name convergence \
  -p "8000:80" \
   convergencelabs/convergence-omnibus
```
Then browse to [http://localhost:8000](http://localhost:8000) to log into the Convergence Admin Console.

## Docker Compose
[Docker Compose](https://docs.docker.com/compose/) is a convenient way to run multiple related containers.  In the case of Convergence, this is a good way to run a multi-containers using the individual containers. This is a more robust deployment strategy than the omnibus container since the individual containers can be started and upgraded, and the logs from each container will be separate. We have provided an example repository on Git Hub which contains a working Docker Compose configuration. The repository can be found here:

[https://github.com/convergencelabs/convergence-docker-compose](https://github.com/convergencelabs/convergence-docker-compose)

Using this repository a multi-container server can be started as easy as running:

```shell
docker-compose up
```

## Docker Swarm
[Docker Swarm](https://docs.docker.com/engine/swarm/) is a simple way to operate a multi-node cluster. Describing how to use Docker Swarm is beyond the scope of this document, but users who wish to deploy using Docker and want a multi-node cluster are encouraged to explore Docker Swarm.
