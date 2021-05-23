# REST API: Authentication

There are currently a couple ways to authenticate REST requests:

- Session tokens are useful in browser-based applications where there is an active session with a fixed timeout (This is how the Convergence administration console authenticates). 
- API keys are useful in server-to-server use cases.  We recommend generating separate API Keys for each service that wishes to make REST requests.

Note that only Convergence users (as opposed to Domain users) can be authenticated to perform REST requests.  Domain users are the end application's users and specific to a domain.  Convergence users are global to an installation and can be thought of as Administration users.  For example, you login to the web-based Administration Console with a Convergence user.

# Per-user Session Token
 
The first method of authentication requires an initial step to generate a Session Token, which itself can be used in subsequent requests.  

```
POST {{convergenceRestUrl}}/auth/login
{
  "username": "{{username}}",
  "password": "{{password}}"
}
```

which returns something like 
```
{
    "body": {
        "token": "lPPduBoI0ZcV3DEDs6dXvPZAjEm0JJcC",
        "expiresIn": 3600000
    },
    "ok": true
}
```

The token is a session token which expires in **one hour**.  It can be used in subsequent REST calls by including it in a header like so:

```
{
  "Authorization": "SessionToken {{token}}"
}
```

# User-specific persistent API Keys

API Keys can be generated through the Convergence Administration Console.  Simply go to the User menu in the upper right and select "Settings" in the dropdown.  This displays a simple UI for listing, creating, toggling, and deleting API Keys.

_API Keys are persistent and never expire, so they must be kept secret!_

## Usage

REST calls can be authenticated by including a generated API key in the request header like so:

```
{
  "Authorization": "UserApiKey {{key}}"
}
```