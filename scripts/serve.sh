#!/usr/bin/env bash

docker run \
  --rm \
  -it \
  -p 7000:7000 \
  -v ${PWD}:/docs \
  squidfunk/mkdocs-material:7.2.0 serve --livereload --verbose --dev-addr 0.0.0.0:7000