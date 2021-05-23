# Users & Identity

Domain Users represent the actual users of your application. Convergence provides an  Identity Service to allow users to get information about the identity of other users in the system.

## Domain Users

Domain users are those users who are allowed to log into the domain through the Convergence client.  Users are uniquely identified by `username`. When retrieved from the server, a user's identity will have the following structure:

```js
{
  username: "user",
  email: "user@example.com",
  firstName: "Joe",
  lastName: "User",
  displayName: "Joe User"
}
```

You can manage this information through the Convergence Administration Interface.

## Identity Service

The identity service allows users to query for the identity of users.  You can look up users explicitly by either username or email.  Or, you can search for them using any number of fields. All requests return promises.

## Looking Up Single Users
```js
var identityService = domain.identity();

// We assume that the search parameter is a username.  
identityService.user("juser").then((user) => {
  console.log(user); // will be undefined if the user does not exist
});

// Alternatively, specify a lookup by email
identityService.userByEmail("user1@example.com").then((user) => {
  console.log(user); // will be undefined if the user does not exist
});
```

## Looking Up Multiple Users
```js
var identityService = domain.identity();

// Lookup by username
identityService.users(["juser", "mhoward"]).then((users) => {
  users.forEach(user => console.log(user));
});

// Lookup by email
identityService.usersByEmail(["user1@example.com", "user2@example.com"]).then((users) => {
  users.forEach(user => console.log(user));
});
```

## Searching for Users
You can search for users using a basic wildcard search across multiple fields.  The search
method will return any user that contains the specified value anywhere in the specified
fields.

```js
var identityService = domain.identity();

identityService.search({
  fields: ["firstName", "lastName"], // search fields
  term: "smith", // search term
  offset: 0, 
  limit: 10, 
  orderBy: {
    field: "lastName",
    ascending: true
  }
}).then((users) => {
  users.forEach(user => console.log(user));
});
```

Which would match the following: John Smith, Jane Smithers, Smithy McFlabaroo, etc.

## Domain Users
The various methods in the identity service return information about individual users or collection of users. In both cases the objects that are returned are instances of the DomainUser class.  The most commonly used field of this class are outlined below:
 
| Field | Description |
| --- | --- |
| username | Returns the unique username of this user. |
| firstName | Returns the first name of this user. |
| lastName | Returns the last name of this user. |
| displayName | Returns the display name for this user. |
| email | Returns the email for this user. |
| isAnonymous | Returns true if the user connected anonymously. |
