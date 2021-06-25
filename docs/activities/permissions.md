# Activity Permissions

Activities follow a similar permission scheme as other parts of the system. Permissions can be assigned to:

* **Users**: Specific permissions for each user.
* **Groups**: Apply to any users in the group.
* **World**: Apply all users in the system.

The table below shows the available permissions for Activities.

| Permission | Description |
| --- | --- |
| "join" | Permits users to join an activity |
| "lurk" | Permits user to join an activity in lurk mode |
| "view_state" | Permits users to view other participants state |
| "set_state" | Permits users to share state in the activity |
| "manage" | Permits users to set permissions for the activity |
| "remove" | Permits users to delete the activity |

Permissions can be set on a joined activity by using the `Activity.permissions()` method to obtain an `ActivityPermissionManager`:

```js
const permissionsManager = activity.permissions();
permissionsManager
  .setUserPermissions({"testUser": ["join", "view_state", "set_state"]})
  .then(() => console.log("permissions set"));
```

Please refer to the API documentation for available permissions operations.