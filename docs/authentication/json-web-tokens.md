# JSON Web Token (JWT)
JSON Web Tokens (JWTs) are used to allow external systems to authorize and create Convergence users. JWT is an open industry standard defined in [RFC 7519](https://tools.ietf.org/html/rfc7519) that provides a secure way for two systems to transfer claims and/or assertions between them.  Convergence uses JWTs to allow an external system to authenticate a user, using whatever mechanism they see fit, and to then allow that user to connect to Convergence without needing to provide a username and password.

You can learn more about JWTs here: https://jwt.io

Convergence has chosen to use the RS256 Asymmetric Key approach to establishing trust between the two systems. In this model a public / private key pair is generated and used to digitally sign the JWT via an RSA Signature using the SHA-256 hash algorithm. Convergence will store the public key so that it can verify the digital signature.  The external system will store the private key and will use the private key to digitally sign the token containing information about the user that was authenticated.

## On Demand User Creation / Update
When users log in using JWT, Convergence will check to see if a user account matching the username in the JWT already exists.  If it does not, Convergence will automatically create a new user based on the claims supplied in the JWT.  If the user does exist, Convergence will update the user based on the current claims provided.

## Creating a JWT Key in Convergence
The first step in using JWT authentication is to create and enable a JWT Key in the Convergence Administration Console.  You can accomplish this by:

1. Log in to the Convergence Administration Console.
1. Navigate to the domain you wish to use.
1. Click the 'Authentication' link in the left side navigation.
1. Select the tab 'JWT Authentication'
1. Hit the plus icon to create a new key.
1. Create a key using one of two methods:
    * If you have already generated an RSA Public Private Key pair, you can simply paste the public key in to the dialog.  
    * Otherwise you can click the 'Generate Key' button to generate a new key.  Be sure to copy the private key somewhere safe, since Convergence will only store the Public Key.

1. Give the key a meaningful "Key Id" and note it as it will be used as the JWT Key Id.
1. Optionally provide a description.
1. Ensure the "Enabled" checkbox is selected
1. Click create.

## Generating a JWT

### Mandatory Header Settings

| Setting | Description |
| --- | --- |
| **alg** | Must be set to "RS256".|
| **typ** | Must be set to "JWT".|
| **kid** | Must match the id of the Convergence JWT Key you wish to use.|

### Mandatory Claims

| Setting | Description |
| --- | --- |
| **aud** | Must be set to "Convergence".|
| **sub** | The username of the user you are authenticating.|
| **exp** | All keys must have an expiration time.|


### Optional Claims

The following optional claims are currently supported:

| Event | Description |
| --- | --- |
| "firstName" | Maps to the users First Name setting in Convergence. |
| "lastName" | Maps to the users Last Name setting in Convergence.|
| "displayName" | Maps to the users Display Name setting in Convergence.|
| "email" | Maps to the users Email setting in Convergence.|


### Example Header and Payload

```js
// Header
{
  "alg": "RS256",
  "typ": "JWT",
  
  // The Convergence JWT Key Id
  "kid": "myDomainKey"
}

// Payload
{
  // JWT Specified Items
  "iat": 1478718051,
  "nbf": 1478718051,
  "exp": 1478718111,
  "aud": "Convergence",
  
  // The Subject (a.k.a username)
  "sub": "jsmith",
  
  // User Claims
  "firstName": "John",
  "lastName": "Smith"
  "displayName": "John Smith",
  "email": "jsmith@example.com",
}
```


## Convergence JavaScript JWT Generators
Convergence provides a node module that is preconfigured to generate JWTs compatible with Convergence.  This module greately reduces the complexity of generating a JWT from Node.  The package can be installed as shown below:

`npm install @convergence/jwt-util`

## Other Tools / Languages
If you are not developing in JavaScript, or you would just rather build your own JWT, there are several options out there for creating JWTs.  Please reference http://jwt.io for a comprehensive list of tools for various platforms.