# Chat Channels

Chat channels are similar to chat rooms in that there are a variable number of participants.  The main difference is that channels can be either `public` or `private`, and members are considered part of a [ChatChannel](https://api-docs.convergence.io/classes/chat.chatchannel.html) even if they're not currently connected to the channel.  

Note that a particular user can only join once, after which subsequent joins will result in an error.  An already joined user can subsequently load a `ChatChannel` using `ChatService.get(chatId)`.

Channels have a similar analogue in Slack.

```js
// Create a channel
chatService.create({
  type: "channel", 
  membership: "private",
  name: "Founders",
  topic: "Super secret biz stuff" 
}).then(chatId => {
  // Join the channel
  return chatService.join(chatId);
}).then(channel => {
  console.log("Joined");

  channel.add("cameron");

  // Listen for incoming messages
  channel.on("message", (evt) => {
    console.log(evt.message); // "Dude, startups are hard!"
  });

  // Send a message
  channel.send("I thought I had an idea going in.  But...man.");
  
  // Leave the channel.
  chatService.leave(channel.info().chatId);
}).catch(e => {
  console.log(e);
});
```