# Chat Permissions

Permissions for specific chat rooms can be set at a few different levels: For anybody ("world"), a group of users, or a specific user.  More-specific permissions will override less-specific ones, so a user's explicit permission would override the group's permission which the user is in, which would itself override any world permission for a `Chat`.

The [ChatPermissionsManager](https://api-docs.convergence.io/classes/chat.chatpermissionmanager.html) provides a variety of functions to get or set permissions for a specific user, group, or globally ("world").

By default, a room's creator is assigned all permissions.

The list of configurable permissions are:
```
"create_chat"
"remove_chat"
"join_chat"
"leave_chat"
"add_chat_user"
"remove_chat_user"
"set_chat_name"
"set_topic"
"manage_chat_permissions"
```

## Resolved vs explicit permissions

The current user's permissions can be queried with `chatPermissionManager.getPermissions()`.  This represents the *resolved* set of permissions, meaning the computed permissions for this user after factoring in any world, group and user permissions.  All other methods on the `ChatPermissionManager` pertain to explicit permissions, and could be used to e.g. populate and modify a `<table>` of permissions per-user or per-group.

```js
chatService.create('myRoomId').then(chatId => {
  let manager = chatService.permissions(chatId);

  manager.getPermissions() // ["create_chat", "remove_chat", "join_chat", "leave_chat", "add_chat_user", "remove_chat_user", "set_chat_name", "set_topic", "manage_chat_permissions"]

  manager.setWorldPermissions(["join_chat", "leave_chat", "add_chat_user", "set_topic"]);
});
```
