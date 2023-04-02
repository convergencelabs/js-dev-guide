# Chat Overview

The Chat API allows users to communicate via text embedded directly within the application. The main entry point to the Chat API is the [ChatService](https://api-docs.convergence.io/classes/chat.chatservice.html).  The `ChatService` can be obtained from the domain using the `chat()` method.

```js
const chatService = domain.chat();
```

Convergence provides a few different constructs depending on the particular type of chat your application might need:

* Chat Rooms are analogous to an old-school IRC or web-based chat room.  Presence is per-session rather than per-user.  You join one and listen to events.  If you're not currently joined, you won't receive any events.
* Chat Channels are analogous to a channel in Slack.  When you join a channel, you are a "member" of that channel for its lifetime, regardless of if you are currently connected (online) or not.  
* Direct Chats are analagous to "Direct Messages" in Slack, which can be between two or more named users.  Members cannot be added or removed after the Chat is created.

## Comparison matrix

| Chat construct  | Per-session or user?[^1] | Membership options | Online-dependent members?[^2] |
|--------------------------------------|---------|-------------------|-----|
| [`ChatRoom`](/chat/rooms.html)       | session | public-only       | yes | 
| [`ChatChannel`](/chat/channels.html) | user    | public or private | no  | 
| [`DirectChat`](/chat/direct.html)    | user    | fixed [^3]        | no  | 


## Chat Info

Users may wish to obtain [information](https://api-docs.convergence.io/interfaces/chat.ichatinfo.html) about the particular chat, such as the current members or the timestamp of the most recent event.  This information can be obtained from the room via several methods.

```js
chatService.join('myRoomID').then(room => {
  console.log(room.info().members; // ChatMember[]
  console.log(room.info().members[0].user.username()); // jimbob
  console.log(room.info().lastEventTime) // "Wed Sep 04 2019 14:42:11 GMT-0600 (Mountain Daylight Time)"

  room.getHistory({
    offset: room.info().lastEventNumber,
    limit: 25,
    eventFilter: ["message"]
  }).then(events => {
    events.filter(event => event.type === "message").forEach(event => {
      this.appendMessage(event);
    });
  });
});
```

## Permissions

In most chat scenarios, there is a hierarchy of users that determines who has the appropriate permissions to do what.  For instance, you probably only want a `Chat`'s creator to be able to delete it.  Therefore it's essential to set the permissions of a chat after it is created:

```js
chatService.create('myRoomId').then(chatId => {
  const permissionManager = chatService.permissions(chatId);
  ...
});

```

See [Permissions](/chat/permissions.html) for further information and examples.

[^1]: See [here](/overview/sessions.html) for the distinction between users and sessions.
[^2]: Whereas `room.info().members()` will return *all* members for a `ChatChannel` and `DirectChat`, it will only return a `ChatRoom`'s currently-online members.
[^3]: [Direct chats](/chat/direct.html) have a fixed membership, in that the members specified at the time of creation cannot be changed.