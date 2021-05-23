# Convergence REST API

[Postman collection](https://github.com/convergencelabs/convergence-postman)

While the rest (ho ho!) of this guide covers the usage of Convergence via the Javascript client, a REST API is also available on the server. Notice that when the server is booted up, there is a log message communicating the initialization of a Rest API:

```
19:09:50 INFO  ConvergenceRestApi - Rest API started at: http://0.0.0.0:8081
```

If you are running a local Convergence server from the code, this URL is the one you can point to.  However, if you're running Convergence from Docker, there is an nginx proxy in front of this endpoint.  In the [Convergence 
Omnibus Container](https://hub.docker.com/r/convergencelabs/convergence-omnibus), for instance, the host port must be specified at [run-time](https://convergence.io/quickstart/), on which the endpoint for both the socket API and rest API are available.  These endpoints are typically:

- http://localhost:8000/api/realtime/
- http://localhost:8000/api/rest/

We will be referring to this latter endpoint throughout this section with `{{convergenceRestUrl}}`.

All successful mutating REST API calls will respond with status code 200 and a payload that looks like the following.  This will be referred to as the "default success response":

```
{
  "body":{},
  "ok":true
}
```

All examples assume the following header:
```
{
  "Content-Type": "application/json"
}
```