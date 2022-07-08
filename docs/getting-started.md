# Getting Started
Follow the instructions in the first step of our [quickstart guide](https://convergence.io/quickstart/) to download and run a local version of Convergence.

## Domains
Domains provide an organizational structure for your applications. Convergence users (*you*, not your application's end user) can create and use multiple domains. Each domain has its own set of users, data, security rules, etc.  In essence, each domain is its own entire collaborative ecosystem.  Having multiple domains is convenient if you have multiple applications, or if you have a production application and would like to have a sandbox to play in without affecting your production users.


## JavaScript / HTML Setup
All the required client code is included in the Convergence Omnibus Container.  The quickest way to get started is to add the following HTML to the `head` tag of your page:

```HTML
<html>
  <head>
    <script src="http://localhost:8000/client/rxjs.umd.min.js"></script>
    <script src="http://localhost:8000/client/convergence.js"></script>
  </head>
</html>
```

We also offer an AMD version of the client at `/client/convergence.amd.js`.  For now, though, this is the simplest way to get started.  Ensure that the RxJS script tag is added BEFORE the Convergence client.

## Node.js Usage
The convergence client also works with Node.js, though it requires a third-party implementation of WebSockets. We have used the [ws](https://github.com/websockets/ws) library successfully with the following configuration:

```Javascript
const WebSocket = require('ws');
...
Convergence.connect(domainUrl, "Bruce Wayne", "1AmBatman!", {
  webSocket: {
    class: WebSocket,
    factory: (u) => new WebSocket(u, {rejectUnauthorized: false}),
  }
});
```

[See here](https://docs.convergence.io/js-api/interfaces/connection_and_authentication.iconvergenceoptions.html) for details about the connection options we support.

## Connecting
The first step after setup is to connect to your domain.  The simplest way to connect is using a username and password for a domain user.  The connect method returns a promise that will either complete with the connected domain, or will be rejected with an error detailing why the connection was not successful.

```Javascript
var domainUrl = "http://localhost:8000/api/realtime/convergence/default";
Convergence.connect(domainUrl, "Bruce Wayne", "1AmBatman!").then(domain => {
  // Connection success! See below for the API methods available on this domain
}).catch(err => {
  console.log(err);
});
```
You can see the available connection methods in the [Authentication](/guide/authentication/overview/) section.

## Services
The domain is the main entry point into the convergence API.  The features it provides are grouped into high level services.  Getting to know these services is the next step in learning how to use Convergence to build a collaborative app.

* [**Identity Service**](/guide/identity/overview/): Provides services to obtain information on the identity of users in the system.
* [**Presence Service**](/guide/presence/overview/): Provides services to see who is available in the system and publish shared state.
* [**Model Service**](/guide/models/overview/): Provides services to store, retrieve, and edit shared data models.
* [**Activity Service**](/guide/activities/overview/): Provides services to more gradually communicate who is doing what in an application.
* [**Chat Service**](/guide/chat/overview/): Provides services for users to send messages to each other to coordinate actions and share information.

Each service is discussed in detail in subsequent chapters.

## Next Steps

For a high-level overview of how Convergence works, see our [Architecture overview](/guide/architecture-overview/). 

Go [here](/guide/authentication/overview/) see how authentication and connection works.

To dig into the various features of Convergence, go to the [Convergence Domain](/guide/domain/overview/) page which gets into the various services it provides.
