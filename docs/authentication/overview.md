# Authentication

The first step in working with Convergence is to connect to the server through the Convergence Client.  The client requires users to authenticate when connecting and provides several authentication methods that support multiple use cases.

## Convergence Username and Password Authentication
Each Convergence Domain contains its own basic user store where that allows you to create and manage users within that domain.  Users are identified primarily by their **username** and authenticated via a **password**.  You can create users and set their passwords in the Convergence Administration Console.  The example below illustrates connects using the username and password method:

```js
var domainUrl = "http://localhost:8000/api/realtime/<namespace>/<domain>";
Convergence.connect(domainUrl, "Clark Kent", "solitude").then((domain) => {
  // Connection success!
}).catch((err) => {
  console.log(err);
});
```

## Anonymous Authentication
Convergence allows anonymous login.  However this must be enabled on a per-domain-basis within the Convergence Administration Console.  The setting can be found in the "Authentication" section for the Domain you are working with.  Once enabled, users will be able to connect anonymously.  When connecting anonymously, users can provide an optional Display Name that they wish to be known by.  

> When authenticating anonymously an ephemeral user is created in the system.  Once the client disconnects that user will no longer be active in the system.  Even if the same client immediately reconnects, a new ephemeral user will be created.

An example of anonymous authentication is shown below:

```js
var domainUrl = "http://localhost:8000/api/realtime/<namespace>/<domain>";
Convergence.connectAnonymously(domainUrl, "Superman").then((domain) => {
  // Connection success!
}).catch((err) => {
  console.log(err);
});
```

## JSON Web Token Authentication
JWTs allow an external application to authenticate a user and then inform Convergence who that user is. The JWT specification allows a trust relationship to be set up between Convergence and the external application using cryptographic digital signatures. An interesting aspect of JWT based authentication is that Convergence will automatically create new users for you the first time a user connects via a JWT.  Since a trust relationship is created between Convergence and the external system, the external system can provide information about the user which Convergence can use to create that user on-demand.  

Details on working with JWTs in Convergence can be found in the [next section](json-web-tokens.md). A rough example of how to connect using JWTs is shown below, but the details of generating the JWT have been ommitted:

```js
var domainUrl = "http://localhost:8000/api/realtime/<namespace>/<domain>";
var jwtClaims = generateJWTForUser("tom");
Convergence.connectWithJwt(domainUrl, jwtClaims).then((domain) => {
  // Connection success!
}).catch((err) => {
  console.log(err);
});
```

## Reconnect Tokens
Sometimes it can be desired to "resume" a prior authenticated connection with Convergence.  Thus, after a non-anonymous succesful authentication, a [reconnect token](https://api-docs.convergence.io/classes/users_and_identity.convergencesession.html#reconnecttoken) is available on the resulting `ConvergenceSession`.  This token can be passed to [Convergence.reconnect](https://api-docs.convergence.io/classes/convergence.html#reconnect) to authenticate as the same user for which the token was originally created:

```js
const reconnectToken = window.sessionStorage.getItem('convergence-reconnect-token');
let domain;
if (reconnectToken != null) {
  domain = await Convergence.reconnect(domainUrl, reconnectToken);
} else {
  domain = await Convergence.connectWithJwt(domainUrl, jwtFromServer);
  window.sessionStorage.setItem('convergence-reconnect-token', domain.session().reconnectToken());
}
```

Reconnect tokens are valid for 24 hours.
