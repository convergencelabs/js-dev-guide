# Activity Participation

To interact with the activity you must join it first.  Once joined, you become a participant of that activity.  Each session that joins the activity will be a unique participant.  A session can only join an activity once.  That is, if a session tries to join an activity it has already joined, the API will throw an error.

## Joining

The first step in interacting with an activity isto join it.  Joining signifies participation in the activity.  An activity can be joined by using the `ActivityService.join(activityId)`:

```js
domain.activities().join("myProject").then((activity) => {
  // interact with the activity.
});
```

When a user joins the activity, other users who have also joined the activity will be notified.

## Leaving
When a user no longer wishes to participate in an activity, they can leave it by using the `Activity.leave()` method:

```js
activity.leave();
```

When a user leaves the activity, the other participants of the activity will be notified.

## Getting Participants
Once joined, consumers will likely want to know who the other participants in the activity are.  This can be accomplished using the `participants()` and `participant(sessionId)` methods.

```js
// returns an array of participants
const participants = activity.participants();

// get a specific participant by sessionId
const participant1 = activity.participant("someSessionId");
```

## Participation Events

An `Activity` object can emit two events that are useful for determining participants' presence over time.

| Event | Description |
| --- | --- |
| "session_joined" | Emitted when a new session joins the activity |
| "session_left" | Emitted when a previously joined session leaves the activity |

### Examples

```js
activity.on("session_joined", (e) => {
  console.log(e.participant); // ActivityParticipant object
});


activity.on("session_left", (e) => {
  console.log(e.sessionId);
});
```
