# Chat Rooms

Chat rooms provide a group messaging capability. Chat rooms are identified by a unique id.  Users may join and leave the chat room.  While a user is joined to a chat room, they will receive messages sent within the room.  Once they leave the room, they will no longer receive messages or be in the list of members.  A user must be joined to the room to send a message in it.  Joining happens asynchronously via a Promise -- on a successful join, the promise will resolve with the joined `ChatRoom`.  From there, clients can send and receive messages.

Here is an example of both creating and joining a room.  For chat rooms, most users are probably only interested in joining an existing room.

```js
// Create a room 
chatService.create({
  // a unique ID for the chat room
  id: 'group-chat-1', 

  // either "room" or "channel"
  type: "room", 

  // Either "public" or "private".  Room chats must be public
  membership: "public", 

  // by default, if a room with this ID already exists, an Error is thrown.  Setting
  // this flag to true avoids this error.  
  ignoreExistsError: true
}).then(chatId => {
  // Join the room
  return chatService.join(chatId);
}).then(room => {
  console.log("Joined");

  // Listen for incoming messages
  room.on("message", (evt) => {
    console.log(evt.message); // "Did you finish the dev guide yet?"
  });

  // Send a message
  room.send("OMG no. So much text. I'm dreaming in Markdown");
  ... 
  
  // Leave the room.
  chatService.leave(room.info().chatId);
}).catch(e => {
  console.log(e);
});
```
