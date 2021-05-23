# ConvergenceDomain

The `ConvergenceDomain` is the main object that serves as the entry point of the Convergence API after a user is authenticated. The domain is returned by the various [connection methods](/authentication/overview.html) in the `Convergence` API. When an instance of `ConvergenceDomain` is returned by one of the connect methods, the domain will be authenticated, connected, and ready to be used.


## Disposal
When the client no longer needs to use the domain, such as when they log out, the client should call the `ConvergenceDomain.dispose()` method.  This method will log the user out, disconnect the client, and release the resources associated with the domain.  Each domain uses a web socket connection to the Convergence servers. If you do not dispose of the domain, the connection will be maintained. This means that the user will still be counted when calculating the number of concurrent users your domain is using. You should dispose of the domain when you are done with it to avoid maintaining unnecessary connections. Following this call, any further calls to the domain methods will likely result in errors and/or rejected promises.

Disposing the domain will disconnected it from the server and release all resources associated with the domain. It should be noted that any open / joined models, activities, chat rooms, etc. will be closed / left.

```js
domain.dispose();
```

You can determine if a domain is disposed by calling the `isDisposed()` method.

```js
domain.isDisposed();
```

## Sessions
Each connected domain has an associated session. The session can be obtained using the `session()` method.
```js
const session = domain.session();
```

The session provides methods to determine if the user is authenticated (`isAuthenticated()`) and / or connected (`isConnected()`). Each session has a unique sessionId that can be obtained using the `sessionId()` method.

```js
const session = domain.session();
const connected = session.isConnected();
const authenticated = session.isAuthenticated();
const sessionId = session.sessionId()
```

# Services
* [**Identity Service**](/identity/overview.html): Provides services to obtain information on the identity of users in the system.
* [**Presence Service**](/presence/overview.html): Provides services to see who is available in the system and publish shared state.
* [**Model Service**](/models/overview.html): Provides services to store, retrieve, and edit shared data models.
* [**Activity Service**](/activities/overview.html): Provides services to more gradually communicate who is doing what in an application.
* [**Chat Service**](/chat/overview.html): Provides services for users to send messages to each other to coordinate actions and share information.

Each service is discussed in detail in subsequent chapters.  Examples of how to obtain the services are below:

```js
 const identityService = domain.identity();
 const presenceService = domain.presence();
 const modelService = domain.models();
 const activityService = domain.activities();
 const chatService = domain.chat();
```


## Events
The `ConvergenceDomain` emits several events that can be listend to using the standard event emitter methods (e.g. `on()`, `addEventListener`, `once`, etc.). The events are described below.

| Event | Description |
| --- | --- |
| disconnected | Fired when the domain is disconnected and will not be reconnected. |
| interrupted | Fired when the domain is temporarily disconnected, but will attempt to reconnect. |
| reconnected | Fired when the domain reconnects after being interrupted. |
| error | Fired when there is an error in the domain, that is not handled by a sub-module. |
