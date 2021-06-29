#!/usr/bin/env bash

docker run \
  --rm \
  -it \
  -p 7000:7000 \
  -v ${PWD}:/docs \
  squidfunk/mkdocs-material serve --livereload --verbose --dev-addr 0.0.0.0:7000