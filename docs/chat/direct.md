# Direct Chat

Direct chats are between a fixed set of users that are specified on creation.  Members cannot be added or removed.  For this reason, an immutable additional `otherUsers` property is available on the [DirectChat](https://docs.convergence.io/js-api/classes/chat.directchat.html) instance.

Unlike channels or rooms, direct chats do not have any metadata like a `name` or `topic`.

Note that you cannot "leave" a direct chat.  Once created, the communication line between members is open, until the chat is explictly `removed` via the [ChatService](https://docs.convergence.io/js-api/classes/chat.chatservice.html).

Direct chats have a similar analogue in Slack's "direct messages".

```js
// Create a chat
chatService.directChat(['jimbob', 'blarbara']).then(chat => {
  console.log("Joined");

  // Send a message
  chat.send("Welcome y'all!");

  // Listen for incoming messages
  chat.on("message", (evt) => {
    console.log(evt.message, evt.user.username); // "Ahoy there jimbob"
  });
  
  chatService.leave(chat.info().chatId) // Error

  return chatService.remove(chat.info().chatId);  
}).then(() => {
  console.log("So long");
}).catch(e => {
  console.log(e);
});
```