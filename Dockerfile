# syntax=docker/dockerfile:1
FROM squidfunk/mkdocs-material:7.2.0 AS builder
WORKDIR /docs
COPY . /docs
RUN mkdocs build

FROM nginx:1.19.10
COPY --from=builder /docs/site /usr/share/nginx/html
