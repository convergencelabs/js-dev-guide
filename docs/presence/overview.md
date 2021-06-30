# Presence
All collaborative applications require that a user be able to tell who else is available to work and communicate with. In Convergence, a Presence API provides this ability.  The most common example of presence is the "buddy list" concept (remember AOL Instant Messenger?), where users can see who is online, who is available, and what their status is.  However, various applications implement presence differently, so the Convergence Presence API was designed to be able to handle most likely scenarios.

# Availability
Availability indicates whether someone is reachable in the system.  At the moment, this roughly equates to whether or not someone is connected to the system or not.  Since a user may have more than one session, for a user to be available she only needs to have one session that is available.  If a user has no sessions, she will not be available.

> Takeaway: Presence is per *user*, not per session!

# User Presence
Most of the Presence API centers around getting the status of one or more users.  When obtaining the presence for a user, the result is a UserPresence object:

```TypeScript
class UserPresence {
  username: string;
  isAvailable: boolean;
  state: Map<string, any>;
}
```

## PresenceState
Note that each UserPresence object has a state map.  Presence state is global across all sessions of a particular user.  Any session can set state, but that state is distributed across all sessions for that user.

# Streaming vs. One Time Requests
In some cases, users may wish to ask a one-time question inquiring about the current presence
of another user.  In other cases, users may be interested in any changes to another user's presence that occur in the future.  Most methods in the presence API allow for both options.

# Own Presence
The Presence Service allows any session to set the presence state for that user.  If the
user is connected across multiple sessions, that the change to the user's presence will
be distributed to all connected sessions.  The example below shows how you can set and
monitor the presence for the local user.

## Publishing State
State is published as key-value pairs. The API will accept any key and value combinations.

```JavaScript
var service = domain.presence();
service.setState("status", "away");
```

## Clearing State
You may wish to clear a previously set state.  Rather than publishing with an empty value
such as undefined or null, use the clear method.

```JavaScript
var service = domain.presence();
service.removeState("status");
```

## Listening
To listen for other sessions of the same user triggering presence state changes, simply get the presence for the local user as a stream and listen to it as you would any other user's presence.

```JavaScript
var service = domain.presence();
service.events().subscribe((presence) => {
  console.log('New state:', presence.state());
});
```

# Other Users' Presence

## Getting A User's Presence
```JavaScript
var service = domain.presence();
service.presence("username1").then((presence) => {
  console.log(presence); // UserPresence object
});
```

## Getting Multiple Users' Presences
```JavaScript
var service = domain.presence();
service.presence(["username1", "username2"]).then((presences) => {
  presences.forEach((presence) => {
    console.log(presence);
  });
});
```


## Streaming Presence
Use the `subscribe` method to obtain the current state of the user's presence.  From that `UserPresenceSubscription` object, you can subscribe to an Observable to subscribe to additional changes.

```JavaScript
import { distinctUntilKeyChanged } from 'rxjs/operators';

var service = domain.presence();
// Get notified when the user's availability changes
service.subscribe("username1").then((presenceSubscription) => {
  if(!presenceSubscription.available) {
    console.log('waiting...');
    presenceSubscription.asObservable()
      .pipe(
        distinctUntilKeyChanged('available')
      )
      .subscribe((presence) => {
        console.log('username1 here now?', presence.available);
      });
  }
});
```

## Streaming Presence For Multiple Users
Similar to above, but returns an array of `UserPresenceSubscription` objects.  You can use the merge operator in RxJs to combine them.

```JavaScript
var service = domain.presence();

// Get notified when anything about a presence changes
service.subscribe(['username1', 'username2']).then((subscriptions) => {
  const streams = subscriptions.map((sub) => {return sub.asObservable()});
  Rx.Observable.merge(streams)
    .subscribe((presence) => {
      console.log('Is', presence.username, 'available?', presence.available);
    });
});
```
