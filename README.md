<img alt="Convergence Logo" height="80" src="https://convergence.io/assets/img/convergence-logo.png" >

# Convergence JavaScript Developers Guide
This repository contains the Convergence JavaScript Developers Guide that is hosted at https://docs.convergence.io/guide/.  It was developed using [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/).

## Contributing
If you find errors or see room for improvement please create an issue here. Pull requests are always welcome.

## Tools and Frameworks
To develop and build this repository the following tools are needed:

  * [mkdocs-material](https://squidfunk.github.io/mkdocs-material/) >= 7.1.x
  * Docker => 0.20.x

The developers primary work on MacOS / Linux so most scripts and instructions assume a Linux / Unix like build environment.

## Development
The developers prefer a docker based workflow.  First, obtain the docker image for mkdocs-material:

```shell
docker pull squidfunk/mkdocs-material
```

To serve the project live issue the following command from the root of the repository:

```shell
docker run --rm -it -p 7000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material
```

Then visit: http://localhost:7000/

## static Build
To build the static content for the site issue the following command:

```shell
docker run --rm -it -v ${PWD}:/docs squidfunk/mkdocs-material build
```

This will create the `site` directory in the root of the project.  This directory is in the `.gitignore` file so that it won't be accidentally checked in.


# Docker

## Build
To build the container run the following command:

```shell
docker build -t convergencelabs/js-dev-guide .
```

## Run
To run the build container run the following command:

```shell
docker run --rm \
  --name convergence-js-dev-guide \
  -p 8888:80 \
  convergencelabs/js-dev-guide
```

Then browse to http://localhost:8888