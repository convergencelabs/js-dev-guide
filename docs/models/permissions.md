# Permissions

In many systems different users will different levels of access to specific data in the system. Access to data is controlled by permissions. There are four basic permissions that apply to models:

* **Read:** A domain user must have the Read permission to open the model.
* **Write:** A domain user must have the Write permission to change data in the model.
* **Remove:** A domain user must have the Remove permission in order to remove the model.
* **Manage:**: A domain user must have the Manage permission in order to change the permissions of the model.

Collections have an additional permission:

* **Create:** A domain user must have the Create permissions in order to create a new model within a collection.


## Permission Scope and Precedence
Permissions can be defined at the Collection level and at the model and can be specific to a single user or all users. This give developers and users great flexibility to assign permissions at the granularity that makes sense for their application. However, understanding how the system works is important to achieve the desired outcome.


### User vs World Permissions 
User permissions are assigned to a specif user. Each user in the system **may** have their own permissions. **"World"** permissions define the permissions that apply to any authenticated user that does not have specific permissions defined. User permissions always take priority over world permissions.

Let's assume we have three users. Alice, Bob, and John and assume the following permissions for a particular model:

```json
{
  "worldPermissions": { "read": true, "write": false, "remove": false, "manage": false },
  "userPermissions": {
    "alice": { "read": true, "write": true, "remove": true, "manage": true },
    "bob": { "read": false, "write": false, "remove": false, "manage": false }
  }
}
```

The resulting permissions for Alice, Bob, and John will be:

| User | Permissions |
| --- | --- |
| Alice | `[Read, Write, Remove, Manage]` |
| Bob | `[ ]` |
| John | `[Read]` |


John does not have a specific user permission, so he will have Read permissions because that is what is set in the world permissions for the model. Alice has a specific set of permissions that grants all of the permissions. Bob has no access. For Bob even though the world permissions grant all users read access, Bob has a user permission entry that specifically prohibits access.


### Collection vs. Model Permissions
The highest level permission set in the system are the Collection Permissions. Collections have five permissions that control access to the models: Read, Write, Create, Remove, Manage. These permissions apply to **ALL** users in the system and define the default permissions applied to every model in the system that does override the permissions set by the collection.

Each model in the system can override the model permissions. If the model overrides the collection then the permission set in the particular model will take precedence. By default, when a model is created it does not override the collection permissions.


### Permission Precedence

Permissions will be evaluated in the following order or precedence (with lower numbers being higher priority):

1. Model User Permissions
1. Model World Permissions (if the model overrides the collection)
1. Collection World Permissions


## Permissions of Newly Created Models
When a model is created, by default it does not override the collection world permissions. The current collection world permissions at the time of creation are copied into the model, but the model will be set to NOT override the collection world permissions.  Additionally, the user that created the model will be given all permissions, including the **Manage** permission. This way the user that creates the model will be able to share that model with other users.

## Managing Permissions
Collection permissions can only be set via the Convergence Admin Console. Model permissions can be modified from both the Convergence Admin Console as well as the JavaScript API. model permissions can be configured from both the Model Service as well as from an individual Real Time Model.

```javascript
const permissionManager = domain
  .models()
  .permissions("970b09ee-f2b5-4d19-b3dc-e8fef87bf65c");

// OR

domain.models().open("970b09ee-f2b5-4d19-b3dc-e8fef87bf65c").then(model => {
  const permissionManager = model.permissions();
});
```
In both instances an instance of the ModelPermissionManager is returned. All of the methods on the ModelPermissionsManager class are asynchronous (e.g. return Promises).


### Getting Permissions

```javascript
// Get the permissions of the currently logged in user.
// Example Output: { "read": true, "write": true, "remove": true, "manage": true }
permissionManager.getPermissions()
  .then(myPermissions => console.log(myPermissions));

// Get the current world permissions of the model.
// Example Output: { "read": true, "write": false, "remove": false, "manage": false }
permissionManager.getWorldPermissions()
  .then(worldPermissions => console.log(worldPermissions));

// Get the current world permissions of the model.
// Example Output: { "read": false, "write": false, "remove": false, "manage": false }
permissionManager.getUserPermissions("bob")
  .then(worldPermissions => console.log(worldPermissions));

// Get all of the user permissions by user.
// Example Output: {
//   "alice": { "read": true, "write": true, "remove": true, "manage": true },
//   "bob": { "read": false, "write": false, "remove": false, "manage": false }
// }
permissionManager.getAllUserPermissions()
  .then(worldPermissions => console.log(worldPermissions));
```

### Modifying Permissions
```javascript

// Set the model to override the collection's world permissions.
permissionManager.setOverridesCollection(true);

// Set the world permissions for the model
permissionManager.setWorldPermissions(
  { "read": true, "write": true, "remove": true, "manage": true }
);

// Set all of the user permissions for the model (this will replace
// all current permissions).
setAllUserPermissions({
  "alice": { "read": true, "write": true, "remove": true, "manage": true },
  "bob": { "read": false, "write": false, "remove": false, "manage": false }
});

// Set the permissions for a specific user.
setUserPermissions(
  "alice", 
  { "read": true, "write": true, "remove": true, "manage": true }
);

// Remove the permissions for a specific user.
removeUserPermissions("bob");
```
